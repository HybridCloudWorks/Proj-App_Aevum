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
  // ⚡ Bolt Optimization: Removed `currentFamily` from dependency array and used functional state update
  // to prevent unnecessary Firestore re-subscriptions when currentFamily is initially set.
  useEffect(() => {
    if (!user) {
      setFamilies([]);
      setLoading(false);
      return;
    }

    setLoading(true);
    const unsubscribe = subscribeToFamilies(user.uid, (data) => {
      setFamilies(data);
      setCurrentFamily((prev) => {
        if (data.length > 0 && !prev) {
          return data[0];
        }
        return prev;
      });
      setLoading(false);
    });

    return () => unsubscribe();
  }, [user, user?.uid]);

  // Subscribe to current family's members
  useEffect(() => {
    if (!currentFamily) {
      setMembers([]);
      return;
    }

    const unsubscribe = subscribeToFamilyMembers(currentFamily.id, (data) => {
      setMembers(data);
    });

    return () => unsubscribe();
  }, [currentFamily]);

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
