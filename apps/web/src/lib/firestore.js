/**
 * Aevum Firestore service.
 *
 * Canonical contract: docs/architecture/data-contract.md
 * Authentication collaborators and genealogical people are intentionally
 * separate concepts. Family authorization is rooted at the family document.
 */

import {
  arrayRemove,
  arrayUnion,
  collection,
  deleteDoc,
  doc,
  getDoc,
  getDocs,
  limit,
  onSnapshot,
  orderBy,
  query,
  serverTimestamp,
  setDoc,
  updateDoc,
  where,
  writeBatch,
} from "firebase/firestore";
import { db } from "./firebase";

const COLLECTIONS = Object.freeze({
  USERS: "users",
  FAMILIES: "families",
  FAMILY_MEMBERS: "family_members",
  MEDIA_ITEMS: "media_items",
  ALBUMS: "albums",
  AI_TASKS: "ai_tasks",
});

const COLLABORATORS = "collaborators";
const VALID_COLLABORATOR_ROLES = new Set(["editor", "viewer"]);

function documentData(snapshot) {
  if (!snapshot.exists()) return null;
  return { id: snapshot.id, ...snapshot.data() };
}

function snapshotData(snapshot) {
  return snapshot.docs.map((item) => ({ id: item.id, ...item.data() }));
}

function errorResult(context, error, fallback = {}) {
  console.error(`${context}:`, error);
  return { success: false, ...fallback, error: error.message };
}

function stripImmutableFields(data, fields) {
  const sanitized = { ...data };
  for (const field of fields) delete sanitized[field];
  return sanitized;
}

// -----------------------------------------------------------------------------
// User profiles
// -----------------------------------------------------------------------------

export async function getUserProfile(userId) {
  try {
    const snapshot = await getDoc(doc(db, COLLECTIONS.USERS, userId));
    const data = documentData(snapshot);
    return data
      ? { success: true, data }
      : { success: false, error: "User not found" };
  } catch (error) {
    return errorResult("Error getting user profile", error);
  }
}

export async function updateUserProfile(userId, updates) {
  try {
    const safeUpdates = stripImmutableFields(updates, [
      "uid",
      "createdAt",
      "admin",
      "role",
      "roles",
      "claims",
    ]);
    await updateDoc(doc(db, COLLECTIONS.USERS, userId), {
      ...safeUpdates,
      updatedAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    return errorResult("Error updating user profile", error);
  }
}

export function subscribeToUserProfile(userId, callback, onError) {
  return onSnapshot(
    doc(db, COLLECTIONS.USERS, userId),
    (snapshot) => callback(documentData(snapshot)),
    onError,
  );
}

// -----------------------------------------------------------------------------
// Families and collaborators
// -----------------------------------------------------------------------------

export async function createFamily(userId, familyData) {
  try {
    const familyRef = doc(collection(db, COLLECTIONS.FAMILIES));
    const safeFamilyData = stripImmutableFields(familyData, [
      "ownerId",
      "createdBy",
      "collaboratorIds",
      "members",
      "createdAt",
      "updatedAt",
    ]);

    await setDoc(familyRef, {
      ...safeFamilyData,
      ownerId: userId,
      createdBy: userId,
      collaboratorIds: [userId],
      memberCount: familyData.memberCount ?? 0,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    });

    return { success: true, familyId: familyRef.id, id: familyRef.id };
  } catch (error) {
    return errorResult("Error creating family", error);
  }
}

export async function getUserFamilies(userId) {
  try {
    const familiesQuery = query(
      collection(db, COLLECTIONS.FAMILIES),
      where("collaboratorIds", "array-contains", userId),
      orderBy("updatedAt", "desc"),
    );
    const snapshot = await getDocs(familiesQuery);
    return { success: true, data: snapshotData(snapshot) };
  } catch (error) {
    return errorResult("Error getting user families", error, { data: [] });
  }
}

export function subscribeToFamilies(userId, callback, onError) {
  const familiesQuery = query(
    collection(db, COLLECTIONS.FAMILIES),
    where("collaboratorIds", "array-contains", userId),
    orderBy("updatedAt", "desc"),
  );
  return onSnapshot(
    familiesQuery,
    (snapshot) => callback(snapshotData(snapshot)),
    onError,
  );
}

export function subscribeToFamilyCollaborators(familyId, callback, onError) {
  return onSnapshot(
    collection(db, COLLECTIONS.FAMILIES, familyId, COLLABORATORS),
    (snapshot) => callback(snapshotData(snapshot)),
    onError,
  );
}

export async function setFamilyCollaborator(
  familyId,
  userId,
  role,
  invitedBy,
  status = "active",
) {
  if (!VALID_COLLABORATOR_ROLES.has(role)) {
    return { success: false, error: "Role must be editor or viewer" };
  }

  try {
    const familyRef = doc(db, COLLECTIONS.FAMILIES, familyId);
    const collaboratorRef = doc(
      db,
      COLLECTIONS.FAMILIES,
      familyId,
      COLLABORATORS,
      userId,
    );
    const batch = writeBatch(db);

    batch.set(
      collaboratorRef,
      {
        userId,
        role,
        status,
        invitedBy,
        createdAt: serverTimestamp(),
        updatedAt: serverTimestamp(),
      },
      { merge: true },
    );
    batch.update(familyRef, {
      collaboratorIds: arrayUnion(userId),
      updatedAt: serverTimestamp(),
    });

    await batch.commit();
    return { success: true };
  } catch (error) {
    return errorResult("Error setting family collaborator", error);
  }
}

export async function removeFamilyCollaborator(familyId, userId) {
  try {
    const familyRef = doc(db, COLLECTIONS.FAMILIES, familyId);
    const collaboratorRef = doc(
      db,
      COLLECTIONS.FAMILIES,
      familyId,
      COLLABORATORS,
      userId,
    );
    const batch = writeBatch(db);

    batch.delete(collaboratorRef);
    batch.update(familyRef, {
      collaboratorIds: arrayRemove(userId),
      updatedAt: serverTimestamp(),
    });

    await batch.commit();
    return { success: true };
  } catch (error) {
    return errorResult("Error removing family collaborator", error);
  }
}

// -----------------------------------------------------------------------------
// Media / memories
// -----------------------------------------------------------------------------

function normalizeMediaCreateData(mediaData) {
  const safeData = stripImmutableFields(mediaData, [
    "familyId",
    "createdAt",
    "updatedAt",
  ]);
  const createdBy =
    mediaData.createdBy || mediaData.uploadedBy || mediaData.userId || null;

  delete safeData.userId;

  return {
    ...safeData,
    createdBy,
    uploadedBy: mediaData.uploadedBy || createdBy,
  };
}

export async function createMediaItem(familyId, mediaData) {
  try {
    const mediaRef = doc(collection(db, COLLECTIONS.MEDIA_ITEMS));
    await setDoc(mediaRef, {
      ...normalizeMediaCreateData(mediaData),
      familyId,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    });
    return { success: true, id: mediaRef.id, mediaId: mediaRef.id };
  } catch (error) {
    return errorResult("Error creating media item", error);
  }
}

export async function batchCreateMediaItems(familyId, mediaItemsData = []) {
  if (!mediaItemsData.length) {
    return { success: true, ids: [], results: [] };
  }

  try {
    const maxBatchSize = 500;
    const results = [];

    for (let offset = 0; offset < mediaItemsData.length; offset += maxBatchSize) {
      const batch = writeBatch(db);
      const chunk = mediaItemsData.slice(offset, offset + maxBatchSize);

      for (const item of chunk) {
        const mediaRef = doc(collection(db, COLLECTIONS.MEDIA_ITEMS));
        batch.set(mediaRef, {
          ...normalizeMediaCreateData(item),
          familyId,
          createdAt: serverTimestamp(),
          updatedAt: serverTimestamp(),
        });
        results.push({ id: mediaRef.id, mediaId: mediaRef.id });
      }

      await batch.commit();
    }

    return {
      success: true,
      ids: results.map((item) => item.id),
      results,
    };
  } catch (error) {
    return errorResult("Error batch creating media items", error, {
      ids: [],
      results: [],
    });
  }
}

export async function getFamilyMediaItems(familyId, maxResults = 20) {
  try {
    const mediaQuery = query(
      collection(db, COLLECTIONS.MEDIA_ITEMS),
      where("familyId", "==", familyId),
      orderBy("createdAt", "desc"),
      limit(maxResults),
    );
    const snapshot = await getDocs(mediaQuery);
    return { success: true, mediaItems: snapshotData(snapshot) };
  } catch (error) {
    return errorResult("Error fetching media items", error, { mediaItems: [] });
  }
}

export function subscribeToMediaItems(
  familyId,
  callback,
  maxResults = 20,
  onError,
) {
  const mediaQuery = query(
    collection(db, COLLECTIONS.MEDIA_ITEMS),
    where("familyId", "==", familyId),
    orderBy("createdAt", "desc"),
    limit(maxResults),
  );
  return onSnapshot(
    mediaQuery,
    (snapshot) => callback(snapshotData(snapshot)),
    onError,
  );
}

export async function updateMediaItem(_familyId, mediaId, updates) {
  try {
    const safeUpdates = stripImmutableFields(updates, [
      "familyId",
      "createdBy",
      "uploadedBy",
      "createdAt",
    ]);
    await updateDoc(doc(db, COLLECTIONS.MEDIA_ITEMS, mediaId), {
      ...safeUpdates,
      updatedAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    return errorResult("Error updating media item", error);
  }
}

export async function deleteMediaItem(_familyId, mediaId) {
  try {
    await deleteDoc(doc(db, COLLECTIONS.MEDIA_ITEMS, mediaId));
    return { success: true };
  } catch (error) {
    return errorResult("Error deleting media item", error);
  }
}

export const createMemory = createMediaItem;
export const updateMemory = updateMediaItem;
export const deleteMemory = deleteMediaItem;
export const batchCreateMemories = batchCreateMediaItems;

// -----------------------------------------------------------------------------
// Genealogical family members
// -----------------------------------------------------------------------------

export async function addFamilyMember(familyId, memberData) {
  try {
    const memberRef = doc(collection(db, COLLECTIONS.FAMILY_MEMBERS));
    const safeMemberData = stripImmutableFields(memberData, [
      "familyId",
      "createdAt",
      "updatedAt",
    ]);

    await setDoc(memberRef, {
      ...safeMemberData,
      familyId,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    });
    return { success: true, memberId: memberRef.id, id: memberRef.id };
  } catch (error) {
    return errorResult("Error adding family member", error);
  }
}

export async function updateFamilyMember(_familyId, memberId, updates) {
  try {
    const safeUpdates = stripImmutableFields(updates, [
      "familyId",
      "createdBy",
      "createdAt",
    ]);
    await updateDoc(doc(db, COLLECTIONS.FAMILY_MEMBERS, memberId), {
      ...safeUpdates,
      updatedAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    return errorResult("Error updating family member", error);
  }
}

export async function deleteFamilyMember(_familyId, memberId) {
  try {
    await deleteDoc(doc(db, COLLECTIONS.FAMILY_MEMBERS, memberId));
    return { success: true };
  } catch (error) {
    return errorResult("Error deleting family member", error);
  }
}

export function subscribeToFamilyMembers(familyId, callback, onError) {
  const membersQuery = query(
    collection(db, COLLECTIONS.FAMILY_MEMBERS),
    where("familyId", "==", familyId),
  );
  return onSnapshot(
    membersQuery,
    (snapshot) => callback(snapshotData(snapshot)),
    onError,
  );
}

// -----------------------------------------------------------------------------
// AI tasks
// -----------------------------------------------------------------------------

export function subscribeToAITasks(userId, callback, onError) {
  const tasksQuery = query(
    collection(db, COLLECTIONS.AI_TASKS),
    where("userId", "==", userId),
    orderBy("createdAt", "desc"),
  );
  return onSnapshot(
    tasksQuery,
    (snapshot) => callback(snapshotData(snapshot)),
    onError,
  );
}

export async function updateAITaskStatus(taskId, status) {
  try {
    await updateDoc(doc(db, COLLECTIONS.AI_TASKS, taskId), {
      status,
      updatedAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    return errorResult("Error updating AI task", error);
  }
}

export async function createAITask(userId, taskData) {
  try {
    const taskRef = doc(collection(db, COLLECTIONS.AI_TASKS));
    const safeTaskData = stripImmutableFields(taskData, [
      "userId",
      "createdAt",
      "updatedAt",
    ]);
    await setDoc(taskRef, {
      ...safeTaskData,
      userId,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    });
    return { success: true, id: taskRef.id, taskId: taskRef.id };
  } catch (error) {
    return errorResult("Error creating AI task", error);
  }
}

export async function requestMediaAnalysis(mediaId) {
  try {
    await updateDoc(doc(db, COLLECTIONS.MEDIA_ITEMS, mediaId), {
      aiStatus: "pending",
      status: "processed",
      updatedAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    return errorResult("Error requesting AI analysis", error);
  }
}

export async function requestPhotoRestoration(mediaId, params) {
  try {
    await updateDoc(doc(db, COLLECTIONS.MEDIA_ITEMS, mediaId), {
      aiStatus: "restoration_pending",
      restorationParams: params,
      updatedAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    return errorResult("Error requesting photo restoration", error);
  }
}

export default {
  getUserProfile,
  updateUserProfile,
  subscribeToUserProfile,
  createFamily,
  getUserFamilies,
  subscribeToFamilies,
  subscribeToFamilyCollaborators,
  setFamilyCollaborator,
  removeFamilyCollaborator,
  createMediaItem,
  createMemory,
  batchCreateMediaItems,
  batchCreateMemories,
  getFamilyMediaItems,
  subscribeToMediaItems,
  updateMediaItem,
  updateMemory,
  deleteMediaItem,
  deleteMemory,
  addFamilyMember,
  updateFamilyMember,
  deleteFamilyMember,
  subscribeToFamilyMembers,
  subscribeToAITasks,
  updateAITaskStatus,
  createAITask,
  requestMediaAnalysis,
  requestPhotoRestoration,
};
