import { act, render, screen } from "@testing-library/react";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { onIdTokenChanged } from "firebase/auth";
import { AuthProvider, useAuth } from "./AuthContext";

vi.mock("firebase/auth", () => ({
  onIdTokenChanged: vi.fn(),
}));

vi.mock("../lib/firebase", () => ({
  auth: {},
}));

function AuthState() {
  const { user, loading, isAuthenticated, isAdmin } = useAuth();
  return (
    <div>
      <span data-testid="uid">{user?.uid || "none"}</span>
      <span data-testid="loading">{String(loading)}</span>
      <span data-testid="authenticated">{String(isAuthenticated)}</span>
      <span data-testid="admin">{String(isAdmin)}</span>
    </div>
  );
}

describe("AuthProvider trusted admin claims", () => {
  let tokenListener;

  beforeEach(() => {
    tokenListener = undefined;
    vi.clearAllMocks();
    onIdTokenChanged.mockImplementation((_auth, listener) => {
      tokenListener = listener;
      return vi.fn();
    });
  });

  function renderProvider() {
    render(
      <AuthProvider>
        <AuthState />
      </AuthProvider>,
    );
    expect(onIdTokenChanged).toHaveBeenCalledOnce();
    expect(tokenListener).toEqual(expect.any(Function));
  }

  it("grants admin state only from a verified ID-token claim", async () => {
    renderProvider();
    const user = {
      uid: "platform-admin",
      getIdTokenResult: vi.fn().mockResolvedValue({
        claims: { admin: true },
      }),
    };

    await act(async () => {
      await tokenListener(user);
    });

    expect(user.getIdTokenResult).toHaveBeenCalledOnce();
    expect(screen.getByTestId("uid")).toHaveTextContent("platform-admin");
    expect(screen.getByTestId("authenticated")).toHaveTextContent("true");
    expect(screen.getByTestId("admin")).toHaveTextContent("true");
    expect(screen.getByTestId("loading")).toHaveTextContent("false");
  });

  it("does not trust an admin-shaped field on the client user object", async () => {
    renderProvider();
    const user = {
      uid: "normal-user",
      admin: true,
      getIdTokenResult: vi.fn().mockResolvedValue({
        claims: {},
      }),
    };

    await act(async () => {
      await tokenListener(user);
    });

    expect(screen.getByTestId("authenticated")).toHaveTextContent("true");
    expect(screen.getByTestId("admin")).toHaveTextContent("false");
  });

  it("clears claims when the Firebase session signs out", async () => {
    renderProvider();
    const user = {
      uid: "platform-admin",
      getIdTokenResult: vi.fn().mockResolvedValue({
        claims: { admin: true },
      }),
    };

    await act(async () => {
      await tokenListener(user);
    });
    expect(screen.getByTestId("admin")).toHaveTextContent("true");

    await act(async () => {
      await tokenListener(null);
    });

    expect(screen.getByTestId("uid")).toHaveTextContent("none");
    expect(screen.getByTestId("authenticated")).toHaveTextContent("false");
    expect(screen.getByTestId("admin")).toHaveTextContent("false");
  });

  it("fails closed when token claims cannot be read", async () => {
    const consoleError = vi
      .spyOn(console, "error")
      .mockImplementation(() => {});
    renderProvider();
    const user = {
      uid: "claim-error-user",
      getIdTokenResult: vi.fn().mockRejectedValue(new Error("token failure")),
    };

    await act(async () => {
      await tokenListener(user);
    });

    expect(screen.getByTestId("authenticated")).toHaveTextContent("true");
    expect(screen.getByTestId("admin")).toHaveTextContent("false");
    expect(screen.getByTestId("loading")).toHaveTextContent("false");
    consoleError.mockRestore();
  });
});
