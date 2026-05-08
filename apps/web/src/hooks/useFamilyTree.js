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

  // Subscribe to user's families
  useEffect(() => {
    if (!user?.uid) {
      setFamilies([]);
      setLoading(false);
      return;
    }

    setLoading(true);
    const unsubscribe = subscribeToFamilies(user.uid, (data) => {
      setFamilies(data);
      if (data.length > 0) {
        // Bolt Performance Optimization: Use functional state update to remove currentFamily from dependency array.
        // This prevents O(N) redundant unmounts/re-subscriptions when setting initial selection state.
        setCurrentFamily((prev) => prev || data[0]);
      }
      setLoading(false);
    });

    return () => unsubscribe();
  }, [user?.uid]); // Bolt Performance Optimization: Depend on specific primitive value (user?.uid) rather than full object reference to prevent unnecessary unmounts/re-subscriptions.

  // Subscribe to current family's members
  useEffect(() => {
    if (!currentFamily?.id) {
      setMembers([]);
      return;
    }

    const unsubscribe = subscribeToFamilyMembers(currentFamily.id, (data) => {
      setMembers(data);
    });

    return () => unsubscribe();
  }, [currentFamily?.id]); // Bolt Performance Optimization: Depend on specific primitive value (currentFamily?.id) rather than full object reference.

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
