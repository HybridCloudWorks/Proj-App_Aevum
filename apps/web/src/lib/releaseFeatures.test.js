import { describe, expect, it } from "vitest";
import {
  FEATURE_STATUS,
  getRouteStatus,
  isPrototypeRoute,
  isRouteReleased,
  RELEASE_FEATURES,
} from "./releaseFeatures";

describe("Private Beta feature registry", () => {
  it("maintains every release classification", () => {
    expect(new Set(Object.values(RELEASE_FEATURES))).toEqual(
      new Set(Object.values(FEATURE_STATUS)),
    );
  });

  it("classifies validated core capabilities as production or beta", () => {
    expect(RELEASE_FEATURES.securityAuthorization).toBe("production");
    expect(RELEASE_FEATURES.coreFamilyArchive).toBe("beta");
    expect(RELEASE_FEATURES.canonicalMediaUpload).toBe("beta");
    expect(RELEASE_FEATURES.authentication).toBe("beta");
  });

  it("classifies restoration and spatial routes as prototypes", () => {
    expect(RELEASE_FEATURES.aiRestoration).toBe("prototype");
    expect(RELEASE_FEATURES.spatialExperiences).toBe("prototype");
    expect(getRouteStatus("/ai/restoration")).toBe("prototype");
    expect(isPrototypeRoute("/family-tree/spatial")).toBe(true);
    expect(isRouteReleased("/ai/restoration")).toBe(false);
  });

  it("keeps core routes released by default", () => {
    expect(isPrototypeRoute("/dashboard")).toBe(false);
    expect(isPrototypeRoute("/family-tree")).toBe(false);
    expect(isPrototypeRoute("/memories")).toBe(false);
    expect(isRouteReleased("/dashboard")).toBe(true);
  });

  it("keeps planned admin telemetry and routes unavailable", () => {
    expect(RELEASE_FEATURES.adminOperationalTelemetry).toBe("planned");
    expect(getRouteStatus("/admin")).toBe("planned");
    expect(getRouteStatus("/admin/operations")).toBe("planned");
    expect(isRouteReleased("/admin")).toBe(false);
  });
});
