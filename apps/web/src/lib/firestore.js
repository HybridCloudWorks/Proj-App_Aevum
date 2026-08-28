/**
 * Aevum Firestore service.
 *
 * PR-01 recovery note: this module intentionally keeps the existing public API
 * while removing duplicate/partially merged implementations. Data-model and
 * authorization changes are handled in the canonical-data-contract follow-up.
 */

import {
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
  MEMBERS: "members",
  MEDIA_ITEMS: "media_items",
  AI_TASKS: "ai_tasks",
});

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

// User profiles
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
    await updateDoc(doc(db, COLLECTIONS.USERS, userId), {
      ...updates,
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

// Families
export async function createFamily(userId, familyData) {
  try {
    const familyRef = doc(collection(db, COLLECTIONS.FAMILIES));
    const members = Array.from(new Set([...(familyData.members || []), userId]));

    await setDoc(familyRef, {
      ...familyData,
      ownerId: userId,
      members,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
      memberCount: familyData.memberCount ?? 0,
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
      where("ownerId", "==", userId),
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
    where("ownerId", "==", userId),
    orderBy("updatedAt", "desc"),
  );
  return onSnapshot(
    familiesQuery,
    (snapshot) => callback(snapshotData(snapshot)),
    onError,
  );
}

// Media / memories
export async function createMediaItem(familyId, mediaData) {
  try {
    const mediaRef = doc(collection(db, COLLECTIONS.MEDIA_ITEMS));
    await setDoc(mediaRef, {
      ...mediaData,
      familyId,
      createdAt: mediaData.createdAt || serverTimestamp(),
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
          ...item,
          familyId,
          createdAt: item.createdAt || serverTimestamp(),
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
    await updateDoc(doc(db, COLLECTIONS.MEDIA_ITEMS, mediaId), {
      ...updates,
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

// Genealogical family members
export async function addFamilyMember(familyId, memberData) {
  try {
    const memberRef = doc(collection(db, COLLECTIONS.MEMBERS));
    await setDoc(memberRef, {
      ...memberData,
      familyId,
      createdAt: memberData.createdAt || serverTimestamp(),
      updatedAt: serverTimestamp(),
    });
    return { success: true, memberId: memberRef.id, id: memberRef.id };
  } catch (error) {
    return errorResult("Error adding family member", error);
  }
}

export async function updateFamilyMember(_familyId, memberId, updates) {
  try {
    await updateDoc(doc(db, COLLECTIONS.MEMBERS, memberId), {
      ...updates,
      updatedAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    return errorResult("Error updating family member", error);
  }
}

export async function deleteFamilyMember(_familyId, memberId) {
  try {
    await deleteDoc(doc(db, COLLECTIONS.MEMBERS, memberId));
    return { success: true };
  } catch (error) {
    return errorResult("Error deleting family member", error);
  }
}

export function subscribeToFamilyMembers(familyId, callback, onError) {
  const membersQuery = query(
    collection(db, COLLECTIONS.MEMBERS),
    where("familyId", "==", familyId),
  );
  return onSnapshot(
    membersQuery,
    (snapshot) => callback(snapshotData(snapshot)),
    onError,
  );
}

// AI tasks
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
    await setDoc(taskRef, {
      ...taskData,
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
