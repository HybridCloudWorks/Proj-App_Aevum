const prototypePrefixes = [
  "/story/sample-id",
  "/ai/identity-matcher",
  "/ai/discovery",
  "/ai/restoration",
  "/ai/identity-tagging",
  "/ai/resource-manager",
  "/memories/spatial-gallery",
  "/family-tree/spatial",
  "/settings/infrastructure",
  "/settings/vault-health",
  "/settings/redundancy",
  "/settings/storage-architecture",
  "/settings/catalog-engine",
];

export const PROTOTYPE_FEATURES_ENABLED =
  import.meta.env.VITE_ENABLE_PROTOTYPE_FEATURES === "true";

export function isPrototypeRoute(pathname) {
  return prototypePrefixes.some(
    (prefix) => pathname === prefix || pathname.startsWith(`${prefix}/`),
  );
}

export function isRouteReleased(pathname) {
  return PROTOTYPE_FEATURES_ENABLED || !isPrototypeRoute(pathname);
}

export const RELEASE_FEATURES = Object.freeze({
  coreFamilyArchive: "beta",
  canonicalMediaUpload: "beta",
  authentication: "beta",
  familyCollaboration: "beta",
  aiMetadataAnalysis: "beta",
  aiRestoration: "prototype",
  identityMatcher: "prototype",
  semanticDiscovery: "prototype",
  spatialExperiences: "prototype",
  infrastructureDemoScreens: "prototype",
});
