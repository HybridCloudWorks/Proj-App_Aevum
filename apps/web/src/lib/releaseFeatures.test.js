import { describe, expect, it } from "vitest";
import {
  isPrototypeRoute,
  isRouteReleased,
  RELEASE_FEATURES,
} from "./releaseFeatures";

describe("Private Beta feature registry", () => {
  it("classifies core family and media capabilities as beta", () => {
    expect(RELEASE_FEATURES.coreFamilyArchive).toBe("beta");
    expect(RELEASE_FEATURES.canonicalMediaUpload).toBe("beta");
    expect(RELEASE_FEATURES.authentication).toBe("beta");
  });

  it("classifies restoration and spatial experiments as prototypes", () => {
    expect(RELEASE_FEATURES.aiRestoration).toBe("prototype");
    expect(RELEASE_FEATURES.spatialExperiences).toBe("prototype");
    expect(isPrototypeRoute("/ai/restoration")).toBe(true);
    expect(isPrototypeRoute("/family-tree/spatial")).toBe(true);
  });

  it("keeps core routes released by default", () => {
    expect(isPrototypeRoute("/dashboard")).toBe(false);
    expect(isPrototypeRoute("/family-tree")).toBe(false);
    expect(isPrototypeRoute("/memories")).toBe(false);
    expect(isRouteReleased("/dashboard")).toBe(true);
  });
});
