import { describe, it, expect, vi, beforeEach } from "vitest";
import { signOut } from "./auth";
import { signOut as firebaseSignOut } from "firebase/auth";
import { auth } from "./firebase";

// Mock firebase/auth
vi.mock("firebase/auth", () => {
  const mockProvider = {
    addScope: vi.fn().mockReturnThis(),
  };
  return {
    GoogleAuthProvider: vi.fn(() => mockProvider),
    OAuthProvider: vi.fn(() => mockProvider),
    signInWithPopup: vi.fn(),
    signInWithEmailAndPassword: vi.fn(),
    createUserWithEmailAndPassword: vi.fn(),
    signOut: vi.fn(),
    onAuthStateChanged: vi.fn(),
    sendPasswordResetEmail: vi.fn(),
    updateProfile: vi.fn(),
    getAuth: vi.fn(),
  };
});

// Mock ./firebase
vi.mock("./firebase", () => ({
  auth: {
    currentUser: null,
  },
  db: {},
}));

import { describe, it, expect, vi } from "vitest";
import { getCurrentUser } from "./auth";
import { auth } from "./firebase";

// Mock firebase/auth
vi.mock("firebase/auth", () => ({
  getAuth: vi.fn(),
  GoogleAuthProvider: vi.fn(),
  OAuthProvider: vi.fn(),
  signInWithPopup: vi.fn(),
  signInWithEmailAndPassword: vi.fn(),
  createUserWithEmailAndPassword: vi.fn(),
  signOut: vi.fn(),
  onAuthStateChanged: vi.fn(),
  sendPasswordResetEmail: vi.fn(),
  updateProfile: vi.fn(),
}));

// Mock ./firebase
vi.mock("./firebase", () => ({
  auth: { currentUser: { uid: "test-user" } },
  db: {},
}));

// Mock firestore functions as they are used in auth.js (though not in signOut directly)
  getAuth: vi.fn(),
}));

// Mock firebase/firestore
vi.mock("firebase/firestore", () => ({
  doc: vi.fn(),
  setDoc: vi.fn(),
  getDoc: vi.fn(),
  serverTimestamp: vi.fn(),
}));

describe("auth.js signOut", () => {
describe("auth.js - signOut", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("should return success: true when firebaseSignOut succeeds", async () => {
    // Setup mock
    vi.mocked(firebaseSignOut).mockResolvedValueOnce();

    // Execute
    const result = await signOut();

    // Assert
  it("should successfully sign out the user", async () => {
    vi.mocked(firebaseSignOut).mockResolvedValue(undefined);

    const result = await signOut();

    expect(firebaseSignOut).toHaveBeenCalledWith(auth);
    expect(result).toEqual({ success: true });
  });

  it("should return success: false and error message when firebaseSignOut fails", async () => {
    // Setup mock
    const errorMessage = "Sign out failed";
    vi.mocked(firebaseSignOut).mockRejectedValueOnce(new Error(errorMessage));

    // Execute
    const result = await signOut();

    // Assert
    expect(firebaseSignOut).toHaveBeenCalledWith(auth);
    expect(result).toEqual({ success: false, error: errorMessage });
  it("should handle sign out errors", async () => {
    const errorMessage = "Sign out failed";
    const error = new Error(errorMessage);
    vi.mocked(firebaseSignOut).mockRejectedValue(error);

    // Spy on console.error to verify it's called but not clutter the output
    const consoleSpy = vi.spyOn(console, "error").mockImplementation(() => {});

    const result = await signOut();

    expect(firebaseSignOut).toHaveBeenCalledWith(auth);
    expect(consoleSpy).toHaveBeenCalledWith("Sign-out error:", error);
    expect(result).toEqual({ success: false, error: errorMessage });

    consoleSpy.mockRestore();
  getFirestore: vi.fn(),
}));

// Mock the local firebase module
vi.mock("./firebase", () => ({
  auth: {
    currentUser: null,
  },
  db: {},
}));

describe("getCurrentUser", () => {
  it("should return null when no user is signed in", () => {
    auth.currentUser = null;
    expect(getCurrentUser()).toBeNull();
  });

  it("should return the current user when signed in", () => {
    const mockUser = { uid: "test-uid", email: "test@example.com" };
    auth.currentUser = mockUser;
    expect(getCurrentUser()).toEqual(mockUser);
  });
});
