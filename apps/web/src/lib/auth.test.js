import { describe, it, expect, vi } from "vitest";
import { getCurrentUser } from "./auth";
import { auth } from "./firebase";

// Mock firebase/auth
vi.mock("firebase/auth", () => ({
  GoogleAuthProvider: vi.fn(),
  OAuthProvider: vi.fn(),
  signInWithPopup: vi.fn(),
  signInWithEmailAndPassword: vi.fn(),
  createUserWithEmailAndPassword: vi.fn(),
  signOut: vi.fn(),
  onAuthStateChanged: vi.fn(),
  sendPasswordResetEmail: vi.fn(),
  updateProfile: vi.fn(),
  getAuth: vi.fn(),
}));

// Mock firebase/firestore
vi.mock("firebase/firestore", () => ({
  doc: vi.fn(),
  setDoc: vi.fn(),
  getDoc: vi.fn(),
  serverTimestamp: vi.fn(),
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
