import importlib.util
import os
from pathlib import Path
import unittest
from unittest.mock import Mock, patch

MODULE_PATH = Path(__file__).resolve().parents[1] / "main.py"
os.environ.setdefault("GOOGLE_CLOUD_PROJECT", "demo-aevum")

spec = importlib.util.spec_from_file_location("preservation_processor", MODULE_PATH)
processor = importlib.util.module_from_spec(spec)
spec.loader.exec_module(processor)


class CloudEvent(dict):
    def __init__(self, data, event_id="event-1"):
        super().__init__(id=event_id)
        self.data = data


class Snapshot:
    def __init__(self, exists, data=None):
        self.exists = exists
        self._data = data or {}

    def to_dict(self):
        return self._data


def firestore_for(snapshot):
    media_ref = Mock()
    media_ref.get.return_value = snapshot
    client = Mock()
    client.collection.return_value.document.return_value = media_ref
    return client, media_ref


class PreservationPipelineTest(unittest.TestCase):
    def setUp(self):
        processor.storage_client = None
        processor.firestore_client = None

    def event(self, name, **overrides):
        data = {
            "bucket": "demo-media",
            "name": name,
            "generation": "42",
            "contentType": "image/jpeg",
        }
        data.update(overrides)
        return CloudEvent(data)

    def test_accepts_only_canonical_original_paths(self):
        self.assertEqual(
            processor.parse_original_path(
                "families/family-a/media/media-a/original/photo.jpg"
            ),
            ("family-a", "media-a", "photo.jpg"),
        )
        rejected = [
            "families/family-a/media/media-a/derived/42/display.webp",
            "families/family-a/members/person-a/photo.jpg",
            "uploads/user-a/photo.jpg",
            "families/family-a/media/media-a/original/nested/photo.jpg",
        ]
        for path in rejected:
            with self.subTest(path=path):
                self.assertIsNone(processor.parse_original_path(path))

    def test_ignored_objects_do_not_initialize_cloud_clients(self):
        with (
            patch.object(processor, "get_firestore_client") as firestore_client,
            patch.object(processor, "get_storage_client") as storage_client,
        ):
            processor.process_upload(
                self.event(
                    "families/family-a/media/media-a/derived/42/display.webp"
                )
            )

        firestore_client.assert_not_called()
        storage_client.assert_not_called()

    def test_orphan_original_is_left_untouched_and_not_downloaded(self):
        client, media_ref = firestore_for(Snapshot(False))
        with (
            patch.object(processor, "get_firestore_client", return_value=client),
            patch.object(processor, "get_storage_client") as storage_client,
        ):
            processor.process_upload(
                self.event(
                    "families/family-a/media/media-a/original/photo.jpg"
                )
            )

        media_ref.get.assert_called_once_with()
        media_ref.update.assert_not_called()
        storage_client.assert_not_called()

    def test_cross_family_path_mismatch_is_rejected_before_storage_access(self):
        client, media_ref = firestore_for(
            Snapshot(True, {"familyId": "family-b", "status": "uploaded"})
        )
        with (
            patch.object(processor, "get_firestore_client", return_value=client),
            patch.object(processor, "get_storage_client") as storage_client,
        ):
            processor.process_upload(
                self.event(
                    "families/family-a/media/media-a/original/photo.jpg"
                )
            )

        media_ref.update.assert_not_called()
        storage_client.assert_not_called()

    def test_same_generation_processed_event_is_idempotent(self):
        client, media_ref = firestore_for(
            Snapshot(
                True,
                {
                    "familyId": "family-a",
                    "status": "processed",
                    "processing": {"sourceGeneration": "42"},
                },
            )
        )
        with (
            patch.object(processor, "get_firestore_client", return_value=client),
            patch.object(processor, "get_storage_client") as storage_client,
        ):
            processor.process_upload(
                self.event(
                    "families/family-a/media/media-a/original/photo.jpg"
                )
            )

        media_ref.update.assert_not_called()
        storage_client.assert_not_called()

    def test_upload_if_absent_uses_create_only_precondition(self):
        bucket = Mock()
        bucket.name = "demo-media"
        blob = bucket.blob.return_value

        returned = processor.upload_if_absent(
            bucket,
            "families/family-a/media/media-a/derived/42/display.webp",
            processor.io.BytesIO(b"image"),
            "image/webp",
        )

        self.assertIs(returned, blob)
        blob.upload_from_file.assert_called_once()
        self.assertEqual(
            blob.upload_from_file.call_args.kwargs["if_generation_match"],
            0,
        )

    def test_archive_copy_pins_source_generation_and_create_only_destination(self):
        source_bucket = Mock()
        source_blob = Mock()
        archive_bucket = Mock()
        archive_bucket.name = "demo-archive"

        processor.archive_original(
            source_bucket,
            source_blob,
            archive_bucket,
            "families/family-a/media/media-a/originals/42/photo.jpg",
            "42",
        )

        source_bucket.copy_blob.assert_called_once_with(
            source_blob,
            archive_bucket,
            new_name=(
                "families/family-a/media/media-a/"
                "originals/42/photo.jpg"
            ),
            source_generation=42,
            if_source_generation_match=42,
            if_generation_match=0,
        )


if __name__ == "__main__":
    unittest.main()
