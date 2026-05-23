import { describe, it, expect, vi, beforeEach } from "vitest";
import { signOut } from "./auth";
import { signOut as firebaseSignOut } from "firebase/auth";
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
vi.mock("firebase/firestore", () => ({
  doc: vi.fn(),
  setDoc: vi.fn(),
  getDoc: vi.fn(),
  serverTimestamp: vi.fn(),
}));

describe("auth.js - signOut", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("should successfully sign out the user", async () => {
    vi.mocked(firebaseSignOut).mockResolvedValue(undefined);

    const result = await signOut();

    expect(firebaseSignOut).toHaveBeenCalledWith(auth);
    expect(result).toEqual({ success: true });
  });

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
  });
});
