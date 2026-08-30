export const FEATURE_STATUS = Object.freeze({
  PRODUCTION: "production",
  BETA: "beta",
  PROTOTYPE: "prototype",
  PLANNED: "planned",
});

const routeRegistry = Object.freeze([
  { prefix: "/admin", status: FEATURE_STATUS.PLANNED },
  { prefix: "/story/sample-id", status: FEATURE_STATUS.PROTOTYPE },
  { prefix: "/ai/identity-matcher", status: FEATURE_STATUS.PROTOTYPE },
  { prefix: "/ai/discovery", status: FEATURE_STATUS.PROTOTYPE },
  { prefix: "/ai/restoration", status: FEATURE_STATUS.PROTOTYPE },
  { prefix: "/ai/identity-tagging", status: FEATURE_STATUS.PROTOTYPE },
  { prefix: "/ai/resource-manager", status: FEATURE_STATUS.PROTOTYPE },
  { prefix: "/memories/spatial-gallery", status: FEATURE_STATUS.PROTOTYPE },
  { prefix: "/family-tree/spatial", status: FEATURE_STATUS.PROTOTYPE },
  { prefix: "/settings/infrastructure", status: FEATURE_STATUS.PROTOTYPE },
  { prefix: "/settings/vault-health", status: FEATURE_STATUS.PROTOTYPE },
  { prefix: "/settings/redundancy", status: FEATURE_STATUS.PROTOTYPE },
  {
    prefix: "/settings/storage-architecture",
    status: FEATURE_STATUS.PROTOTYPE,
  },
  { prefix: "/settings/catalog-engine", status: FEATURE_STATUS.PROTOTYPE },
]);

export const PROTOTYPE_FEATURES_ENABLED =
  import.meta.env.VITE_ENABLE_PROTOTYPE_FEATURES === "true";

export const RELEASE_FEATURES = Object.freeze({
  securityAuthorization: FEATURE_STATUS.PRODUCTION,
  coreFamilyArchive: FEATURE_STATUS.BETA,
  canonicalMediaUpload: FEATURE_STATUS.BETA,
  authentication: FEATURE_STATUS.BETA,
  familyCollaboration: FEATURE_STATUS.BETA,
  aiMetadataAnalysis: FEATURE_STATUS.BETA,
  aiRestoration: FEATURE_STATUS.PROTOTYPE,
  identityMatcher: FEATURE_STATUS.PROTOTYPE,
  semanticDiscovery: FEATURE_STATUS.PROTOTYPE,
  spatialExperiences: FEATURE_STATUS.PROTOTYPE,
  infrastructureDemoScreens: FEATURE_STATUS.PROTOTYPE,
  adminOperationalTelemetry: FEATURE_STATUS.PLANNED,
});

export function getRouteStatus(pathname) {
  const match = routeRegistry.find(
    ({ prefix }) =>
      pathname === prefix || pathname.startsWith(`${prefix}/`),
  );
  return match?.status ?? FEATURE_STATUS.BETA;
}

export function isPrototypeRoute(pathname) {
  return getRouteStatus(pathname) === FEATURE_STATUS.PROTOTYPE;
}

export function isRouteReleased(pathname) {
  const status = getRouteStatus(pathname);
  if (status === FEATURE_STATUS.PLANNED) return false;
  if (status === FEATURE_STATUS.PROTOTYPE) {
    return PROTOTYPE_FEATURES_ENABLED;
  }
  return true;
}
