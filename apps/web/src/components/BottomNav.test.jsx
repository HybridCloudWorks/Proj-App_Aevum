/**
 * @vitest-environment jsdom
 */

import React from 'react';
import { describe, it, expect, vi, afterEach } from "vitest";
import { render, screen, fireEvent, waitFor, cleanup } from "@testing-library/react";
import { MemoryRouter } from "react-router-dom";
import BottomNav from "./BottomNav";
import * as matchers from "@testing-library/jest-dom/matchers";

expect.extend(matchers);

// Ensure DOM is cleaned up after each test to prevent duplicates
afterEach(() => {
  cleanup();
});

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

  it("highlights the Tree item as active when on /family-tree path", async () => {
    render(
      <MemoryRouter initialEntries={["/family-tree"]}>
         <BottomNav />
      </MemoryRouter>
    );

    await waitFor(() => {
        const treeButton = screen.getByText("Tree").closest("button");
        expect(treeButton).toHaveClass("active");
    });

    const homeButton = screen.getByText("Home").closest("button");
    expect(homeButton).not.toHaveClass("active");
  });

  it("highlights the Profile item as active when on /settings path", async () => {
    render(
      <MemoryRouter initialEntries={["/settings"]}>
        <BottomNav />
      </MemoryRouter>
    );

     await waitFor(() => {
        const profileButton = screen.getByText("Profile").closest("button");
        expect(profileButton).toHaveClass("active");
     });

    const treeButton = screen.getByText("Tree").closest("button");
    expect(treeButton).not.toHaveClass("active");
  });

  it("highlights the Home item as active when on /dashboard path", async () => {
    render(
      <MemoryRouter initialEntries={["/dashboard"]}>
        <BottomNav />
      </MemoryRouter>
    );

     await waitFor(() => {
        const homeButton = screen.getByText("Home").closest("button");
        expect(homeButton).toHaveClass("active");
     });
  });

  it("highlights the Map item as active when on /heritage-map path", async () => {
    render(
      <MemoryRouter initialEntries={["/heritage-map"]}>
        <BottomNav />
      </MemoryRouter>
    );

     await waitFor(() => {
        const mapButton = screen.getByText("Map").closest("button");
        expect(mapButton).toHaveClass("active");
     });
  });

  it("highlights the Vault item as active when on /memories path", async () => {
    render(
      <MemoryRouter initialEntries={["/memories"]}>
        <BottomNav />
      </MemoryRouter>
    );

     await waitFor(() => {
        const vaultButton = screen.getByText("Vault").closest("button");
        expect(vaultButton).toHaveClass("active");
     });
  });

  it("does not highlight any item when on an unknown route", async () => {
    const { container } = render(
      <MemoryRouter initialEntries={["/unknown-route"]}>
        <BottomNav />
      </MemoryRouter>
    );

    await waitFor(() => {
        const activeElements = container.querySelectorAll(".nav-item.active");
        expect(activeElements.length).toBe(0);
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

  it("applies 'filled' class to icons of active items", async () => {
    render(
      <MemoryRouter initialEntries={["/dashboard"]}>
        <BottomNav />
      </MemoryRouter>
    );

    await waitFor(() => {
        const homeButton = screen.getByText("Home").closest("button");
        const homeIcon = homeButton.querySelector(".material-symbols-outlined");
        expect(homeIcon).toHaveClass("filled");
    });
  });
});
