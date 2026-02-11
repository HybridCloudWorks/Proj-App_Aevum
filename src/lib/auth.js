/**
 * Aevum Authentication Service
 *
 * Firebase Authentication integration following GDEF best practices:
 * - Multiple auth providers (Google, Apple, Email)
 * - Secure error handling
 * - User state management
 */

import {
  GoogleAuthProvider,
  OAuthProvider,
  signInWithPopup,
  signInWithEmailAndPassword,
  createUserWithEmailAndPassword,
  signOut as firebaseSignOut,
  onAuthStateChanged,
  sendPasswordResetEmail,
  updateProfile,
} from "firebase/auth";
import { doc, setDoc, getDoc, serverTimestamp } from "firebase/firestore";
import { auth, db } from "./firebase";

// ==========================================
// Auth Providers
// ==========================================

const googleProvider = new GoogleAuthProvider();
googleProvider.addScope("profile");
googleProvider.addScope("email");

const appleProvider = new OAuthProvider("apple.com");
appleProvider.addScope("email");
appleProvider.addScope("name");

// ==========================================
// User Profile Management
// ==========================================

/**
 * Create or update user profile in Firestore after authentication
 */
async function syncUserProfile(user) {
  if (!user) return null;

  const userRef = doc(db, "users", user.uid);
  const userSnap = await getDoc(userRef);

  if (!userSnap.exists()) {
    // Create new user profile
    const userData = {
      uid: user.uid,
      email: user.email,
      displayName: user.displayName || "",
      photoURL: user.photoURL || "",
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
      onboardingComplete: false,
    };

    await setDoc(userRef, userData);
    return userData;
  } else {
    // Update last login
    await setDoc(userRef, { updatedAt: serverTimestamp() }, { merge: true });
    return userSnap.data();
  }
}

// ==========================================
// Authentication Methods
// ==========================================

/**
 * Sign in with Google OAuth
 */
export async function signInWithGoogle() {
  try {
    const result = await signInWithPopup(auth, googleProvider);
    await syncUserProfile(result.user);
    return { success: true, user: result.user };
  } catch (error) {
    console.error("Google sign-in error:", error);
    return { success: false, error: getAuthErrorMessage(error.code) };
  }
}

/**
 * Sign in with Apple OAuth
 */
export async function signInWithApple() {
  try {
    const result = await signInWithPopup(auth, appleProvider);
    await syncUserProfile(result.user);
    return { success: true, user: result.user };
  } catch (error) {
    console.error("Apple sign-in error:", error);
    return { success: false, error: getAuthErrorMessage(error.code) };
  }
}

/**
 * Sign in with email and password
 */
export async function signInWithEmail(email, password) {
  try {
    const result = await signInWithEmailAndPassword(auth, email, password);
    await syncUserProfile(result.user);
    return { success: true, user: result.user };
  } catch (error) {
    console.error("Email sign-in error:", error);
    return { success: false, error: getAuthErrorMessage(error.code) };
  }
}

/**
 * Create new account with email and password
 */
export async function signUpWithEmail(email, password, displayName = "") {
  try {
    const result = await createUserWithEmailAndPassword(auth, email, password);

    // Update display name if provided
    if (displayName) {
      await updateProfile(result.user, { displayName });
    }

    await syncUserProfile(result.user);
    return { success: true, user: result.user };
  } catch (error) {
    console.error("Email sign-up error:", error);
    return { success: false, error: getAuthErrorMessage(error.code) };
  }
}

/**
 * Sign out current user
 */
export async function signOut() {
  try {
    await firebaseSignOut(auth);
    return { success: true };
  } catch (error) {
    console.error("Sign-out error:", error);
    return { success: false, error: error.message };
  }
}

/**
 * Send password reset email
 */
export async function resetPassword(email) {
  try {
    await sendPasswordResetEmail(auth, email);
    return { success: true };
  } catch (error) {
    console.error("Password reset error:", error);
    return { success: false, error: getAuthErrorMessage(error.code) };
  }
}

// ==========================================
// Auth State Subscription
// ==========================================

/**
 * Subscribe to auth state changes
 * @param {Function} callback - Called with user object or null
 * @returns {Function} Unsubscribe function
 */
export function onAuthChange(callback) {
  return onAuthStateChanged(auth, callback);
}

/**
 * Get current user synchronously
 */
export function getCurrentUser() {
  return auth.currentUser;
}

// ==========================================
// Error Handling
// ==========================================

/**
 * Convert Firebase auth error codes to user-friendly messages
 */
function getAuthErrorMessage(code) {
  const errorMessages = {
    "auth/email-already-in-use": "An account with this email already exists.",
    "auth/invalid-email": "Please enter a valid email address.",
    "auth/operation-not-allowed": "This sign-in method is not enabled.",
    "auth/weak-password": "Password must be at least 6 characters.",
    "auth/user-disabled": "This account has been disabled.",
    "auth/user-not-found": "No account found with this email.",
    "auth/wrong-password": "Incorrect password. Please try again.",
    "auth/too-many-requests": "Too many attempts. Please try again later.",
    "auth/popup-closed-by-user": "Sign-in was cancelled.",
    "auth/network-request-failed":
      "Network error. Please check your connection.",
  };

  return errorMessages[code] || "An error occurred. Please try again.";
}

export default {
  signInWithGoogle,
  signInWithApple,
  signInWithEmail,
  signUpWithEmail,
  signOut,
  resetPassword,
  onAuthChange,
  getCurrentUser,
};
