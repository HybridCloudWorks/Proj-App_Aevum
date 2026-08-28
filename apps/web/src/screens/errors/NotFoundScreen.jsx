import { Link, useLocation } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import { ROUTES } from "@/lib/routes";

export default function NotFoundScreen() {
  const { isAuthenticated, loading } = useAuth();
  const location = useLocation();
  const destination = isAuthenticated ? ROUTES.DASHBOARD : ROUTES.HOME;
  const destinationLabel = isAuthenticated ? "Return to dashboard" : "Return home";

  return (
    <main className="min-h-screen bg-background-dark flex items-center justify-center px-6 py-12">
      <section className="w-full max-w-xl rounded-3xl border border-white/10 bg-white/5 p-8 text-center shadow-2xl">
        <p className="text-sm font-semibold uppercase tracking-[0.25em] text-primary">404</p>
        <h1 className="mt-4 text-3xl font-bold text-white">Page not found</h1>
        <p className="mt-4 text-sm leading-6 text-gray-400">
          The page you requested is not available. It may have moved, been removed, or may not be part of the current Aevum release.
        </p>
        <p className="mt-3 break-all text-xs text-gray-500" aria-label="Requested path">
          {location.pathname}
        </p>
        <div className="mt-8">
          {loading ? (
            <span className="text-sm text-gray-400">Checking your session...</span>
          ) : (
            <Link
              to={destination}
              className="inline-flex items-center justify-center rounded-full bg-primary px-6 py-3 text-sm font-semibold text-white transition hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2 focus:ring-offset-background-dark"
            >
              {destinationLabel}
            </Link>
          )}
        </div>
      </section>
    </main>
  );
}
