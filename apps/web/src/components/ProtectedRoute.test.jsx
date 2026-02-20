import { describe, it, expect, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import { MemoryRouter, Routes, Route } from "react-router-dom";
import { ProtectedRoute } from "./ProtectedRoute";
import { useAuth } from "../contexts/AuthContext";

// Mock the useAuth hook
vi.mock("../contexts/AuthContext", () => ({
  useAuth: vi.fn(),
}));

describe("ProtectedRoute", () => {
  it("renders loading state when loading is true", () => {
    useAuth.mockReturnValue({
      user: null,
      loading: true,
    });

    const { container } = render(
      <MemoryRouter>
        <ProtectedRoute>
          <div data-testid="protected-content">Protected Content</div>
        </ProtectedRoute>
      </MemoryRouter>,
    );

    // Check for the spinner (animate-spin class)
    const spinner = container.querySelector(".animate-spin");
    expect(spinner).toBeInTheDocument();
    expect(screen.queryByTestId("protected-content")).not.toBeInTheDocument();
  });

  it("redirects to /auth when user is not authenticated", () => {
    useAuth.mockReturnValue({
      user: null,
      loading: false,
    });

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

    // Should have redirected to /auth
    expect(screen.getByText("Auth Page")).toBeInTheDocument();
    expect(screen.queryByTestId("protected-content")).not.toBeInTheDocument();
  });

  it("renders children when user is authenticated", () => {
    useAuth.mockReturnValue({
      user: { id: "user-123", email: "test@example.com" },
      loading: false,
    });

    render(
      <MemoryRouter>
        <ProtectedRoute>
          <div data-testid="protected-content">Protected Content</div>
        </ProtectedRoute>
      </MemoryRouter>,
    );

    // Should render the protected content
    expect(screen.getByTestId("protected-content")).toBeInTheDocument();
    expect(screen.getByText("Protected Content")).toBeInTheDocument();
  });
});
