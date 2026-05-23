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

// Mock firebase/firestore
vi.mock("firebase/firestore", () => ({
  doc: vi.fn(),
  setDoc: vi.fn(),
  getDoc: vi.fn(),
  serverTimestamp: vi.fn(),
}));

describe("auth.js signOut", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("should return success: true when firebaseSignOut succeeds", async () => {
    // Setup mock
    vi.mocked(firebaseSignOut).mockResolvedValueOnce();

    // Execute
    const result = await signOut();

    // Assert
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
  });
});
