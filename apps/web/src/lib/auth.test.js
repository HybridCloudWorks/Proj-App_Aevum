import { beforeEach, describe, expect, it, vi } from "vitest";
import { signOut as firebaseSignOut } from "firebase/auth";
import { auth } from "./firebase";
import { getCurrentUser, signOut } from "./auth";

vi.mock("firebase/auth", () => {
  const provider = { addScope: vi.fn().mockReturnThis() };
  return {
    GoogleAuthProvider: vi.fn(() => provider),
    OAuthProvider: vi.fn(() => provider),
    signInWithPopup: vi.fn(),
    signInWithEmailAndPassword: vi.fn(),
    createUserWithEmailAndPassword: vi.fn(),
    signOut: vi.fn(),
    onAuthStateChanged: vi.fn(),
    sendPasswordResetEmail: vi.fn(),
    updateProfile: vi.fn(),
  };
});

vi.mock("firebase/firestore", () => ({
  doc: vi.fn(),
  setDoc: vi.fn(),
  getDoc: vi.fn(),
  serverTimestamp: vi.fn(),
}));

vi.mock("./firebase", () => ({
  auth: { currentUser: null },
  db: {},
}));

describe("auth service", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    auth.currentUser = null;
  });

  it("signs out the current Firebase user", async () => {
    vi.mocked(firebaseSignOut).mockResolvedValue(undefined);

    await expect(signOut()).resolves.toEqual({ success: true });
    expect(firebaseSignOut).toHaveBeenCalledWith(auth);
  });

  it("returns the Firebase sign-out error", async () => {
    const error = new Error("Sign out failed");
    vi.mocked(firebaseSignOut).mockRejectedValue(error);
    const consoleError = vi.spyOn(console, "error").mockImplementation(() => {});

    await expect(signOut()).resolves.toEqual({
      success: false,
      error: "Sign out failed",
    });
    expect(consoleError).toHaveBeenCalledWith("Sign-out error:", error);
    consoleError.mockRestore();
  });

  it("returns null when no user is signed in", () => {
    expect(getCurrentUser()).toBeNull();
  });

  it("returns the current Firebase user", () => {
    const user = { uid: "test-user", email: "test@example.com" };
    auth.currentUser = user;
    expect(getCurrentUser()).toBe(user);
  });
});
