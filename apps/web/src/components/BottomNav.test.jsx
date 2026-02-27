import { describe, it, expect, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { MemoryRouter } from "react-router-dom";
import BottomNav from "./BottomNav";

// Mock useNavigate from react-router-dom
const mockNavigate = vi.fn();
vi.mock("react-router-dom", async () => {
  const actual = await vi.importActual("react-router-dom");
  return {
    ...actual,
    useNavigate: () => mockNavigate,
  };
});

describe("BottomNav Component", () => {
  it("renders with correct semantic structure and CSS classes", () => {
    const { container } = render(
      <MemoryRouter>
        <BottomNav />
      </MemoryRouter>
    );

    const navElement = container.querySelector("nav");
    expect(navElement).toBeInTheDocument();
    expect(navElement).toHaveClass("bottom-nav-fixed");

    const glassContainer = container.querySelector(".bottom-nav-glass");
    expect(glassContainer).toBeInTheDocument();
  });

  it("renders all five navigation items correctly", () => {
    render(
      <MemoryRouter>
        <BottomNav />
      </MemoryRouter>
    );

    const navItems = ["Home", "Tree", "Map", "Vault", "Profile"];
    navItems.forEach((label) => {
      expect(screen.getByText(label)).toBeInTheDocument();
    });

    const icons = ["home", "account_tree", "map", "photo_library", "person"];
    icons.forEach((icon) => {
      expect(screen.getByText(icon)).toBeInTheDocument();
    });
  });

  it("highlights the Tree item as active when on /family-tree path", () => {
    render(
      <MemoryRouter initialEntries={["/family-tree"]}>
        <BottomNav />
      </MemoryRouter>
    );

    // Tree should be active
    const treeButton = screen.getByText("Tree").closest("button");
    expect(treeButton).toHaveClass("active");

    // Others should not be active
    const homeButton = screen.getByText("Home").closest("button");
    expect(homeButton).not.toHaveClass("active");
  });

  it("highlights the Profile item as active when on /settings path", () => {
    render(
      <MemoryRouter initialEntries={["/settings"]}>
        <BottomNav />
      </MemoryRouter>
    );

    // Profile should be active
    const profileButton = screen.getByText("Profile").closest("button");
    expect(profileButton).toHaveClass("active");

    const treeButton = screen.getByText("Tree").closest("button");
    expect(treeButton).not.toHaveClass("active");
  });

  it("does not highlight any item when on an unknown route", () => {
    render(
      <MemoryRouter initialEntries={["/unknown-route"]}>
        <BottomNav />
      </MemoryRouter>
    );

    const navItems = ["Home", "Tree", "Map", "Vault", "Profile"];
    navItems.forEach((label) => {
      const button = screen.getByText(label).closest("button");
      expect(button).not.toHaveClass("active");

      const icon = button.querySelector(".material-symbols-outlined");
      expect(icon).not.toHaveClass("filled");
    });
  });

  it("navigates to the correct path when an item is clicked", () => {
    render(
      <MemoryRouter>
        <BottomNav />
      </MemoryRouter>
    );

    // Click on Vault
    fireEvent.click(screen.getByText("Vault"));
    expect(mockNavigate).toHaveBeenCalledWith("/memories");

    // Click on Map
    fireEvent.click(screen.getByText("Map"));
    expect(mockNavigate).toHaveBeenCalledWith("/heritage-map");
  });

  it("applies 'filled' class to icons of active items", () => {
    render(
      <MemoryRouter initialEntries={["/dashboard"]}>
        <BottomNav />
      </MemoryRouter>
    );

    // Home is active at /dashboard
    const homeIcon = screen.getByText("home");
    expect(homeIcon).toHaveClass("filled");

    const treeIcon = screen.getByText("account_tree");
    expect(treeIcon).not.toHaveClass("filled");
  });
});
