import { describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import { MemoryRouter } from "react-router-dom";
import NotFoundScreen from "./NotFoundScreen";
import { useAuth } from "@/contexts/AuthContext";

vi.mock("@/contexts/AuthContext", () => ({
  useAuth: vi.fn(),
}));

describe("NotFoundScreen", () => {
  it("returns authenticated users to the dashboard", () => {
    useAuth.mockReturnValue({ isAuthenticated: true, loading: false });

    render(
      <MemoryRouter initialEntries={["/missing-page"]}>
        <NotFoundScreen />
      </MemoryRouter>,
    );

    expect(screen.getByRole("heading", { name: "Page not found" })).toBeInTheDocument();
    expect(screen.getByRole("link", { name: "Return to dashboard" })).toHaveAttribute(
      "href",
      "/dashboard",
    );
    expect(screen.getByLabelText("Requested path")).toHaveTextContent("/missing-page");
  });

  it("returns signed-out users home", () => {
    useAuth.mockReturnValue({ isAuthenticated: false, loading: false });

    render(
      <MemoryRouter initialEntries={["/missing-page"]}>
        <NotFoundScreen />
      </MemoryRouter>,
    );

    expect(screen.getByRole("link", { name: "Return home" })).toHaveAttribute("href", "/");
  });
});
