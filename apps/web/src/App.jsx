/**
 * Aevum App Component
 *
 * Main application router and layout structure.
 * Following MAD and FED best practices:
 * - Lazy loading for route components
 * - Proper suspense boundaries
 * - Mobile-first navigation
 * - AuthProvider for auth state
 */

import { Suspense, lazy } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { AuthProvider } from "@/contexts/AuthContext";
import { ProtectedRoute } from "@/components/ProtectedRoute";
import AppErrorBoundary from "@/components/AppErrorBoundary";
import MainLayout from "@/layouts/MainLayout";
import { InfrastructureProvider } from "@/contexts/InfrastructureContext";
import { ROUTES } from "@/lib/routes";

// Lazy-loaded screen components (Code splitting per FED best practices)
const ScreenGallery = import.meta.env.DEV
  ? lazy(() => import("@screens/ScreenGallery"))
  : () => null;
const WelcomeScreen = lazy(() => import("@screens/onboarding/WelcomeScreen"));
const AuthScreen = lazy(() => import("@screens/auth/AuthScreen"));
const DashboardScreen = lazy(
  () => import("@screens/onboarding/DashboardScreen"),
);
const FamilyTreeScreen = lazy(
  () => import("@screens/family-tree/FamilyTreeScreen"),
);
const MemoriesScreen = lazy(() => import("@screens/memories/MemoriesScreen"));
const UploadScreen = lazy(() => import("@screens/memories/UploadScreen"));
const HeritageMapScreen = lazy(
  () => import("@screens/heritage-map/HeritageMapScreen"),
);
const AIFeaturesScreen = lazy(
  () => import("@screens/ai-features/AIFeaturesScreen"),
);
const ExplorerScreen = lazy(() => import("@screens/explorer/ExplorerScreen"));
const FamilyStoryScreen = lazy(
  () => import("@screens/stories/FamilyStoryScreen"),
);
const VaultScreen = lazy(() => import("@screens/vault/VaultScreen"));
const LegacyPlanningScreen = lazy(
  () => import("@screens/legacy/LegacyPlanningScreen"),
);

const IdentityMatcherScreen = lazy(
  () => import("@screens/ai-features/IdentityMatcherScreen"),
);
const SemanticDiscoveryScreen = lazy(
  () => import("@screens/ai-features/SemanticDiscoveryScreen"),
);
const IdentityScreen = lazy(() => import("@screens/identity/IdentityScreen"));
const MessengerHubScreen = lazy(
  () => import("@screens/messaging/MessengerHubScreen"),
);
const BranchAccessScreen = lazy(
  () => import("@screens/messaging/collaboration/BranchAccessScreen"),
);
const BranchCollaborationScreen = lazy(
  () => import("@screens/messaging/collaboration/BranchCollaborationScreen"),
);

const RestorationScreen = lazy(
  () => import("@screens/memories/RestorationScreen"),
);
const IdentityTaggingScreen = lazy(
  () => import("@screens/ai-features/IdentityTaggingScreen"),
);
const ApprovalHubScreen = lazy(
  () => import("@screens/approval/ApprovalHubScreen"),
);
const SettingsScreen = lazy(() => import("@screens/settings/SettingsScreen"));
const AdminDelegationScreen = lazy(
  () => import("@screens/settings/delegation/AdminDelegationScreen"),
);
const LegacyHandoverScreen = lazy(
  () => import("@screens/settings/legacy/LegacyHandoverScreen"),
);
const AdminScreen = lazy(() => import("@screens/admin/AdminScreen"));
const FileConflictScreen = lazy(
  () => import("@screens/memories/FileConflictScreen"),
);

const VaultHealthScreen = lazy(
  () => import("@screens/settings/infrastructure/VaultHealthScreen"),
);
const CloudRedundancyScreen = lazy(
  () => import("@screens/settings/infrastructure/CloudRedundancyScreen"),
);
const StorageArchitectureScreen = lazy(
  () => import("@screens/settings/infrastructure/StorageArchitectureScreen"),
);
const CatalogEngineScreen = lazy(
  () => import("@screens/settings/infrastructure/CatalogEngineScreen"),
);
const InfrastructureControlScreen = lazy(
  () => import("@screens/settings/infrastructure/InfrastructureControlScreen"),
);

const PrivacyRulesScreen = lazy(
  () => import("@screens/settings/privacy/PrivacyRulesScreen"),
);
const PrivacySecurityScreen = lazy(
  () => import("@screens/settings/privacy/PrivacySecurityScreen"),
);
const RestrictedProfileScreen = lazy(
  () => import("@screens/settings/privacy/RestrictedProfileScreen"),
);

const SpatialMemoryGallery = lazy(
  () => import("@screens/memories/SpatialMemoryGallery"),
);
const SpatialHeritageTree = lazy(
  () => import("@screens/family-tree/SpatialHeritageTree"),
);
const AIResourceManager = lazy(
  () => import("@screens/ai-features/AIResourceManager"),
);
const NotFoundScreen = lazy(() => import("@screens/errors/NotFoundScreen"));

// Loading fallback component
function LoadingFallback() {
  return (
    <div className="min-h-screen bg-background-dark flex flex-col items-center justify-center">
      <div className="animate-spin rounded-full h-10 w-10 border-t-2 border-b-2 border-primary mb-4" />
      <p className="text-gray-400 text-sm">Loading...</p>
    </div>
  );
}

function App() {
  return (
    <AppErrorBoundary>
      <AuthProvider>
        <InfrastructureProvider>
          <BrowserRouter>
            <Suspense fallback={<LoadingFallback />}>
              <Routes>
                {/* Screen Gallery - Browse all Stitch screens */}
                <Route path={ROUTES.GALLERY} element={<ScreenGallery />} />

                {/* Public routes */}
                <Route path={ROUTES.HOME} element={<WelcomeScreen />} />
                <Route path={ROUTES.WELCOME} element={<WelcomeScreen />} />
                <Route path={ROUTES.AUTH} element={<AuthScreen />} />

                {/* Main Application Routes */}
                <Route
                  path={ROUTES.MEMORIES}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <MemoriesScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.EXPLORER}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <ExplorerScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.VAULT}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <VaultScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.LEGACY}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <LegacyPlanningScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.STORY_DETAILS}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <FamilyStoryScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />
                {/* Temporary route to see the story without ID for demo */}
                <Route
                  path={ROUTES.STORY_SAMPLE}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <FamilyStoryScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.MESSAGES}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <MessengerHubScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />

                {/* Protected routes - Require authentication */}
                <Route
                  path={ROUTES.DASHBOARD}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <DashboardScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.FAMILY_TREE}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <FamilyTreeScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />

                <Route
                  path={ROUTES.UPLOAD}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <UploadScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.UPLOAD_CONFLICT}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <FileConflictScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.HERITAGE_MAP}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <HeritageMapScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.AI_HUB}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <AIFeaturesScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.AI_IDENTITY_MATCHER}
                  element={
                    <ProtectedRoute>
                      <IdentityMatcherScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.AI_DISCOVERY}
                  element={
                    <ProtectedRoute>
                      <SemanticDiscoveryScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.AI_RESTORATION}
                  element={
                    <ProtectedRoute>
                      <RestorationScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.AI_IDENTITY_TAGGING}
                  element={
                    <ProtectedRoute>
                      <IdentityTaggingScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.APPROVAL_HUB}
                  element={
                    <ProtectedRoute>
                      <ApprovalHubScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.MESSAGES_ACCESS}
                  element={
                    <ProtectedRoute>
                      <BranchAccessScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.MESSAGES_COLLAB}
                  element={
                    <ProtectedRoute>
                      <BranchCollaborationScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.PROFILE}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <IdentityScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.SETTINGS}
                  element={
                    <ProtectedRoute>
                      <MainLayout>
                        <SettingsScreen />
                      </MainLayout>
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.SETTINGS_DELEGATION}
                  element={
                    <ProtectedRoute>
                      <AdminDelegationScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.SETTINGS_LEGACY_HANDOVER}
                  element={
                    <ProtectedRoute>
                      <LegacyHandoverScreen />
                    </ProtectedRoute>
                  }
                />

                <Route
                  path={ROUTES.SETTINGS_INFRASTRUCTURE}
                  element={
                    <ProtectedRoute>
                      <InfrastructureControlScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.SETTINGS_VAULT_HEALTH}
                  element={
                    <ProtectedRoute>
                      <VaultHealthScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.SETTINGS_REDUNDANCY}
                  element={
                    <ProtectedRoute>
                      <CloudRedundancyScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.SETTINGS_STORAGE_ARCHITECTURE}
                  element={
                    <ProtectedRoute>
                      <StorageArchitectureScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.SETTINGS_CATALOG_ENGINE}
                  element={
                    <ProtectedRoute>
                      <CatalogEngineScreen />
                    </ProtectedRoute>
                  }
                />

                {/* Privacy Routes */}
                <Route
                  path={ROUTES.SETTINGS_PRIVACY_RULES}
                  element={
                    <ProtectedRoute>
                      <PrivacyRulesScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.SETTINGS_PRIVACY_SECURITY}
                  element={
                    <ProtectedRoute>
                      <PrivacySecurityScreen />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.SETTINGS_RESTRICTED_PROFILE}
                  element={
                    <ProtectedRoute>
                      <RestrictedProfileScreen />
                    </ProtectedRoute>
                  }
                />

                {/* Spatial Features */}
                <Route
                  path={ROUTES.SPATIAL_GALLERY}
                  element={
                    <ProtectedRoute>
                      <SpatialMemoryGallery />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.SPATIAL_HERITAGE_TREE}
                  element={
                    <ProtectedRoute>
                      <SpatialHeritageTree />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path={ROUTES.AI_RESOURCE_MANAGER}
                  element={
                    <ProtectedRoute>
                      <AIResourceManager />
                    </ProtectedRoute>
                  }
                />

                {/* Admin routes */}
                <Route
                  path={ROUTES.ADMIN_ROOT}
                  element={
                    <ProtectedRoute>
                      <AdminScreen />
                    </ProtectedRoute>
                  }
                />

                {/* Fallback */}
                <Route path="*" element={<NotFoundScreen />} />
              </Routes>
            </Suspense>
          </BrowserRouter>
        </InfrastructureProvider>
      </AuthProvider>
    </AppErrorBoundary>
  );
}

export default App;
