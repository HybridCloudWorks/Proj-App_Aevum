const assert = require("node:assert/strict");
const fs = require("node:fs");
const { initializeApp, deleteApp } = require("firebase/app");
const {
  connectAuthEmulator,
  createUserWithEmailAndPassword,
  getAuth,
  signInWithEmailAndPassword,
  signOut,
} = require("firebase/auth");
const {
  arrayRemove,
  arrayUnion,
  connectFirestoreEmulator,
  doc,
  getDoc,
  getFirestore,
  setDoc,
  updateDoc,
  writeBatch,
} = require("firebase/firestore");
const {
  connectStorageEmulator,
  getStorage,
  ref,
  uploadBytes,
} = require("firebase/storage");
const {
  initializeTestEnvironment,
} = require("@firebase/rules-unit-testing");

const projectId = "demo-aevum";
const password = "PrivateBeta123!";
const apps = [];
let privilegedEnv;

function client(name) {
  const app = initializeApp(
    {
      projectId,
      apiKey: "demo-api-key",
      authDomain: projectId + ".firebaseapp.com",
      storageBucket: projectId + ".appspot.com",
    },
    name,
  );
  apps.push(app);

  const auth = getAuth(app);
  const firestore = getFirestore(app);
  const storage = getStorage(app);
  connectAuthEmulator(auth, "http://127.0.0.1:9099", {
    disableWarnings: true,
  });
  connectFirestoreEmulator(firestore, "127.0.0.1", 8080);
  connectStorageEmulator(storage, "127.0.0.1", 9199);
  return { auth, firestore, storage };
}

async function expectDenied(action, label) {
  await assert.rejects(action, undefined, label);
}

async function createAccount(context, email) {
  const credential = await createUserWithEmailAndPassword(
    context.auth,
    email,
    password,
  );
  assert.ok(credential.user.uid);
  return credential.user.uid;
}

async function main() {
  const owner = client("journey-owner");
  const collaborator = client("journey-collaborator");
  const outsider = client("journey-outsider");

  const ownerEmail = "owner@private-beta.test";
  const collaboratorEmail = "collaborator@private-beta.test";
  const outsiderEmail = "outsider@private-beta.test";

  const ownerId = await createAccount(owner, ownerEmail);
  const collaboratorId = await createAccount(collaborator, collaboratorEmail);
  await createAccount(outsider, outsiderEmail);

  const familyId = "golden-family";
  const personId = "golden-person";
  const mediaId = "golden-media";
  const familyRef = doc(owner.firestore, "families", familyId);
  const personRef = doc(owner.firestore, "family_members", personId);
  const mediaRef = doc(owner.firestore, "media_items", mediaId);

  await setDoc(familyRef, {
    name: "Golden Family",
    description: "Private Beta journey",
    ownerId,
    createdBy: ownerId,
    collaboratorIds: [ownerId],
    memberCount: 0,
    createdAt: "journey-created",
    updatedAt: "journey-created",
  });

  await setDoc(personRef, {
    familyId,
    createdBy: ownerId,
    name: "Golden Person",
    role: "Relative",
    parentIds: [],
    spouseIds: [],
    childIds: [],
    createdAt: "journey-created",
    updatedAt: "journey-created",
  });

  await setDoc(mediaRef, {
    familyId,
    createdBy: ownerId,
    uploadedBy: ownerId,
    title: "Golden Memory",
    description: "",
    tags: [],
    memberIds: [],
    status: "uploading",
    aiStatus: "waiting",
    storage: {},
    createdAt: "journey-created",
    updatedAt: "journey-created",
  });

  const originalPath =
    "families/" + familyId + "/media/" + mediaId +
    "/original/golden.jpg";
  await uploadBytes(
    ref(owner.storage, originalPath),
    new Uint8Array([255, 216, 255, 217]),
    { contentType: "image/jpeg" },
  );

  await updateDoc(mediaRef, {
    status: "uploaded",
    photoUrl: "https://example.test/golden.jpg",
    thumbnailUrl: null,
    storage: { originalPath },
    imageMetadata: { width: 1, height: 1 },
    uploadCompletedAt: "journey-uploaded",
    updatedAt: "journey-uploaded",
  });
  await updateDoc(mediaRef, {
    memberIds: [personId],
    tags: ["family"],
    updatedAt: "journey-tagged",
  });

  assert.equal((await getDoc(familyRef)).data().name, "Golden Family");
  assert.equal((await getDoc(personRef)).data().name, "Golden Person");
  assert.deepEqual((await getDoc(mediaRef)).data().memberIds, [personId]);

  await signOut(owner.auth);
  await expectDenied(
    getDoc(doc(owner.firestore, "families", familyId)),
    "signed-out sessions cannot read family data",
  );

  await signInWithEmailAndPassword(owner.auth, ownerEmail, password);
  assert.equal(
    (await getDoc(doc(owner.firestore, "media_items", mediaId))).data().title,
    "Golden Memory",
  );
  await expectDenied(
    getDoc(doc(outsider.firestore, "families", familyId)),
    "outsiders cannot read a family",
  );

  const inviteBatch = writeBatch(owner.firestore);
  inviteBatch.update(familyRef, {
    collaboratorIds: arrayUnion(collaboratorId),
    updatedAt: "journey-invited",
  });
  inviteBatch.set(
    doc(owner.firestore, "families", familyId, "collaborators", collaboratorId),
    {
      userId: collaboratorId,
      role: "viewer",
      status: "active",
      invitedBy: ownerId,
      createdAt: "journey-invited",
      updatedAt: "journey-invited",
    },
  );
  await inviteBatch.commit();

  assert.equal(
    (await getDoc(doc(collaborator.firestore, "families", familyId))).data()
      .name,
    "Golden Family",
  );
  assert.equal(
    (await getDoc(doc(collaborator.firestore, "media_items", mediaId))).data()
      .title,
    "Golden Memory",
  );

  const revokeBatch = writeBatch(owner.firestore);
  revokeBatch.update(familyRef, {
    collaboratorIds: arrayRemove(collaboratorId),
    updatedAt: "journey-revoked",
  });
  revokeBatch.delete(
    doc(owner.firestore, "families", familyId, "collaborators", collaboratorId),
  );
  await revokeBatch.commit();
  await expectDenied(
    getDoc(doc(collaborator.firestore, "families", familyId)),
    "revoked collaborators cannot read the family",
  );

  const failedMediaId = "failed-upload";
  await setDoc(doc(owner.firestore, "media_items", failedMediaId), {
    familyId,
    createdBy: ownerId,
    uploadedBy: ownerId,
    title: "Failed upload",
    description: "",
    tags: [],
    memberIds: [],
    status: "uploading",
    aiStatus: "waiting",
    storage: {},
    createdAt: "failed-created",
    updatedAt: "failed-created",
  });
  await updateDoc(doc(owner.firestore, "media_items", failedMediaId), {
    status: "upload_failed",
    uploadError: "Interrupted upload",
    updatedAt: "failed",
  });
  await expectDenied(
    uploadBytes(
      ref(
        owner.storage,
        "families/" + familyId + "/media/" + failedMediaId +
          "/original/interrupted.jpg",
      ),
      new Uint8Array([1, 2, 3]),
      { contentType: "image/jpeg" },
    ),
    "failed reservations cannot receive an original",
  );

  const malformedMediaId = "malformed-upload";
  await setDoc(doc(owner.firestore, "media_items", malformedMediaId), {
    familyId,
    createdBy: ownerId,
    uploadedBy: ownerId,
    title: "Malformed upload",
    description: "",
    tags: [],
    memberIds: [],
    status: "uploading",
    aiStatus: "waiting",
    storage: {},
    createdAt: "malformed-created",
    updatedAt: "malformed-created",
  });
  await expectDenied(
    uploadBytes(
      ref(
        owner.storage,
        "families/" + familyId + "/media/" + malformedMediaId +
          "/original/not-image.txt",
      ),
      new Uint8Array([1, 2, 3]),
      { contentType: "text/plain" },
    ),
    "unsupported media is rejected",
  );

  privilegedEnv = await initializeTestEnvironment({
    projectId,
    firestore: { rules: fs.readFileSync("firestore.rules", "utf8") },
  });
  await privilegedEnv.withSecurityRulesDisabled(async (context) => {
    await updateDoc(doc(context.firestore(), "media_items", mediaId), {
      status: "processed",
      aiStatus: "failed",
      aiErrorCode: "analysis_unavailable",
      updatedAt: "ai-failed",
    });
  });

  const preservedAfterAiFailure = await getDoc(
    doc(owner.firestore, "media_items", mediaId),
  );
  assert.equal(preservedAfterAiFailure.data().status, "processed");
  assert.equal(preservedAfterAiFailure.data().aiStatus, "failed");
  assert.equal(preservedAfterAiFailure.data().storage.originalPath, originalPath);

  console.log("Private Beta golden journey passed.");
}

main()
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  })
  .finally(async () => {
    if (privilegedEnv) await privilegedEnv.cleanup();
    await Promise.all(apps.map((app) => deleteApp(app)));
  });
