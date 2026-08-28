/**
 * Route guard for authenticated, admin-only, and private-beta feature routes.
 */

import { Link, Navigate, useLocation } from "react-router-dom";
import { useAuth } from "../contexts/AuthContext";
import { isRouteReleased } from "../lib/releaseFeatures";

export function ProtectedRoute({ children }) {
  const { user, loading, isAdmin } = useAuth();
  const location = useLocation();
  const requiresAdmin =
    location.pathname === "/admin" || location.pathname.startsWith("/admin/");

  if (loading) {
    return (
      <div className="min-h-screen bg-background-dark flex items-center justify-center">
        <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-b-2 border-primary" />
      </div>
    );
  }

  if (!user) {
    return <Navigate to="/auth" state={{ from: location }} replace />;
  }

  if (requiresAdmin && !isAdmin) {
    return <Navigate to="/dashboard" replace />;
  }

  if (!isRouteReleased(location.pathname)) {
    return (
      <main className="min-h-screen bg-background-dark flex items-center justify-center p-6 text-white">
        <section className="max-w-md text-center space-y-4">
          <div className="mx-auto size-12 rounded-full bg-white/10 flex items-center justify-center">
            <span className="material-symbols-outlined">science</span>
          </div>
          <h1 className="text-2xl font-bold">Not in Private Beta</h1>
          <p className="text-white/60">
            This feature is still classified as a prototype and is disabled in
            the Private Beta build until its data, security, and reliability
            behavior is release-validated.
          </p>
          <Link
            to="/dashboard"
            className="inline-flex rounded-xl bg-primary px-5 py-3 font-semibold text-white"
          >
            Return to Dashboard
          </Link>
        </section>
      </main>
    );
  }

  return children;
}

export default ProtectedRoute;
