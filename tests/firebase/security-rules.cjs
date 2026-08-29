// Contract coverage target: docs/data-contract.md (v1.0.0)
const fs = require("node:fs");
const {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} = require("@firebase/rules-unit-testing");
const {
  doc,
  getDoc,
  setDoc,
  updateDoc,
  writeBatch,
} = require("firebase/firestore");
const { getBytes, ref, uploadBytes } = require("firebase/storage");

const projectId = process.env.GCLOUD_PROJECT || "demo-aevum";
let testEnv;
let failures = 0;

const familyId = "family-a";
const ownerId = "owner";
const editorId = "editor";
const viewerId = "viewer";
const outsiderId = "outsider";

async function run(name, test) {
  try {
    await test();
    console.log(`PASS ${name}`);
  } catch (error) {
    failures += 1;
    console.error(`FAIL ${name}`);
    console.error(error);
  }
}

async function seed() {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();

    await setDoc(doc(db, "families", familyId), {
      name: "Test Family",
      description: "Rules test fixture",
      ownerId,
      createdBy: ownerId,
      collaboratorIds: [ownerId, editorId, viewerId],
      memberCount: 0,
      createdAt: "fixture-created",
      updatedAt: "fixture-updated",
    });

    await setDoc(
      doc(db, "families", familyId, "collaborators", editorId),
      {
        userId: editorId,
        role: "editor",
        status: "active",
        invitedBy: ownerId,
        createdAt: "fixture-created",
        updatedAt: "fixture-updated",
      },
    );

    await setDoc(
      doc(db, "families", familyId, "collaborators", viewerId),
      {
        userId: viewerId,
        role: "viewer",
        status: "active",
        invitedBy: ownerId,
        createdAt: "fixture-created",
        updatedAt: "fixture-updated",
      },
    );

    await setDoc(doc(db, "users", ownerId), {
      uid: ownerId,
      displayName: "Owner",
      createdAt: "fixture-created",
      updatedAt: "fixture-updated",
    });

    await setDoc(doc(db, "media_items", "seeded-media"), {
      familyId,
      createdBy: ownerId,
      uploadedBy: ownerId,
      title: "Seeded",
      description: "",
      tags: [],
      memberIds: [],
      status: "processed",
      aiStatus: "completed",
      storage: { displayGsUri: "gs://test/display.webp" },
      createdAt: "fixture-created",
      updatedAt: "fixture-updated",
    });

    await setDoc(doc(db, "media_items", "storage-media"), {
      familyId,
      createdBy: ownerId,
      uploadedBy: ownerId,
      title: "Storage fixture",
      description: "",
      tags: [],
      memberIds: [],
      status: "uploading",
      aiStatus: "waiting",
      storage: {},
      createdAt: "fixture-created",
      updatedAt: "fixture-updated",
    });
  });
}

async function main() {
  testEnv = await initializeTestEnvironment({
    projectId,
    firestore: { rules: fs.readFileSync("firestore.rules", "utf8") },
    storage: { rules: fs.readFileSync("storage.rules", "utf8") },
  });

  await seed();

  const owner = testEnv.authenticatedContext(ownerId);
  const editor = testEnv.authenticatedContext(editorId);
  const viewer = testEnv.authenticatedContext(viewerId);
  const outsider = testEnv.authenticatedContext(outsiderId);
  const admin = testEnv.authenticatedContext("platform-admin", { admin: true });
  const anonymous = testEnv.unauthenticatedContext();

  await run("anonymous cannot read a family", async () => {
    await assertFails(getDoc(doc(anonymous.firestore(), "families", familyId)));
  });

  await run("owner/editor/viewer can read their family", async () => {
    await assertSucceeds(getDoc(doc(owner.firestore(), "families", familyId)));
    await assertSucceeds(getDoc(doc(editor.firestore(), "families", familyId)));
    await assertSucceeds(getDoc(doc(viewer.firestore(), "families", familyId)));
  });

  await run("outsider cannot read family but platform admin can", async () => {
    await assertFails(getDoc(doc(outsider.firestore(), "families", familyId)));
    await assertSucceeds(getDoc(doc(admin.firestore(), "families", familyId)));
  });

  await run("viewer cannot create genealogy data but editor can", async () => {
    const viewerPerson = doc(viewer.firestore(), "family_members", "viewer-person");
    await assertFails(
      setDoc(viewerPerson, {
        familyId,
        createdBy: viewerId,
        name: "Denied",
        role: "Relative",
        parentIds: [],
        spouseIds: [],
        childIds: [],
        createdAt: "viewer-created",
        updatedAt: "viewer-created",
      }),
    );

    const editorPerson = doc(editor.firestore(), "family_members", "editor-person");
    await assertSucceeds(
      setDoc(editorPerson, {
        familyId,
        createdBy: editorId,
        name: "Allowed",
        role: "Relative",
        parentIds: [],
        spouseIds: [],
        childIds: [],
        createdAt: "editor-created",
        updatedAt: "editor-created",
      }),
    );
  });

  await run("client cannot self-elevate profile to admin", async () => {
    await assertFails(
      updateDoc(doc(owner.firestore(), "users", ownerId), {
        admin: true,
        updatedAt: "attempted-escalation",
      }),
    );
  });

  await run("owner can create only an uploading media reservation", async () => {
    await assertSucceeds(
      setDoc(doc(owner.firestore(), "media_items", "reservation-ok"), {
        familyId,
        createdBy: ownerId,
        uploadedBy: ownerId,
        title: "Upload",
        description: "",
        tags: [],
        memberIds: [],
        status: "uploading",
        aiStatus: "waiting",
        storage: {},
        createdAt: "reservation-created",
        updatedAt: "reservation-created",
      }),
    );

    await assertFails(
      setDoc(doc(owner.firestore(), "media_items", "reservation-spoof"), {
        familyId,
        createdBy: ownerId,
        uploadedBy: ownerId,
        title: "Spoof",
        description: "",
        tags: [],
        memberIds: [],
        status: "processed",
        aiStatus: "completed",
        storage: { displayGsUri: "gs://spoof" },
        createdAt: "reservation-created",
        updatedAt: "reservation-created",
      }),
    );
  });

  await run("editor cannot spoof backend-owned media processing fields", async () => {
    await assertFails(
      updateDoc(doc(editor.firestore(), "media_items", "seeded-media"), {
        processing: { eventId: "spoof" },
        updatedAt: "spoof-attempt",
      }),
    );
  });

  await run("owner can finalize a reserved upload through the allowed transition", async () => {
    await assertSucceeds(
      updateDoc(doc(owner.firestore(), "media_items", "reservation-ok"), {
        status: "uploaded",
        photoUrl: "https://example.test/original",
        thumbnailUrl: null,
        storage: {
          originalPath:
            "families/family-a/media/reservation-ok/original/photo.jpg",
        },
        imageMetadata: { width: 100, height: 100 },
        uploadCompletedAt: "upload-finished",
        updatedAt: "upload-finished",
      }),
    );
  });

  await run("active collaborator creation must be atomic with family membership", async () => {
    const nonAtomicRef = doc(
      owner.firestore(),
      "families",
      familyId,
      "collaborators",
      "non-atomic-viewer",
    );
    await assertFails(
      setDoc(nonAtomicRef, {
        userId: "non-atomic-viewer",
        role: "viewer",
        status: "active",
        invitedBy: ownerId,
        createdAt: "membership-created",
        updatedAt: "membership-created",
      }),
    );

    const db = owner.firestore();
    const batch = writeBatch(db);
    batch.update(doc(db, "families", familyId), {
      collaboratorIds: [ownerId, editorId, viewerId, "atomic-viewer"],
      updatedAt: "membership-updated",
    });
    batch.set(
      doc(db, "families", familyId, "collaborators", "atomic-viewer"),
      {
        userId: "atomic-viewer",
        role: "viewer",
        status: "active",
        invitedBy: ownerId,
        createdAt: "membership-created",
        updatedAt: "membership-created",
      },
    );
    await assertSucceeds(batch.commit());
  });

  const originalObjectPath =
    "families/family-a/media/storage-media/original/photo.jpg";

  await run("viewer cannot upload a reserved original", async () => {
    await assertFails(
      uploadBytes(ref(viewer.storage(), originalObjectPath), new Uint8Array([1, 2, 3]), {
        contentType: "image/jpeg",
      }),
    );
  });

  await run("owner can upload a reserved original", async () => {
    await assertSucceeds(
      uploadBytes(ref(owner.storage(), originalObjectPath), new Uint8Array([1, 2, 3]), {
        contentType: "image/jpeg",
      }),
    );
  });

  await run("original media cannot be overwritten", async () => {
    await assertFails(
      uploadBytes(ref(owner.storage(), originalObjectPath), new Uint8Array([4, 5, 6]), {
        contentType: "image/jpeg",
      }),
    );
  });

  await run("family viewer can read media object but outsider cannot", async () => {
    const objectPath =
      "families/family-a/media/storage-media/original/photo.jpg";
    await assertSucceeds(getBytes(ref(viewer.storage(), objectPath)));
    await assertFails(getBytes(ref(outsider.storage(), objectPath)));
  });

  await testEnv.cleanup();

  if (failures > 0) {
    console.error(`${failures} Firebase Security Rules test(s) failed.`);
    process.exitCode = 1;
  } else {
    console.log("All Firebase Security Rules tests passed.");
  }
}

main().catch(async (error) => {
  console.error(error);
  if (testEnv) await testEnv.cleanup();
  process.exitCode = 1;
});
