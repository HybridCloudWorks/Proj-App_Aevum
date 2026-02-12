/**
 * Auth Screen
 *
 * Migrated from Stitch screen: d18bca27a6284f32b50c8ee4cd7b4f05
 * Implements Firebase Authentication with Google, Apple, and Email providers.
 */

import { useState } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import {
  signInWithGoogle,
  signInWithApple,
  signInWithEmail,
  signUpWithEmail,
} from "@lib/auth";
import { useAuth } from "@/contexts/AuthContext";
import "./AuthScreen.css";

function AuthScreen() {
  const navigate = useNavigate();
  const location = useLocation();
  const { user } = useAuth();

  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState("");
  const [showEmailForm, setShowEmailForm] = useState(false);
  const [isSignUp, setIsSignUp] = useState(false);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  // Redirect if already authenticated
  if (user) {
    const from = location.state?.from?.pathname || "/dashboard";
    navigate(from, { replace: true });
    return null;
  }

  const handleGoogleSignIn = async () => {
    setIsLoading(true);
    setError("");
    const result = await signInWithGoogle();
    setIsLoading(false);

    if (result.success) {
      navigate("/dashboard");
    } else {
      setError(result.error);
    }
  };

  const handleAppleSignIn = async () => {
    setIsLoading(true);
    setError("");
    const result = await signInWithApple();
    setIsLoading(false);

    if (result.success) {
      navigate("/dashboard");
    } else {
      setError(result.error);
    }
  };

  const handleEmailSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    setError("");

    const result = isSignUp
      ? await signUpWithEmail(email, password)
      : await signInWithEmail(email, password);

    setIsLoading(false);

    if (result.success) {
      navigate("/dashboard");
    } else {
      setError(result.error);
    }
  };

  return (
    <div className="auth-screen-container">
      <div className="mesh-gradient"></div>

      <div className="auth-content">
        {/* Brand Header */}
        <div className="text-center mb-12">
          <h1 className="text-white text-5xl font-extrabold tracking-tighter glow-text uppercase mb-2">
            Aevum
          </h1>
          <p className="text-white/60 text-lg font-medium">
            Your legacy, secured forever.
          </p>
        </div>

        {/* Main Auth Card */}
        <div className="glass-bento p-10 space-y-8">
          {error && (
            <div className="bg-red-500/10 border border-red-500/30 rounded-xl p-3 text-red-400 text-sm text-center">
              {error}
            </div>
          )}

          {!showEmailForm ? (
            <>
              {/* Biometric Section */}
              <button
                onClick={handleGoogleSignIn}
                disabled={isLoading}
                className="w-full flex flex-col items-center justify-center py-8 rounded-3xl btn-glass space-y-4"
              >
                <div className="w-16 h-16 rounded-full bg-indigo-500/20 flex items-center justify-center border border-indigo-500/30">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className="w-8 h-8 text-indigo-400"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  >
                    <path d="M9 11V6a3 3 0 0 1 6 0v5" />
                    <path d="M12 2a10 10 0 0 0-10 10v7a3 3 0 0 0 3 3h14a3 3 0 0 0 3-3v-7a10 10 0 0 0-10-10z" />
                    <circle cx="12" cy="12" r="3" />
                  </svg>
                </div>
                <span className="text-white font-semibold text-lg">
                  {isLoading ? "Authenticating..." : "Sign in with FaceID"}
                </span>
              </button>

              {/* Social Logins Grid */}
              <div className="grid grid-cols-2 gap-4">
                <button
                  onClick={handleAppleSignIn}
                  disabled={isLoading}
                  className="flex items-center justify-center h-14 rounded-2xl btn-glass"
                >
                  <svg
                    className="w-6 h-6 text-white"
                    fill="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path d="M17.05 20.28c-.98.95-2.05 1.61-3.21 1.61-1.11 0-1.46-.68-2.75-.68-1.28 0-1.69.66-2.73.68-1.12.02-2.31-.76-3.32-1.74-2.07-1.99-3.64-5.63-1.5-9.34 1.07-1.85 2.97-3.02 4.7-3.04 1.32-.02 2.56.89 3.37.89.8 0 2.33-1.09 3.91-.93 1.65.17 2.89.76 3.56 1.74-3.41 2.05-2.86 6.13.52 7.5-.72 1.83-1.65 3.33-2.55 4.31zm-2.06-15.15c1.4-1.68 1.25-3.21 1.25-3.21s-1.46.06-2.86 1.74c-1.4 1.68-1.19 3.09-1.19 3.09s1.37.11 2.8-.1.01-1.52.01-1.52z" />
                  </svg>
                  <span className="ml-2 text-white font-medium text-sm">
                    Apple
                  </span>
                </button>
                <button
                  onClick={handleGoogleSignIn}
                  disabled={isLoading}
                  className="flex items-center justify-center h-14 rounded-2xl btn-glass"
                >
                  <svg className="w-5 h-5" viewBox="0 0 48 48">
                    <path
                      fill="#EA4335"
                      d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"
                    />
                    <path
                      fill="#4285F4"
                      d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"
                    />
                    <path
                      fill="#FBBC05"
                      d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"
                    />
                    <path
                      fill="#34A853"
                      d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"
                    />
                  </svg>
                  <span className="ml-2 text-white font-medium text-sm">
                    Google
                  </span>
                </button>
              </div>

              {/* Email Divider */}
              <div className="relative flex items-center py-2">
                <div className="flex-grow border-t border-white/10"></div>
                <span className="flex-shrink mx-4 text-xs font-bold text-white/30 uppercase tracking-widest">
                  Or email
                </span>
                <div className="flex-grow border-t border-white/10"></div>
              </div>

              {/* Email Login Link */}
              <button
                onClick={() => setShowEmailForm(true)}
                className="w-full h-16 rounded-2xl btn-primary-gradient text-white font-bold text-lg hover:brightness-110 transition-all"
              >
                Continue with Email
              </button>
            </>
          ) : (
            /* Email Form */
            <form onSubmit={handleEmailSubmit} className="flex flex-col gap-6">
              <div className="space-y-4">
                <div className="flex flex-col gap-2">
                  <label htmlFor="email" className="text-sm text-white/60">
                    Email
                  </label>
                  <input
                    id="email"
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="Enter your email"
                    required
                    className="w-full h-14 px-4 bg-white/5 border border-white/10 rounded-xl text-white placeholder:text-white/20 focus:outline-none focus:border-indigo-500/50 transition-colors"
                  />
                </div>

                <div className="flex flex-col gap-2">
                  <label htmlFor="password" className="text-sm text-white/60">
                    Password
                  </label>
                  <input
                    id="password"
                    type="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="Enter your password"
                    required
                    minLength={6}
                    className="w-full h-14 px-4 bg-white/5 border border-white/10 rounded-xl text-white placeholder:text-white/20 focus:outline-none focus:border-indigo-500/50 transition-colors"
                  />
                </div>
              </div>

              <button
                type="submit"
                disabled={isLoading}
                className="w-full h-16 rounded-2xl btn-primary-gradient text-white font-bold text-lg hover:brightness-110 transition-all disabled:opacity-50"
              >
                {isLoading
                  ? "Please wait..."
                  : isSignUp
                    ? "Create Account"
                    : "Sign In"}
              </button>

              <div className="flex flex-col items-center gap-4">
                <button
                  type="button"
                  onClick={() => setIsSignUp(!isSignUp)}
                  className="text-sm text-indigo-400 hover:text-indigo-300 font-medium transition-colors"
                >
                  {isSignUp
                    ? "Already have an account? Sign in"
                    : "Need an account? Sign up"}
                </button>

                <button
                  type="button"
                  onClick={() => setShowEmailForm(false)}
                  className="text-sm text-white/40 hover:text-white/60 transition-colors"
                >
                  ← Back to all options
                </button>
              </div>
            </form>
          )}
        </div>

        {/* Security Footer */}
        <div className="mt-10 flex items-center justify-center space-x-2 text-white/40">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            className="h-4 w-4"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
          >
            <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
            <path d="M7 11V7a5 5 0 0 1 10 0v4" />
          </svg>
          <span className="text-xs font-semibold tracking-wider uppercase">
            Powered by Firebase • Zero-Knowledge Encryption
          </span>
        </div>
      </div>
    </div>
  );
}

export default AuthScreen;
