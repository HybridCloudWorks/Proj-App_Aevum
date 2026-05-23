/**
 * useFamilyTree Hook
 *
 * Real-time subscription to family tree data from Firestore.
 */

import { useState, useEffect } from "react";
import { useAuth } from "@/contexts/AuthContext";
import {
  subscribeToFamilies,
  subscribeToFamilyMembers,
  createFamily,
  addFamilyMember,
  updateFamilyMember,
  deleteFamilyMember,
} from "@lib/firestore";

/**
 * Hook for managing family tree data with real-time updates
 * @returns {Object} Family tree state and actions
 */
export function useFamilyTree() {
  const { user } = useAuth();
  const [families, setFamilies] = useState([]);
  const [members, setMembers] = useState([]);
  const [currentFamily, setCurrentFamily] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const userId = user?.uid;

  // Subscribe to user's families
  useEffect(() => {
    if (!userId) {
    if (!user?.uid) {
      setFamilies([]);
      setLoading(false);
      return;
    }

    setLoading(true);
    const unsubscribe = subscribeToFamilies(userId, (data) => {
      setFamilies(data);
      // OPTIMIZATION: Use functional state update to remove currentFamily from dependencies,
      // preventing redundant unmounts and re-subscriptions when data updates.
      if (data.length > 0) {
        setCurrentFamily((prev) => prev || data[0]);
      if (data.length > 0) {
        // Bolt ⚡: Use functional state update to prevent O(N) redundant unmounts/re-subscriptions
        // to Firestore by removing currentFamily from the useEffect dependency array.
        setCurrentFamily((prev) => prev || data[0]);
        // ⚡ Bolt Optimization: Use functional state update to remove currentFamily from dependency array
        setCurrentFamily(prev => prev || data[0]);
      }
      setLoading(false);
    });

    return () => unsubscribe();
  }, [userId]);

  const currentFamilyId = currentFamily?.id;
    // Bolt ⚡: Depend on primitive user?.uid instead of full user object to prevent unnecessary re-subscriptions
  }, [user?.uid]);
  }, [user]);

  // Subscribe to current family's members
  // ⚡ Bolt Optimization: Extract primitive ID to prevent redundant re-subscriptions on object reference changes
  const currentFamilyId = currentFamily?.id;

  useEffect(() => {
    if (!currentFamily?.id) {
    if (!currentFamilyId) {
      setMembers([]);
      return;
    }

    // OPTIMIZATION: Depend on primitive currentFamilyId rather than object reference
    // to prevent unnecessary re-subscriptions on object identity changes.
    const unsubscribe = subscribeToFamilyMembers(currentFamilyId, (data) => {
      setMembers(data);
    });

    return () => unsubscribe();
    // Bolt ⚡: Depend on primitive currentFamily?.id instead of full object reference
  }, [currentFamily?.id]);
  }, [currentFamilyId]);

  // Actions
  const createNewFamily = async (name, description = "") => {
    if (!user) return { success: false, error: "Not authenticated" };

    setError(null);
    const result = await createFamily({
      name,
      description,
      ownerId: user.uid,
      createdBy: user.uid,
      members: [user.uid],
    });

    if (!result.success) {
      setError(result.error);
    }
    return result;
  };

  const addMember = async (memberData) => {
    if (!currentFamily) return { success: false, error: "No family selected" };

    setError(null);
    const result = await addFamilyMember(currentFamily.id, memberData);

    if (!result.success) {
      setError(result.error);
    }
    return result;
  };

  const updateMember = async (memberId, updates) => {
    if (!currentFamily) return { success: false, error: "No family selected" };

    setError(null);
    const result = await updateFamilyMember(
      currentFamily.id,
      memberId,
      updates,
    );

    if (!result.success) {
      setError(result.error);
    }
    return result;
  };

  const removeMember = async (memberId) => {
    if (!currentFamily) return { success: false, error: "No family selected" };

    setError(null);
    const result = await deleteFamilyMember(currentFamily.id, memberId);

    if (!result.success) {
      setError(result.error);
    }
    return result;
  };

  const selectFamily = (family) => {
    setCurrentFamily(family);
  };

  return {
    // State
    families,
    members,
    currentFamily,
    loading,
    error,

    // Actions
    createNewFamily,
    addMember,
    updateMember,
    removeMember,
    selectFamily,
  };
}

export default useFamilyTree;
