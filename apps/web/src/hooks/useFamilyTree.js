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

  // Optimization: Extract primitives to prevent redundant listener teardowns
  // when object references change but IDs remain the same
  const userId = user?.uid;
  const currentFamilyId = currentFamily?.id;
  const userId = user?.uid;

  // Subscribe to user's families
  // ⚡ Bolt Optimization: Use primitive user.uid instead of user object,
  // and remove currentFamily from dependencies by using a functional state update.
  // This prevents redundant Firestore teardowns and re-subscriptions.
  useEffect(() => {
  // ⚡ Bolt Optimization: Use primitive user?.uid instead of user object reference
  // to prevent unnecessary re-subscriptions on reference changes.
  useEffect(() => {
    // Optimization: depend on primitive `user?.uid` to prevent redundant re-subscriptions
    // and use functional state update for `setCurrentFamily` so we don't need `currentFamily` as a dependency.
    const uid = user?.uid;
    if (!uid) {
  // ⚡ Bolt Optimization: Depend on primitive user?.uid instead of objects to prevent unnecessary re-subscriptions
  const userId = user?.uid;
  useEffect(() => {
    if (!userId) {
    // ⚡ Bolt: Use user?.uid primitive instead of full user object to prevent unnecessary re-subscriptions
    if (!userId) {
  // ⚡ Bolt Optimization: Extract primitive user.uid to prevent redundant re-subscriptions
  // on user object identity changes.
  const userId = user?.uid;

  useEffect(() => {
    if (!userId) {
    // Optimization: Check for primitive user?.uid rather than full user object
    if (!userId) {
    if (!user?.uid) {
      setFamilies([]);
      setLoading(false);
      return;
    }

    setLoading(true);
    const unsubscribe = subscribeToFamilies(uid, (data) => {
      setFamilies(data);
      if (data.length > 0) {
        setCurrentFamily((prev) => prev ? prev : data[0]);
    const unsubscribe = subscribeToFamilies(userId, (data) => {
      setFamilies(data);
      if (data.length > 0) {
        // ⚡ Bolt Optimization: Use functional state update to avoid depending on currentFamily
        setCurrentFamily((prev) => (prev ? prev : data[0]));
      // Performance optimization: Use functional state update to prevent redundant
      // re-subscriptions to Firestore when currentFamily state changes.
      setCurrentFamily(prev => (data.length > 0 && !prev ? data[0] : prev));
      if (data.length > 0) {
        setCurrentFamily((prev) => (prev ? prev : data[0]));
        // ⚡ Bolt Optimization: Use functional state update to prevent needing currentFamily
        // in the dependency array, avoiding redundant Firestore re-subscriptions.
        setCurrentFamily((prev) => (prev ? prev : data[0]));
        // ⚡ Bolt Optimization: Use functional state update to prevent
        // redundant re-subscriptions by removing currentFamily from the dependency array
        setCurrentFamily((prev) => prev ? prev : data[0]);
        setCurrentFamily((prev) => (prev ? prev : data[0]));
        // ⚡ Bolt Performance Optimization: Use functional state update to prevent redundant re-subscriptions
        setCurrentFamily((prev) => (prev ? prev : data[0]));
      // ⚡ Bolt Performance Optimization:
      // Use functional state update to remove currentFamily from dependency array.
      // This prevents redundant unmounts/re-subscriptions when initial selection is set.
      if (data.length > 0) {
        setCurrentFamily((prev) => prev || data[0]);
      if (data.length > 0) {
        // Optimization: Use functional state update to set initial family without
        // adding currentFamily to the dependency array, avoiding redundant re-subscriptions
        setCurrentFamily((prev) => prev || data[0]);
      // ⚡ Bolt: Use functional state update to remove currentFamily from dependency array
      if (data.length > 0) {
        setCurrentFamily((prev) => prev || data[0]);
      if (data.length > 0) {
        // ⚡ Bolt Optimization: Use functional state update to remove currentFamily
        // dependency from the effect, preventing redundant Firebase teardowns.
        setCurrentFamily((prev) => (prev ? prev : data[0]));
        // ⚡ Bolt Optimization: Use functional state update to prevent redundant
        // re-subscriptions caused by including currentFamily in the dependency array
        setCurrentFamily((prev) => (prev ? prev : data[0]));
        setCurrentFamily((prev) => (prev ? prev : data[0]));
      // ⚡ Bolt Optimization: Use functional state update to remove currentFamily from dependency array
      setCurrentFamily((prev) => {
        if (data.length > 0 && !prev) {
          return data[0];
        }
        return prev;
      });
      if (data.length > 0) {
        // Bolt Performance Optimization: Use functional state update to remove currentFamily from dependency array.
        // This prevents O(N) redundant unmounts/re-subscriptions when setting initial selection state.
        setCurrentFamily((prev) => prev || data[0]);
        // Optimization: Use functional state update to remove currentFamily from dependency array
        // This prevents tearing down and recreating the Firestore subscription when the initial family is selected
        setCurrentFamily((prev) => prev || data[0]);
        // ⚡ Bolt Optimization: Use functional state update to remove currentFamily
        // from the useEffect dependency array, preventing O(N) unmounts/re-subscriptions.
        setCurrentFamily((prev) => prev || data[0]);
      // Optimization: Functional state update prevents closure dependency on currentFamily
      if (data.length > 0) {
        setCurrentFamily((prev) => prev || data[0]);
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
  }, [user]);

  // Subscribe to current family's members
  const currentFamilyId = currentFamily?.id;
  useEffect(() => {
  }, [user?.uid]);

  // Subscribe to current family's members
  // ⚡ Bolt Optimization: Depend only on currentFamily?.id instead of the full object
  // to avoid unnecessary re-subscriptions when other family properties update.
  useEffect(() => {
    if (!currentFamily?.id) {
  }, [user]);
    // ⚡ Bolt Optimization: Changed dependencies from [user, currentFamily] to [user?.uid].
    // By using functional state updates (prev => prev ? prev : data[0]), we no longer
    // depend on the outer `currentFamily` state, preventing redundant teardowns and
    // re-subscriptions when the selected family changes. Using `user?.uid` prevents
    // recreation when the user object reference changes.
  }, [user?.uid]);
  }, [user]); // Removed currentFamily from dependency array

  // Subscribe to current family's members
  // ⚡ Bolt Performance Optimization: Extract primitive ID to avoid re-subscriptions on object reference changes
  const currentFamilyId = currentFamily?.id;
  useEffect(() => {
    // ⚡ Bolt Optimization: Using userId (primitive) as a dependency prevents
    // redundant teardown and recreation of the Firestore subscription when the user object reference changes.
    // Using functional state update for setCurrentFamily removes currentFamily from dependencies.
  }, [userId]);

  const currentFamilyId = currentFamily?.id;
  }, [user?.uid]);
  }, [user?.uid]); // ⚡ Bolt: Depend on primitive field rather than object reference
  }, [user?.uid]);

  // Subscribe to current family's members
  // ⚡ Bolt Optimization: Use primitive currentFamily?.id instead of object reference
  // to prevent redundant re-subscriptions on reference changes.
  useEffect(() => {
    if (!currentFamily?.id) {
  }, [user]);

  // Subscribe to current family's members
  const currentFamilyId = currentFamily?.id;
  useEffect(() => {
  }, [userId]);

  // Subscribe to current family's members
  // ⚡ Bolt Optimization: Depend on primitive currentFamily?.id instead of full object reference
  const currentFamilyId = currentFamily?.id;
  useEffect(() => {
    if (!currentFamily?.id) {
  }, [user?.uid]); // Bolt Performance Optimization: Depend on specific primitive value (user?.uid) rather than full object reference to prevent unnecessary unmounts/re-subscriptions.
  }, [user]);

  // Extract primitive ID for dependency array
  const currentFamilyId = currentFamily?.id;
  }, [userId]);

  // Subscribe to current family's members
  // ⚡ Bolt Optimization: Extract primitive family ID to prevent redundant re-subscriptions
  const familyId = currentFamily?.id;

  useEffect(() => {
    if (!familyId) {
  }, [user?.uid]); // Optimization: Use primitive dependency user?.uid to prevent redundant unmounts and re-subscriptions
  }, [userId]);

  const currentFamilyId = currentFamily?.id;
    // Bolt ⚡: Depend on primitive user?.uid instead of full user object to prevent unnecessary re-subscriptions
  }, [user?.uid]);
  }, [user]);

  // Subscribe to current family's members
  // ⚡ Bolt Optimization: Extract primitive ID to prevent redundant re-subscriptions on object reference changes
  const currentFamilyId = currentFamily?.id;

  useEffect(() => {
    // Optimization: extract primitive ID to avoid redundant re-subscriptions
    // when the object reference changes but the ID remains the same.
    const currentFamilyId = currentFamily?.id;

    if (!currentFamily?.id) {
    // ⚡ Bolt: Use currentFamily?.id primitive to prevent unnecessary re-subscriptions
    if (!currentFamily?.id) {
    if (!currentFamily?.id) {
    // Optimization: Check for primitive id rather than full object
    if (!currentFamily?.id) {
    if (!currentFamily?.id) {
    if (!currentFamilyId) {
      setMembers([]);
      return;
    }

    // Performance optimization: Rely on the primitive currentFamily.id rather than
    // the whole currentFamily object reference to avoid unnecessary teardowns.
    // ⚡ Bolt Performance Optimization:
    // Depend on specific primitive value (currentFamily?.id) rather than full object reference.
    // This prevents unnecessary unmounts and re-subscriptions when the object reference changes.
    // Optimization: Depend on currentFamily.id primitive rather than the object reference
    // to prevent unnecessary unmounts/re-subscriptions when the object reference changes
    const unsubscribe = subscribeToFamilyMembers(currentFamily.id, (data) => {
    // Optimization: Depend on the primitive currentFamilyId instead of the currentFamily object
    // This prevents redundant unmounts and re-subscriptions when the object reference changes but ID remains the same
    const unsubscribe = subscribeToFamilyMembers(familyId, (data) => {
    // OPTIMIZATION: Depend on primitive currentFamilyId rather than object reference
    // to prevent unnecessary re-subscriptions on object identity changes.
    const unsubscribe = subscribeToFamilyMembers(currentFamilyId, (data) => {
      setMembers(data);
    });

    return () => unsubscribe();
    // ⚡ Bolt Optimization: Depend on the primitive currentFamilyId instead of currentFamily object reference
  }, [currentFamily?.id]);
    // ⚡ Bolt Optimization: Using currentFamily?.id (primitive) as a dependency
    // instead of the currentFamily object prevents redundant teardown and recreation
    // of the Firestore subscription when the object reference changes but the ID doesn't.
  }, [currentFamily?.id]);
    // instead of the currentFamily object reference prevents redundant teardowns
    // and re-subscriptions when the object reference changes but the ID remains the same.
  }, [currentFamily?.id]);
    // ⚡ Bolt Optimization: Depend on primitive currentFamily?.id instead of object
    // currentFamily to prevent redundant resubscriptions when object reference changes
  }, [currentFamily?.id]);
    // ⚡ Bolt Optimization: Using currentFamilyId (primitive) as a dependency
    // instead of the currentFamily object prevents redundant teardown and recreation
    // of the Firestore subscription when the object reference changes.
  }, [currentFamily?.id]);
  }, [currentFamily?.id]); // ⚡ Bolt: Depend on primitive field rather than object reference
  }, [currentFamily?.id]);
    // ⚡ Bolt Optimization: Depend on the primitive currentFamilyId rather than
    // the currentFamily object reference to prevent redundant re-subscriptions
  }, [currentFamily?.id]); // Bolt Performance Optimization: Depend on specific primitive value (currentFamily?.id) rather than full object reference.
  }, [familyId]);
  }, [currentFamily?.id]); // Optimization: Use primitive dependency currentFamily?.id to prevent redundant unmounts and re-subscriptions
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
