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
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider } from "@/contexts/AuthContext";
import { ProtectedRoute } from "@/components/ProtectedRoute";
import MainLayout from "@/layouts/MainLayout";

// Lazy-loaded screen components (Code splitting per FED best practices)
const ScreenGallery = lazy(() => import("@screens/ScreenGallery"));
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
const IdentityMatcherScreen = lazy(
  () => import("@screens/ai-features/IdentityMatcherScreen"),
);
const IdentityScreen = lazy(() => import("@screens/identity/IdentityScreen"));
const MessengerHubScreen = lazy(
  () => import("@screens/messaging/MessengerHubScreen"),
);
const RestorationScreen = lazy(
  () => import("@screens/memories/RestorationScreen"),
);
const SettingsScreen = lazy(() => import("@screens/settings/SettingsScreen"));
const AdminScreen = lazy(() => import("@screens/admin/AdminScreen"));
const FileConflictScreen = lazy(
  () => import("@screens/memories/FileConflictScreen"),
);

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
    <AuthProvider>
      <BrowserRouter>
        <Suspense fallback={<LoadingFallback />}>
          <Routes>
            {/* Screen Gallery - Browse all Stitch screens */}
            <Route path="/gallery" element={<ScreenGallery />} />

            {/* Public routes */}
            <Route path="/" element={<WelcomeScreen />} />
            <Route path="/welcome" element={<WelcomeScreen />} />
            <Route path="/auth" element={<AuthScreen />} />

            {/* Protected routes - Require authentication */}
            <Route
              path="/dashboard"
              element={
                <ProtectedRoute>
                  <MainLayout>
                    <DashboardScreen />
                  </MainLayout>
                </ProtectedRoute>
              }
            />
            <Route
              path="/family-tree"
              element={
                <ProtectedRoute>
                  <MainLayout>
                    <FamilyTreeScreen />
                  </MainLayout>
                </ProtectedRoute>
              }
            />
            <Route
              path="/memories"
              element={
                <ProtectedRoute>
                  <MainLayout>
                    <MemoriesScreen />
                  </MainLayout>
                </ProtectedRoute>
              }
            />
            <Route
              path="/upload"
              element={
                <ProtectedRoute>
                  <MainLayout>
                    <UploadScreen />
                  </MainLayout>
                </ProtectedRoute>
              }
            />
            <Route
              path="/upload/conflict"
              element={
                <ProtectedRoute>
                  <MainLayout>
                    <FileConflictScreen />
                  </MainLayout>
                </ProtectedRoute>
              }
            />
            <Route
              path="/heritage-map"
              element={
                <ProtectedRoute>
                  <MainLayout>
                    <HeritageMapScreen />
                  </MainLayout>
                </ProtectedRoute>
              }
            />
            <Route
              path="/ai"
              element={
                <ProtectedRoute>
                  <MainLayout>
                    <AIFeaturesScreen />
                  </MainLayout>
                </ProtectedRoute>
              }
            />
            <Route
              path="/ai/identity-matcher"
              element={
                <ProtectedRoute>
                  <IdentityMatcherScreen />
                </ProtectedRoute>
              }
            />
            <Route
              path="/ai/restoration"
              element={
                <ProtectedRoute>
                  <RestorationScreen />
                </ProtectedRoute>
              }
            />
            <Route
              path="/messages"
              element={
                <ProtectedRoute>
                  <MainLayout>
                    <MessengerHubScreen />
                  </MainLayout>
                </ProtectedRoute>
              }
            />
            <Route
              path="/profile"
              element={
                <ProtectedRoute>
                  <MainLayout>
                    <IdentityScreen />
                  </MainLayout>
                </ProtectedRoute>
              }
            />
            <Route
              path="/settings"
              element={
                <ProtectedRoute>
                  <MainLayout>
                    <SettingsScreen />
                  </MainLayout>
                </ProtectedRoute>
              }
            />

            {/* Admin routes */}
            <Route
              path="/admin/*"
              element={
                <ProtectedRoute>
                  <AdminScreen />
                </ProtectedRoute>
              }
            />

            {/* Fallback */}
            <Route path="*" element={<Navigate to="/" replace />} />
          </Routes>
        </Suspense>
      </BrowserRouter>
    </AuthProvider>
  );
}

export default App;
