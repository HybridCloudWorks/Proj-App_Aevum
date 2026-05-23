/**
 * Stitch Screens Index
 *
 * Auto-generated index of all 57 Stitch screens exported from Aevum project.
 * Each screen is a folder containing code.html and screen.png
 */

export const STITCH_SCREENS = {
  // Onboarding / Welcome
  onboarding: {
    welcome: [
      "welcome_to_kinship_1",
      "welcome_to_kinship_2",
      "welcome_to_kinship_3",
      "welcome_to_kinship_4",
    ],
    journey: [
      "start_your_aevum_journey_1",
      "start_your_aevum_journey_2",
      "start_your_aevum_journey_3",
      "start_your_aevum_journey_4",
      "start_your_aevum_journey_5",
      "start_your_aevum_journey_6",
    ],
    privacy: ["aevum_onboarding__privacy_rules"],
  },

  // Authentication
  auth: {
    login: ["aevum_secure_auth"],
  },

  // Family Tree
  familyTree: {
    explorer: ["family_tree_explorer_1", "family_tree_explorer_2"],
    identifyGrow: ["identify_&_grow_tree"],
  },

  // Memories
  memories: {
    member: [
      "member_memories_1",
      "member_memories_2",
      "member_memories_3",
      "member_memories_4",
    ],
  },

  // Heritage Map
  heritageMap: {
    global: [
      "aevum_global_heritage_map_1",
      "aevum_global_heritage_map_2",
      "aevum_global_heritage_map_3",
      "aevum_global_heritage_map_4",
      "aevum_global_heritage_map_5",
      "aevum_global_heritage_map_6",
      "aevum_global_heritage_map_7",
      "aevum_global_heritage_map_8",
      "aevum_global_heritage_map_9",
      "aevum_global_heritage_map_10",
    ],
    search: ["global_heritage_search"],
  },

  // AI Features
  ai: {
    identityMatcher: ["ai_identity_matcher_1", "ai_identity_matcher_2"],
    chronicles: ["ai_family_chronicles"],
  },

  // Identity & Profile
  identity: {
    profile: ["aevum_identity_profile"],
    restricted: ["restricted_parent_profile"],
  },

  // Admin
  admin: {
    infrastructure: [
      "aevum_admin_infrastructure_1",
      "aevum_admin_infrastructure_2",
      "aevum_admin_infrastructure_3",
      "aevum_admin_infrastructure_4",
      "aevum_admin_infrastructure_5",
      "aevum_admin_infrastructure_6",
      "aevum_admin_infrastructure_7",
      "aevum_admin_infrastructure_8",
      "aevum_admin_infrastructure_9",
      "aevum_admin_infrastructure_10",
      "aevum_admin_infrastructure_11",
      "aevum_admin_infrastructure_12",
      "aevum_admin_infrastructure_13",
    ],
    delegation: ["aevum_admin_delegation_1", "aevum_admin_delegation_2"],
  },

  // Catalog & Deployment
  catalog: {
    engine: ["aevum_catalog_engine"],
    deployment: ["aevum_frontend_deployment_hub"],
  },

  // Settings
  settings: {
    privacy: ["privacy_&_security_settings"],
    data: ["data_structure_&_portability"],
  },

  // Firebase
  firebase: {
    nerveCenter: ["aevum_firebase_nerve_center"],
  },

  // Design System
  design: {
    audit: ["aevum_design_system_audit"],
  },

  // Launch
  launch: {
    alpha: ["aevum_alpha_launch_control"],
  },
};

/**
 * Get the path to a screen's HTML file
 */
export function getScreenHtmlPath(screenFolder) {
  if (!getAllScreens().includes(screenFolder)) return null;
  return `/src/stitch-screens/${screenFolder}/code.html`;
}

/**
 * Get the path to a screen's preview image
 */
export function getScreenImagePath(screenFolder) {
  if (!getAllScreens().includes(screenFolder)) return null;
  return `/src/stitch-screens/${screenFolder}/screen.png`;
}

/**
 * Get all screens as a flat array
 */
export function getAllScreens() {
  const screens = [];
  Object.values(STITCH_SCREENS).forEach((category) => {
    Object.values(category).forEach((screenList) => {
      screens.push(...screenList);
    });
  });
  return screens;
}

export default STITCH_SCREENS;
