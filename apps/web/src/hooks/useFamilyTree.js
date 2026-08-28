/**
 * useFamilyTree Hook
 *
 * Provides one family subscription and one active-family member subscription.
 */

import { useEffect, useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import {
  addFamilyMember,
  createFamily,
  deleteFamilyMember,
  subscribeToFamilies,
  subscribeToFamilyMembers,
  updateFamilyMember,
} from "@lib/firestore";

export function useFamilyTree() {
  const { user } = useAuth();
  const userId = user?.uid;

  const [families, setFamilies] = useState([]);
  const [members, setMembers] = useState([]);
  const [currentFamily, setCurrentFamily] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const currentFamilyId = currentFamily?.id;

  useEffect(() => {
    if (!userId) {
      setFamilies([]);
      setCurrentFamily(null);
      setLoading(false);
      return undefined;
    }

    setLoading(true);
    setError(null);

    const unsubscribe = subscribeToFamilies(
      userId,
      (data) => {
        setFamilies(data);
        setCurrentFamily((previous) => {
          if (!data.length) return null;
          if (previous && data.some((family) => family.id === previous.id)) {
            return data.find((family) => family.id === previous.id) || previous;
          }
          return data[0];
        });
        setLoading(false);
      },
      (subscriptionError) => {
        setError(subscriptionError.message);
        setLoading(false);
      },
    );

    return unsubscribe;
  }, [userId]);

  useEffect(() => {
    if (!currentFamilyId) {
      setMembers([]);
      return undefined;
    }

    const unsubscribe = subscribeToFamilyMembers(
      currentFamilyId,
      setMembers,
      (subscriptionError) => setError(subscriptionError.message),
    );

    return unsubscribe;
  }, [currentFamilyId]);

  const createNewFamily = async (name, description = "") => {
    if (!userId) return { success: false, error: "Not authenticated" };

    setError(null);
    const result = await createFamily(userId, {
      name,
      description,
      createdBy: userId,
      members: [userId],
    });

    if (!result.success) setError(result.error);
    return result;
  };

  const addMember = async (memberData) => {
    if (!currentFamilyId) {
      return { success: false, error: "No family selected" };
    }
    if (!userId) return { success: false, error: "Not authenticated" };

    setError(null);
    const result = await addFamilyMember(currentFamilyId, {
      ...memberData,
      userId: memberData.userId || userId,
    });

    if (!result.success) setError(result.error);
    return result;
  };

  const updateMember = async (memberId, updates) => {
    if (!currentFamilyId) {
      return { success: false, error: "No family selected" };
    }

    setError(null);
    const result = await updateFamilyMember(currentFamilyId, memberId, updates);
    if (!result.success) setError(result.error);
    return result;
  };

  const removeMember = async (memberId) => {
    if (!currentFamilyId) {
      return { success: false, error: "No family selected" };
    }

    setError(null);
    const result = await deleteFamilyMember(currentFamilyId, memberId);
    if (!result.success) setError(result.error);
    return result;
  };

  const selectFamily = (family) => {
    if (!family) {
      setCurrentFamily(null);
      return;
    }

    const selected = families.find((candidate) => candidate.id === family.id);
    setCurrentFamily(selected || family);
  };

  return {
    families,
    members,
    currentFamily,
    loading,
    error,
    createNewFamily,
    addMember,
    updateMember,
    removeMember,
    selectFamily,
  };
}

export default useFamilyTree;
