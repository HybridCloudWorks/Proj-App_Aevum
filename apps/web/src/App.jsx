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
const IdentityScreen = lazy(() => import("@screens/identity/IdentityScreen"));
const SettingsScreen = lazy(() => import("@screens/settings/SettingsScreen"));
const AdminScreen = lazy(() => import("@screens/admin/AdminScreen"));

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
                  <DashboardScreen />
                </ProtectedRoute>
              }
            />
            <Route
              path="/family-tree"
              element={
                <ProtectedRoute>
                  <FamilyTreeScreen />
                </ProtectedRoute>
              }
            />
            <Route
              path="/memories"
              element={
                <ProtectedRoute>
                  <MemoriesScreen />
                </ProtectedRoute>
              }
            />
            <Route
              path="/upload"
              element={
                <ProtectedRoute>
                  <UploadScreen />
                </ProtectedRoute>
              }
            />
            <Route
              path="/heritage-map"
              element={
                <ProtectedRoute>
                  <HeritageMapScreen />
                </ProtectedRoute>
              }
            />
            <Route
              path="/ai"
              element={
                <ProtectedRoute>
                  <AIFeaturesScreen />
                </ProtectedRoute>
              }
            />
            <Route
              path="/profile"
              element={
                <ProtectedRoute>
                  <IdentityScreen />
                </ProtectedRoute>
              }
            />
            <Route
              path="/settings"
              element={
                <ProtectedRoute>
                  <SettingsScreen />
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
