import { describe, it, expect } from "vitest";
import {
  getScreenHtmlPath,
  getScreenImagePath,
  getAllScreens,
  STITCH_SCREENS,
} from "./index";

describe("stitch-screens/index", () => {
  describe("getAllScreens", () => {
    it("should return a flat array of all screens", () => {
      const screens = getAllScreens();
      expect(Array.isArray(screens)).toBe(true);
      expect(screens.length).toBeGreaterThan(0);
      expect(screens).toContain("welcome_to_kinship_1");
      expect(screens).toContain("aevum_secure_auth");
    });

    it("should contain screens from different categories", () => {
      const screens = getAllScreens();
      // Onboarding
      expect(screens).toContain(STITCH_SCREENS.onboarding.welcome[0]);
      // Admin
      expect(screens).toContain(STITCH_SCREENS.admin.infrastructure[0]);
    });
  });

  describe("getScreenHtmlPath", () => {
    it("should return the correct path for a valid screen folder", () => {
      const screenFolder = "welcome_to_kinship_1";
      const path = getScreenHtmlPath(screenFolder);
      expect(path).toBe(`/src/stitch-screens/${screenFolder}/code.html`);
    });

    it("should return null for an invalid screen folder", () => {
      const path = getScreenHtmlPath("invalid_screen_folder_123");
      expect(path).toBeNull();
    });
  });

  describe("getScreenImagePath", () => {
    it("should return the correct path for a valid screen folder", () => {
      const screenFolder = "aevum_secure_auth";
      const path = getScreenImagePath(screenFolder);
      expect(path).toBe(`/src/stitch-screens/${screenFolder}/screen.png`);
    });

    it("should return null for an invalid screen folder", () => {
      const path = getScreenImagePath("non_existent_folder");
      expect(path).toBeNull();
    });
  });
});
