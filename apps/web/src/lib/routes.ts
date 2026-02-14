/**
 * Application Route Registry
 * Defines all route paths and metadata for the application.
 */

export const ROUTES = {
  // Public Routes
  GALLERY: '/gallery',
  HOME: '/',
  WELCOME: '/welcome',
  AUTH: '/auth',

  // Core Features
  DASHBOARD: '/dashboard',
  FAMILY_TREE: '/family-tree',
  MEMORIES: '/memories',
  EXPLORER: '/explorer',
  VAULT: '/vault',
  LEGACY: '/legacy',
  HERITAGE_MAP: '/heritage-map',
  PROFILE: '/profile',
  SETTINGS: '/settings',

  // Stories
  STORY_DETAILS: '/story/:id',
  STORY_SAMPLE: '/story/sample-id',

  // Upload
  UPLOAD: '/upload',
  UPLOAD_CONFLICT: '/upload/conflict',

  // Messaging
  MESSAGES: '/messages',
  MESSAGES_ACCESS: '/messages/access/:id',
  MESSAGES_COLLAB: '/messages/collab/:id',

  // AI Features
  AI_HUB: '/ai',
  AI_IDENTITY_MATCHER: '/ai/identity-matcher',
  AI_DISCOVERY: '/ai/discovery',
  AI_RESTORATION: '/ai/restoration',
  AI_IDENTITY_TAGGING: '/ai/identity-tagging',
  AI_RESOURCE_MANAGER: '/ai/resource-manager',
  APPROVAL_HUB: '/approval-hub',

  // Settings Sub-pages
  SETTINGS_DELEGATION: '/settings/delegation',
  SETTINGS_LEGACY_HANDOVER: '/settings/legacy-handover',
  SETTINGS_INFRASTRUCTURE: '/settings/infrastructure',
  SETTINGS_VAULT_HEALTH: '/settings/vault-health',
  SETTINGS_REDUNDANCY: '/settings/redundancy',
  SETTINGS_STORAGE_ARCHITECTURE: '/settings/storage-architecture',
  SETTINGS_CATALOG_ENGINE: '/settings/catalog-engine',
  SETTINGS_PRIVACY_RULES: '/settings/privacy-rules',
  SETTINGS_PRIVACY_SECURITY: '/settings/privacy-security',
  SETTINGS_RESTRICTED_PROFILE: '/settings/restricted-profile/:userId',

  // Spatial Features
  SPATIAL_GALLERY: '/memories/spatial-gallery',
  SPATIAL_HERITAGE_TREE: '/family-tree/spatial',

  // Admin
  ADMIN_ROOT: '/admin/*',
};

/**
 * Route Metadata
 * Defines properties for each route (auth requirement, layout, roles, etc.)
 */
export const ROUTE_CONFIG = {
  [ROUTES.GALLERY]: { protected: false, layout: false },
  [ROUTES.HOME]: { protected: false, layout: false },
  [ROUTES.WELCOME]: { protected: false, layout: false },
  [ROUTES.AUTH]: { protected: false, layout: false },

  // Core
  [ROUTES.DASHBOARD]: { protected: true, layout: true },
  [ROUTES.FAMILY_TREE]: { protected: true, layout: true },
  [ROUTES.MEMORIES]: { protected: true, layout: true },
  [ROUTES.EXPLORER]: { protected: true, layout: true },
  [ROUTES.VAULT]: { protected: true, layout: true },
  [ROUTES.LEGACY]: { protected: true, layout: true },
  [ROUTES.HERITAGE_MAP]: { protected: true, layout: true },
  [ROUTES.PROFILE]: { protected: true, layout: true },
  [ROUTES.SETTINGS]: { protected: true, layout: true },

  // Stories
  [ROUTES.STORY_DETAILS]: { protected: true, layout: true },
  [ROUTES.STORY_SAMPLE]: { protected: true, layout: true },

  // Upload
  [ROUTES.UPLOAD]: { protected: true, layout: true },
  [ROUTES.UPLOAD_CONFLICT]: { protected: true, layout: true },

  // Messaging
  [ROUTES.MESSAGES]: { protected: true, layout: true },
  [ROUTES.MESSAGES_ACCESS]: { protected: true, layout: false },
  [ROUTES.MESSAGES_COLLAB]: { protected: true, layout: false },

  // AI
  [ROUTES.AI_HUB]: { protected: true, layout: true },
  [ROUTES.AI_IDENTITY_MATCHER]: { protected: true, layout: false },
  [ROUTES.AI_DISCOVERY]: { protected: true, layout: false },
  [ROUTES.AI_RESTORATION]: { protected: true, layout: false },
  [ROUTES.AI_IDENTITY_TAGGING]: { protected: true, layout: false },
  [ROUTES.AI_RESOURCE_MANAGER]: { protected: true, layout: false },
  [ROUTES.APPROVAL_HUB]: { protected: true, layout: false },

  // Settings Sub-pages
  [ROUTES.SETTINGS_DELEGATION]: { protected: true, layout: false },
  [ROUTES.SETTINGS_LEGACY_HANDOVER]: { protected: true, layout: false },
  [ROUTES.SETTINGS_INFRASTRUCTURE]: { protected: true, layout: false },
  [ROUTES.SETTINGS_VAULT_HEALTH]: { protected: true, layout: false },
  [ROUTES.SETTINGS_REDUNDANCY]: { protected: true, layout: false },
  [ROUTES.SETTINGS_STORAGE_ARCHITECTURE]: { protected: true, layout: false },
  [ROUTES.SETTINGS_CATALOG_ENGINE]: { protected: true, layout: false },
  [ROUTES.SETTINGS_PRIVACY_RULES]: { protected: true, layout: false },
  [ROUTES.SETTINGS_PRIVACY_SECURITY]: { protected: true, layout: false },
  [ROUTES.SETTINGS_RESTRICTED_PROFILE]: { protected: true, layout: false },

  // Spatial
  [ROUTES.SPATIAL_GALLERY]: { protected: true, layout: false },
  [ROUTES.SPATIAL_HERITAGE_TREE]: { protected: true, layout: false },

  // Admin
  [ROUTES.ADMIN_ROOT]: { protected: true, layout: false, role: 'admin' },
};
