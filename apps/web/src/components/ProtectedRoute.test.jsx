import { describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import { MemoryRouter, Route, Routes } from "react-router-dom";
import { ProtectedRoute } from "./ProtectedRoute";
import { useAuth } from "../contexts/AuthContext";

vi.mock("../contexts/AuthContext", () => ({
  useAuth: vi.fn(),
}));

describe("ProtectedRoute", () => {
  it("renders loading state while authentication is loading", () => {
    useAuth.mockReturnValue({ user: null, loading: true, isAdmin: false });

    const { container } = render(
      <MemoryRouter>
        <ProtectedRoute>
          <div data-testid="protected-content">Protected Content</div>
        </ProtectedRoute>
      </MemoryRouter>,
    );

    expect(container.querySelector(".animate-spin")).toBeInTheDocument();
    expect(screen.queryByTestId("protected-content")).not.toBeInTheDocument();
  });

  it("redirects unauthenticated users to /auth", () => {
    useAuth.mockReturnValue({ user: null, loading: false, isAdmin: false });

    render(
      <MemoryRouter initialEntries={["/dashboard"]}>
        <Routes>
          <Route path="/auth" element={<div>Auth Page</div>} />
          <Route
            path="/dashboard"
            element={
              <ProtectedRoute>
                <div data-testid="protected-content">Protected Content</div>
              </ProtectedRoute>
            }
          />
        </Routes>
      </MemoryRouter>,
    );

    expect(screen.getByText("Auth Page")).toBeInTheDocument();
    expect(screen.queryByTestId("protected-content")).not.toBeInTheDocument();
  });

  it("renders normal protected content for an authenticated user", () => {
    useAuth.mockReturnValue({
      user: { uid: "user-123", email: "test@example.com" },
      loading: false,
      isAdmin: false,
    });

    render(
      <MemoryRouter initialEntries={["/dashboard"]}>
        <ProtectedRoute>
          <div data-testid="protected-content">Protected Content</div>
        </ProtectedRoute>
      </MemoryRouter>,
    );

    expect(screen.getByTestId("protected-content")).toBeInTheDocument();
  });

  it("redirects an authenticated non-admin away from /admin", () => {
    useAuth.mockReturnValue({
      user: { uid: "user-123" },
      loading: false,
      isAdmin: false,
    });

    render(
      <MemoryRouter initialEntries={["/admin"]}>
        <Routes>
          <Route path="/dashboard" element={<div>Dashboard</div>} />
          <Route
            path="/admin"
            element={
              <ProtectedRoute>
                <div>Admin Console</div>
              </ProtectedRoute>
            }
          />
        </Routes>
      </MemoryRouter>,
    );

    expect(screen.getByText("Dashboard")).toBeInTheDocument();
    expect(screen.queryByText("Admin Console")).not.toBeInTheDocument();
  });

  it("keeps planned /admin unavailable to trusted admins", () => {
    useAuth.mockReturnValue({
      user: { uid: "admin-123" },
      loading: false,
      isAdmin: true,
    });

    render(
      <MemoryRouter initialEntries={["/admin"]}>
        <ProtectedRoute>
          <div>Admin Console</div>
        </ProtectedRoute>
      </MemoryRouter>,
    );

    expect(screen.getByText("Not in Private Beta")).toBeInTheDocument();
    expect(screen.queryByText("Admin Console")).not.toBeInTheDocument();
  });
});
