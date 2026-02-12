/**
 * Auth Screen
 *
 * Converted from Stitch: aevum_secure_auth/code.html
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
    <div className="relative min-h-screen w-full flex flex-col items-center justify-center p-6 mesh-bg overflow-hidden">
      {/* Decorative blurs */}
      <div className="absolute top-[-10%] left-[-10%] w-[50%] h-[50%] bg-primary/20 blur-[100px] rounded-full pointer-events-none" />
      <div className="absolute bottom-[-10%] right-[-10%] w-[50%] h-[50%] bg-purple-600/20 blur-[100px] rounded-full pointer-events-none" />

      {/* Glass Card */}
      <div className="glass-panel w-full max-w-[420px] rounded-2xl p-6 md:p-8 flex flex-col gap-6 relative z-10 shadow-2xl">
        {/* Header */}
        <div className="flex flex-col items-center text-center gap-2 pt-2">
          <div className="w-16 h-16 rounded-xl bg-primary/20 flex items-center justify-center mb-2 border border-primary/30">
            <span className="material-symbols-outlined text-primary text-[32px]">
              family_history
            </span>
          </div>
          <h1 className="text-3xl font-bold tracking-tight text-white">
            Aevum
          </h1>
          <p className="text-slate-400 text-sm font-medium">
            Preserving Generations
          </p>
        </div>

        {/* Error Message */}
        {error && (
          <div className="bg-red-500/10 border border-red-500/30 rounded-xl p-3 text-red-400 text-sm text-center">
            {error}
          </div>
        )}

        {/* Auth Options */}
        <div className="flex flex-col gap-4 mt-2">
          {!showEmailForm ? (
            <>
              {/* FaceID / Biometric Button */}
              <button
                onClick={handleGoogleSignIn}
                disabled={isLoading}
                className="bento-item group relative flex flex-col items-center justify-center w-full h-32 bg-primary/10 hover:bg-primary/20 border border-primary/20 hover:border-primary/40 rounded-xl cursor-pointer overflow-hidden transition-all duration-300 disabled:opacity-50"
              >
                <div className="absolute inset-0 bg-gradient-to-br from-primary/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
                <div className="flex flex-col items-center gap-3 z-10">
                  <span className="material-symbols-outlined text-primary text-[40px]">
                    face
                  </span>
                  <span className="text-white font-semibold text-lg tracking-wide">
                    {isLoading ? "Authenticating..." : "Quick Sign In"}
                  </span>
                </div>
              </button>

              {/* Divider */}
              <div className="relative flex items-center py-2">
                <div className="flex-grow border-t border-white/10" />
                <span className="flex-shrink-0 mx-4 text-xs font-medium text-slate-500 uppercase tracking-widest">
                  Or continue with
                </span>
                <div className="flex-grow border-t border-white/10" />
              </div>

              {/* OAuth Grid */}
              <div className="grid grid-cols-2 gap-3">
                {/* Apple */}
                <button
                  onClick={handleAppleSignIn}
                  disabled={isLoading}
                  className="bento-item flex flex-col items-center justify-center h-24 bg-white/5 hover:bg-white/10 border border-white/10 rounded-xl gap-2 transition-colors disabled:opacity-50"
                >
                  <svg
                    className="w-8 h-8 fill-white"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path d="M17.05 20.28c-.98.95-2.05.88-3.08.4-1.09-.5-2.08-.48-3.24 0-1.44.62-2.2.44-3.06-.4C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.54 5.81.34 7.23-.56 1.43-1.32 2.82-2.39 3.98zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z" />
                  </svg>
                  <span className="text-sm font-medium text-slate-200">
                    Apple
                  </span>
                </button>

                {/* Google */}
                <button
                  onClick={handleGoogleSignIn}
                  disabled={isLoading}
                  className="bento-item flex flex-col items-center justify-center h-24 bg-white/5 hover:bg-white/10 border border-white/10 rounded-xl gap-2 transition-colors disabled:opacity-50"
                >
                  <svg
                    className="w-7 h-7"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <g transform="matrix(1, 0, 0, 1, 27.009001, -39.238998)">
                      <path
                        d="M -3.264 51.509 C -3.264 50.719 -3.334 49.969 -3.454 49.239 L -14.754 49.239 L -14.754 53.749 L -8.284 53.749 C -8.574 55.225 -9.429 56.472 -10.689 57.325 L -10.689 60.255 L -6.824 60.255 C -4.564 58.181 -3.264 55.124 -3.264 51.509 Z"
                        fill="#4285F4"
                      />
                      <path
                        d="M -14.754 63.239 C -11.519 63.239 -8.804 62.156 -6.824 60.263 L -10.689 57.333 C -11.761 58.051 -13.133 58.467 -14.754 58.467 C -17.873 58.467 -20.511 56.366 -21.455 53.529 L -25.426 53.529 L -25.426 56.613 C -23.465 60.493 -19.406 63.239 -14.754 63.239 Z"
                        fill="#34A853"
                      />
                      <path
                        d="M -21.455 53.529 C -21.696 52.81 -21.822 52.044 -21.822 51.249 C -21.822 50.453 -21.696 49.688 -21.455 48.968 L -21.455 45.884 L -25.426 45.884 C -26.236 47.498 -26.696 49.314 -26.696 51.249 C -26.696 53.183 -26.236 55.001 -25.426 56.613 L -21.455 53.529 Z"
                        fill="#FBBC05"
                      />
                      <path
                        d="M -14.754 44.03 C -12.984 44.03 -11.403 44.643 -10.157 45.829 L -6.744 42.414 C -8.804 40.496 -11.516 39.239 -14.754 39.239 C -19.406 39.239 -23.465 41.984 -25.426 45.884 L -21.455 48.968 C -20.511 46.134 -17.873 44.03 -14.754 44.03 Z"
                        fill="#EA4335"
                      />
                    </g>
                  </svg>
                  <span className="text-sm font-medium text-slate-200">
                    Google
                  </span>
                </button>
              </div>

              {/* Email Button */}
              <button
                onClick={() => setShowEmailForm(true)}
                className="bento-item flex items-center justify-center w-full h-14 bg-transparent hover:bg-white/5 border border-white/10 rounded-xl gap-2 mt-1 group"
              >
                <span className="material-symbols-outlined text-slate-400 group-hover:text-white transition-colors text-[20px]">
                  mail
                </span>
                <span className="text-sm font-medium text-slate-400 group-hover:text-white transition-colors">
                  Continue with Email
                </span>
              </button>
            </>
          ) : (
            /* Email Form */
            <form onSubmit={handleEmailSubmit} className="flex flex-col gap-4">
              <div className="flex flex-col gap-2">
                <label htmlFor="email" className="text-sm text-slate-400">
                  Email
                </label>
                <input
                  id="email"
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="Enter your email"
                  required
                  className="w-full px-4 py-3 bg-white/5 border border-white/10 rounded-xl text-white placeholder:text-slate-500 focus:outline-none focus:border-primary/50 focus:ring-1 focus:ring-primary/50 transition-colors"
                />
              </div>

              <div className="flex flex-col gap-2">
                <label htmlFor="password" className="text-sm text-slate-400">
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
                  className="w-full px-4 py-3 bg-white/5 border border-white/10 rounded-xl text-white placeholder:text-slate-500 focus:outline-none focus:border-primary/50 focus:ring-1 focus:ring-primary/50 transition-colors"
                />
              </div>

              <button
                type="submit"
                disabled={isLoading}
                className="btn-primary w-full py-3.5 disabled:opacity-50"
              >
                {isLoading
                  ? "Please wait..."
                  : isSignUp
                    ? "Create Account"
                    : "Sign In"}
              </button>

              <button
                type="button"
                onClick={() => setIsSignUp(!isSignUp)}
                className="text-sm text-primary hover:text-primary-400 transition-colors"
              >
                {isSignUp
                  ? "Already have an account? Sign in"
                  : "Need an account? Sign up"}
              </button>

              <button
                type="button"
                onClick={() => setShowEmailForm(false)}
                className="text-sm text-slate-400 hover:text-white transition-colors"
              >
                ← Back to all options
              </button>
            </form>
          )}
        </div>

        {/* Footer */}
        <div className="mt-4 flex flex-col items-center gap-4">
          <a
            className="text-xs text-primary/80 hover:text-primary font-medium transition-colors"
            href="#"
          >
            Trouble signing in?
          </a>
          <div className="flex items-center gap-1.5 opacity-60">
            <span className="material-symbols-outlined text-slate-500 text-[16px]">
              lock
            </span>
            <span className="text-[10px] uppercase tracking-wider font-semibold text-slate-500">
              Secured by Firebase
            </span>
          </div>
        </div>
      </div>
    </div>
  );
}

export default AuthScreen;
