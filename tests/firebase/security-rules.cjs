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
const { deleteObject, getBytes, ref, uploadBytes } = require("firebase/storage");

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

  await run("new profile cannot create client-controlled privileges", async () => {
    const newUserId = "new-profile-user";
    const newUser = testEnv.authenticatedContext(newUserId);

    await assertFails(
      setDoc(doc(newUser.firestore(), "users", newUserId), {
        uid: newUserId,
        email: "new@example.test",
        displayName: "New User",
        admin: true,
        createdAt: "profile-created",
        updatedAt: "profile-created",
      }),
    );

    await assertSucceeds(
      setDoc(doc(newUser.firestore(), "users", newUserId), {
        uid: newUserId,
        email: "new@example.test",
        displayName: "New User",
        createdAt: "profile-created",
        updatedAt: "profile-created",
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

  await run("cross-family records are unreadable and unwritable", async () => {
    await testEnv.withSecurityRulesDisabled(async (context) => {
      await setDoc(doc(context.firestore(), "families", "family-b"), {
        name: "Other Family",
        ownerId: outsiderId,
        createdBy: outsiderId,
        collaboratorIds: [outsiderId],
        createdAt: "fixture-created",
        updatedAt: "fixture-updated",
      });
      await setDoc(doc(context.firestore(), "family_members", "family-b-person"), {
        familyId: "family-b",
        createdBy: outsiderId,
        name: "Other Person",
        createdAt: "fixture-created",
        updatedAt: "fixture-updated",
      });
    });

    await assertFails(
      getDoc(doc(owner.firestore(), "family_members", "family-b-person")),
    );
    await assertFails(
      setDoc(doc(owner.firestore(), "family_members", "family-b-write"), {
        familyId: "family-b",
        createdBy: ownerId,
        name: "Cross-family write",
        createdAt: "attempted",
        updatedAt: "attempted",
      }),
    );
  });

  await run("family ownership and creation identity are immutable", async () => {
    await assertFails(
      updateDoc(doc(owner.firestore(), "families", familyId), {
        ownerId: editorId,
        updatedAt: "attempted-transfer",
      }),
    );
    await assertFails(
      updateDoc(doc(owner.firestore(), "families", familyId), {
        createdBy: editorId,
        updatedAt: "attempted-reassignment",
      }),
    );
  });

  await run("genealogical identity fields cannot be reassigned", async () => {
    await assertFails(
      updateDoc(doc(editor.firestore(), "family_members", "editor-person"), {
        familyId: "family-b",
        updatedAt: "attempted-family-change",
      }),
    );
    await assertFails(
      updateDoc(doc(editor.firestore(), "family_members", "editor-person"), {
        createdBy: ownerId,
        updatedAt: "attempted-creator-change",
      }),
    );
    await assertFails(
      updateDoc(doc(editor.firestore(), "family_members", "editor-person"), {
        createdAt: "attempted-created-at-change",
        updatedAt: "attempted-created-at-change",
      }),
    );
  });

  await run("media ownership fields cannot be reassigned", async () => {
    await assertFails(
      updateDoc(doc(owner.firestore(), "media_items", "seeded-media"), {
        familyId: "family-b",
        updatedAt: "attempted-family-change",
      }),
    );
    await assertFails(
      updateDoc(doc(owner.firestore(), "media_items", "seeded-media"), {
        uploadedBy: editorId,
        updatedAt: "attempted-uploader-change",
      }),
    );
    await assertFails(
      updateDoc(doc(owner.firestore(), "media_items", "seeded-media"), {
        createdBy: editorId,
        updatedAt: "attempted-creator-change",
      }),
    );
  });

  await run("viewer cannot mutate family content", async () => {
    await assertFails(
      updateDoc(doc(viewer.firestore(), "media_items", "seeded-media"), {
        title: "Denied",
        updatedAt: "viewer-attempt",
      }),
    );
    await assertFails(
      updateDoc(doc(viewer.firestore(), "families", familyId), {
        name: "Denied",
        updatedAt: "viewer-attempt",
      }),
    );
  });

  await run("collaborator roles are owner-managed and constrained", async () => {
    await assertFails(
      updateDoc(
        doc(editor.firestore(), "families", familyId, "collaborators", viewerId),
        { role: "editor", updatedAt: "editor-attempt" },
      ),
    );
    await assertFails(
      updateDoc(
        doc(owner.firestore(), "families", familyId, "collaborators", viewerId),
        { role: "owner", updatedAt: "invalid-role" },
      ),
    );
  });

  await run("AI tasks are user-scoped and identity is immutable", async () => {
    await assertSucceeds(
      setDoc(doc(owner.firestore(), "ai_tasks", "owner-task"), {
        userId: ownerId,
        status: "pending",
        createdAt: "task-created",
        updatedAt: "task-created",
      }),
    );
    await assertFails(
      getDoc(doc(outsider.firestore(), "ai_tasks", "owner-task")),
    );
    await assertFails(
      setDoc(doc(outsider.firestore(), "ai_tasks", "spoofed-task"), {
        userId: ownerId,
        status: "pending",
        createdAt: "attempted",
        updatedAt: "attempted",
      }),
    );
    await assertFails(
      updateDoc(doc(outsider.firestore(), "ai_tasks", "owner-task"), {
        status: "completed",
        updatedAt: "outsider-attempt",
      }),
    );
    await assertFails(
      updateDoc(doc(owner.firestore(), "ai_tasks", "owner-task"), {
        userId: outsiderId,
        updatedAt: "attempted-transfer",
      }),
    );
  });

  await run("audit and undeclared collections deny client access", async () => {
    await testEnv.withSecurityRulesDisabled(async (context) => {
      await setDoc(doc(context.firestore(), "audit_events", "seeded-event"), {
        eventType: "fixture",
        actorType: "system",
        actorId: "fixture",
        occurredAt: "fixture-created",
        targetType: "media",
        targetId: "seeded-media",
        metadata: {},
      });
      await setDoc(doc(context.firestore(), "undeclared", "seeded-record"), {
        value: "fixture",
      });
    });

    await assertFails(
      getDoc(doc(owner.firestore(), "audit_events", "seeded-event")),
    );
    await assertSucceeds(
      getDoc(doc(admin.firestore(), "audit_events", "seeded-event")),
    );
    await assertFails(
      getDoc(doc(owner.firestore(), "undeclared", "seeded-record")),
    );
    await assertFails(
      setDoc(doc(owner.firestore(), "audit_events", "client-event"), {
        eventType: "spoof",
        actorId: ownerId,
        occurredAt: "attempted",
      }),
    );
    await assertFails(
      setDoc(doc(owner.firestore(), "undeclared", "record"), {
        value: "denied",
      }),
    );
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

  await run("original upload rejects a mismatched family reservation", async () => {
    await testEnv.withSecurityRulesDisabled(async (context) => {
      await setDoc(doc(context.firestore(), "media_items", "family-b-storage"), {
        familyId: "family-b",
        createdBy: ownerId,
        uploadedBy: ownerId,
        status: "uploading",
        aiStatus: "waiting",
        storage: {},
        createdAt: "fixture-created",
        updatedAt: "fixture-updated",
      });
    });
    const spoofedPath =
      "families/family-a/media/family-b-storage/original/spoof.jpg";
    await assertFails(
      uploadBytes(
        ref(owner.storage(), spoofedPath),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/jpeg" },
      ),
    );
  });

  await run("original upload enforces image type and size", async () => {
    const invalidTypePath =
      "families/family-a/media/storage-media/original/not-image.txt";
    await assertFails(
      uploadBytes(
        ref(owner.storage(), invalidTypePath),
        new Uint8Array([1, 2, 3]),
        { contentType: "text/plain" },
      ),
    );

    const oversizedPath =
      "families/family-a/media/storage-media/original/oversized.jpg";
    await assertFails(
      uploadBytes(
        ref(owner.storage(), oversizedPath),
        new Uint8Array(10 * 1024 * 1024 + 1),
        { contentType: "image/jpeg" },
      ),
    );
  });

  await run("clients cannot write processor-owned derivatives", async () => {
    const derivativePath =
      "families/family-a/media/storage-media/derived/source-generation/display.webp";
    await assertFails(
      uploadBytes(
        ref(owner.storage(), derivativePath),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/webp" },
      ),
    );
  });

  await run("member photos enforce family roles and isolation", async () => {
    const memberPath = "families/family-a/members/editor-person/photo.jpg";
    await assertFails(
      uploadBytes(
        ref(viewer.storage(), memberPath),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/jpeg" },
      ),
    );
    await assertSucceeds(
      uploadBytes(
        ref(editor.storage(), memberPath),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/jpeg" },
      ),
    );
    await assertSucceeds(getBytes(ref(viewer.storage(), memberPath)));
    await assertFails(getBytes(ref(outsider.storage(), memberPath)));
    await assertFails(deleteObject(ref(viewer.storage(), memberPath)));
    await assertSucceeds(deleteObject(ref(editor.storage(), memberPath)));
  });

  await run("profile images are isolated to their user", async () => {
    const profilePath = "users/owner/profile/avatar.jpg";
    await assertFails(
      uploadBytes(
        ref(outsider.storage(), profilePath),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/jpeg" },
      ),
    );
    await assertSucceeds(
      uploadBytes(
        ref(owner.storage(), profilePath),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/jpeg" },
      ),
    );
    await assertFails(getBytes(ref(outsider.storage(), profilePath)));
    await assertSucceeds(getBytes(ref(owner.storage(), profilePath)));
    await assertSucceeds(deleteObject(ref(owner.storage(), profilePath)));
  });

  await run("AI staging objects are user-scoped and constrained", async () => {
    const stagingPath = "ai-processing/owner/task-a/input.jpg";
    await assertFails(
      uploadBytes(
        ref(outsider.storage(), stagingPath),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/jpeg" },
      ),
    );
    await assertSucceeds(
      uploadBytes(
        ref(owner.storage(), stagingPath),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/jpeg" },
      ),
    );
    await assertFails(getBytes(ref(outsider.storage(), stagingPath)));
    await assertSucceeds(getBytes(ref(owner.storage(), stagingPath)));
    await assertFails(deleteObject(ref(outsider.storage(), stagingPath)));
    await assertSucceeds(deleteObject(ref(owner.storage(), stagingPath)));
  });

  await run("managed public assets require authentication to read and admin to write", async () => {
    const publicPath = "public/release/banner.webp";
    await assertFails(
      uploadBytes(
        ref(owner.storage(), publicPath),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/webp" },
      ),
    );
    await assertSucceeds(
      uploadBytes(
        ref(admin.storage(), publicPath),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/webp" },
      ),
    );
    await assertFails(getBytes(ref(anonymous.storage(), publicPath)));
    await assertSucceeds(getBytes(ref(owner.storage(), publicPath)));
    await assertFails(deleteObject(ref(owner.storage(), publicPath)));
    await assertSucceeds(deleteObject(ref(admin.storage(), publicPath)));
  });

  await run("family original deletion follows write roles", async () => {
    await assertFails(
      deleteObject(ref(viewer.storage(), originalObjectPath)),
    );
    await assertSucceeds(
      deleteObject(ref(editor.storage(), originalObjectPath)),
    );
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
