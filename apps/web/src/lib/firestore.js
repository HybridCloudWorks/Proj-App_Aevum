/**
 * Aevum Firestore Service
 *
 * Data layer for Firestore operations following GDEF best practices:
 * - Type-safe document operations
 * - Proper error handling
 * - Optimistic updates where appropriate
 */

import {
  collection,
  doc,
  getDoc,
  getDocs,
  setDoc,
  updateDoc,
  deleteDoc,
  writeBatch,
  query,
  where,
  orderBy,
  limit,
  serverTimestamp,
  onSnapshot,
} from "firebase/firestore";
import { db } from "./firebase";

// ==========================================
// Collections
// ==========================================

const COLLECTIONS = {
  USERS: "users",
  FAMILIES: "families",
  MEMBERS: "members",
  MEDIA_ITEMS: "media_items",
  HERITAGE: "heritage",
  AI_TASKS: "ai_tasks",
};

// ==========================================
// User Profile Operations
// ==========================================

/**
 * Get user profile by ID
 */
export async function getUserProfile(userId) {
  try {
    const userRef = doc(db, COLLECTIONS.USERS, userId);
    const userSnap = await getDoc(userRef);

    if (userSnap.exists()) {
      return { success: true, data: { id: userSnap.id, ...userSnap.data() } };
    }
    return { success: false, error: "User not found" };
  } catch (error) {
    console.error("Error getting user profile:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Update user profile
 */
export async function updateUserProfile(userId, updates) {
  try {
    const userRef = doc(db, COLLECTIONS.USERS, userId);
    await updateDoc(userRef, {
      ...updates,
      updatedAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    console.error("Error updating user profile:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Subscribe to user profile changes
 */
export function subscribeToUserProfile(userId, callback) {
  const userRef = doc(db, COLLECTIONS.USERS, userId);
  return onSnapshot(userRef, (doc) => {
    if (doc.exists()) {
      callback({ id: doc.id, ...doc.data() });
    } else {
      callback(null);
    }
  });
}

// ==========================================
// Family Operations
// ==========================================

/**
 * Create a new family
 */
export async function createFamily(userId, familyData) {
  try {
    const familyRef = doc(collection(db, COLLECTIONS.FAMILIES));
    const family = {
      ...familyData,
      ownerId: userId,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
      memberCount: 1,
    };

    const batch = writeBatch(db);

    batch.set(familyRef, family);

    // Add user as first member
    const memberRef = doc(
      db,
      COLLECTIONS.FAMILIES,
      familyRef.id,
      COLLECTIONS.MEMBERS,
      userId,
    );
    batch.set(memberRef, {
      userId,
      role: "owner",
      joinedAt: serverTimestamp(),
    });

    await batch.commit();

    return { success: true, familyId: familyRef.id };
  } catch (error) {
    console.error("Error creating family:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Get families for a user
 */
export async function getUserFamilies(userId) {
  try {
    const familiesQuery = query(
      collection(db, COLLECTIONS.FAMILIES),
      where("ownerId", "==", userId),
      orderBy("updatedAt", "desc"),
    );

    const snapshot = await getDocs(familiesQuery);
    const families = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    return { success: true, data: families };
  } catch (error) {
    console.error("Error getting user families:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Subscribe to family changes
 */
export function subscribeToFamilies(userId, callback) {
  const familiesQuery = query(
    collection(db, COLLECTIONS.FAMILIES),
    where("ownerId", "==", userId),
    orderBy("updatedAt", "desc"),
  );

  return onSnapshot(familiesQuery, (snapshot) => {
    const families = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
    callback(families);
  });
}

// ==========================================
// Media Item Operations
// ==========================================

/**
 * Create a new media item
 */
export async function createMediaItem(familyId, mediaData) {
  try {
    const mediaRef = doc(collection(db, COLLECTIONS.MEDIA_ITEMS));
    const mediaItem = {
      ...mediaData,
      familyId,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    };

    await setDoc(mediaRef, mediaItem);
    return { success: true, mediaId: mediaRef.id };
  } catch (error) {
    console.error("Error creating media item:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Get media items for a family
 */
export async function getFamilyMediaItems(familyId, maxResults = 20) {
  try {
    const mediaQuery = query(
      collection(db, COLLECTIONS.MEDIA_ITEMS),
      where("familyId", "==", familyId),
      orderBy("createdAt", "desc"),
      limit(maxResults),
    );

    const snapshot = await getDocs(mediaQuery);
    const mediaItems = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    return { success: true, mediaItems };
  } catch (error) {
    console.error("Error fetching media items:", error);
    return { success: false, error: error.message, mediaItems: [] };
  }
}

/**
 * Subscribe to family media items
 */
export function subscribeToMediaItems(familyId, callback, maxResults = 20) {
  const mediaQuery = query(
    collection(db, COLLECTIONS.MEDIA_ITEMS),
    where("familyId", "==", familyId),
    orderBy("createdAt", "desc"),
    limit(maxResults),
  );

  return onSnapshot(mediaQuery, (snapshot) => {
    const mediaItems = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
    callback(mediaItems);
  });
}

/**
 * Update a media item
 */
export async function updateMediaItem(familyId, mediaId, updates) {
  try {
    const mediaRef = doc(db, COLLECTIONS.MEDIA_ITEMS, mediaId);
    await updateDoc(mediaRef, {
      ...updates,
      updatedAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    console.error("Error updating media item:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Delete a media item
 */
export async function deleteMediaItem(familyId, mediaId) {
  try {
    const mediaRef = doc(db, COLLECTIONS.MEDIA_ITEMS, mediaId);
    await deleteDoc(mediaRef);
    return { success: true };
  } catch (error) {
    console.error("Error deleting media item:", error);
    return { success: false, error: error.message };
  }
}

// ==========================================
// Family Member Operations
// ==========================================

/**
 * Add a family member
 */
export async function addFamilyMember(familyId, memberData) {
  try {
    const memberRef = doc(collection(db, COLLECTIONS.MEMBERS));
    const member = {
      ...memberData,
      familyId,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    };

    await setDoc(memberRef, member);
    return { success: true, memberId: memberRef.id };
  } catch (error) {
    console.error("Error adding family member:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Update a family member
 */
export async function updateFamilyMember(familyId, memberId, updates) {
  try {
    const memberRef = doc(db, COLLECTIONS.MEMBERS, memberId);
    await updateDoc(memberRef, {
      ...updates,
      updatedAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    console.error("Error updating family member:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Delete a family member
 */
export async function deleteFamilyMember(familyId, memberId) {
  try {
    const memberRef = doc(db, COLLECTIONS.MEMBERS, memberId);
    await deleteDoc(memberRef);
    return { success: true };
  } catch (error) {
    console.error("Error deleting family member:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Subscribe to family members
 */
export function subscribeToFamilyMembers(familyId, callback) {
  const membersQuery = query(
    collection(db, COLLECTIONS.MEMBERS),
    where("familyId", "==", familyId),
  );

  return onSnapshot(membersQuery, (snapshot) => {
    const members = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
    callback(members);
  });
}

// ==========================================
// AI Task Operations
// ==========================================

/**
 * Subscribe to user's AI tasks
 */
export function subscribeToAITasks(userId, callback) {
  const tasksQuery = query(
    collection(db, COLLECTIONS.AI_TASKS),
    where("userId", "==", userId),
    orderBy("createdAt", "desc"),
  );

  return onSnapshot(tasksQuery, (snapshot) => {
    const tasks = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
    callback(tasks);
  });
}

/**
 * Update AI task status
 */
export async function updateAITaskStatus(taskId, status) {
  try {
    const taskRef = doc(db, COLLECTIONS.AI_TASKS, taskId);
    await updateDoc(taskRef, {
      status,
      updatedAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    console.error("Error updating AI task:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Request AI Media Analysis (Face detection, storytelling)
 */
export async function requestMediaAnalysis(mediaId) {
  try {
    const mediaRef = doc(db, COLLECTIONS.MEDIA_ITEMS, mediaId);
    await updateDoc(mediaRef, {
      aiStatus: "pending",
      status: "processed", // Required by backend ai-analyzer
      updatedAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    console.error("Error requesting AI analysis:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Request AI Photo Restoration
 */
export async function requestPhotoRestoration(mediaId, params) {
  try {
    const mediaRef = doc(db, COLLECTIONS.MEDIA_ITEMS, mediaId);
    await updateDoc(mediaRef, {
      aiStatus: "restoration_pending",
      restorationParams: params,
      updatedAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    console.error("Error requesting photo restoration:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Create mock AI task
 */
export async function createMockAITask(userId) {
  try {
    const taskRef = doc(collection(db, COLLECTIONS.AI_TASKS));
    await setDoc(taskRef, {
      userId,
      title: "Grandpa '54",
      type: "Enhance color",
      status: "pending",
      imageUrl:
        "https://lh3.googleusercontent.com/aida-public/AB6AXuCst1gIFGnX9hkdMwGTaxY6xjUlP-IAFFAh7ypfOuPKGVthwfRdOj01OQ5TVfUrQz3nmE7f3sWLFcEeZsZFJmMIX1GQYL3xDuFw49ZFBVnhAXd455GgLwYdqEj6VP9zHQjOLdbNqUtH9egfkXyq99VsuzDKq8pMEh8dCfPAv4XR6muac_M4rmeOXxkl_Ao8uGNz3sN9rMJ3IlXfIdezJzFvDSMtysjXO7GXs4B2tLwjld77v9VX3o4-npz_pJY5nIomO-I1vO1tcJ4",
      createdAt: serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    console.error("Error creating mock task:", error);
    return { success: false, error: error.message };
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
  getFamilyMediaItems,
  subscribeToMediaItems,
  updateMediaItem,
  deleteMediaItem,
  addFamilyMember,
  updateFamilyMember,
  deleteFamilyMember,
  subscribeToFamilyMembers,
  subscribeToAITasks,
  updateAITaskStatus,
  createMockAITask,
  requestMediaAnalysis,
  requestPhotoRestoration,
};
