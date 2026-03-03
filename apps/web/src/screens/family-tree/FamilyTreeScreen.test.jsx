import { describe, it, expect, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { MemoryRouter } from "react-router-dom";
import FamilyTreeScreen from "./FamilyTreeScreen";

// Mock auth context
vi.mock("@/contexts/AuthContext", () => ({
  useAuth: () => ({
    user: {
      uid: "test-user-id",
      displayName: "Test User",
      photoURL: "test-photo.jpg",
    },
  }),
}));

// Mock firestore functions
vi.mock("@lib/firestore", () => ({
  subscribeToFamilies: vi.fn((userId, callback) => {
    callback([{ id: "fam1", name: "Test Family" }]);
    return () => {};
  }),
  subscribeToFamilyMembers: vi.fn((familyId, callback) => {
    callback([
      { id: "m1", name: "Grandpa John", role: "Grandfather" },
      { id: "m2", name: "Grandma Mary", role: "Grandmother" },
    ]);
    return () => {};
  }),
}));

describe("FamilyTreeScreen", () => {
  it("renders correctly with family data", () => {
    render(
      <MemoryRouter>
        <FamilyTreeScreen />
      </MemoryRouter>,
    );

    // Check header
    expect(screen.getByText("Test Family")).toBeInTheDocument();

    // Check user card
    expect(screen.getByText("Test User")).toBeInTheDocument();
    expect(screen.getByText("YOU")).toBeInTheDocument();

    // Check family members
    expect(screen.getByText("Grandpa John")).toBeInTheDocument();
    expect(screen.getByText("Grandma Mary")).toBeInTheDocument();
  });

  it("handles zoom controls", () => {
    render(
      <MemoryRouter>
        <FamilyTreeScreen />
      </MemoryRouter>,
    );

    const zoomInBtn = screen.getByTitle("Zoom In");
    const zoomOutBtn = screen.getByTitle("Zoom Out");

    expect(zoomInBtn).toBeInTheDocument();
    expect(zoomOutBtn).toBeInTheDocument();

    // Just verifying buttons exist and are clickable
    fireEvent.click(zoomInBtn);
    fireEvent.click(zoomOutBtn);
  });
});
