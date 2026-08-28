/**
 * Firebase Authentication screen for the Private Beta release.
 */

import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import {
  resetPassword,
  signInWithApple,
  signInWithEmail,
  signInWithGoogle,
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
  const [notice, setNotice] = useState("");
  const [showEmailForm, setShowEmailForm] = useState(false);
  const [isSignUp, setIsSignUp] = useState(false);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  useEffect(() => {
    if (!user) return;
    const from = location.state?.from?.pathname || "/dashboard";
    navigate(from, { replace: true });
  }, [user, location.state, navigate]);

  const runAuth = async (operation) => {
    setIsLoading(true);
    setError("");
    setNotice("");
    try {
      const result = await operation();
      if (!result.success) setError(result.error);
      return result;
    } finally {
      setIsLoading(false);
    }
  };

  const handleProviderSignIn = async (provider) => {
    const result = await runAuth(provider);
    if (result.success) navigate("/dashboard", { replace: true });
  };

  const handleEmailSubmit = async (event) => {
    event.preventDefault();
    const result = await runAuth(() =>
      isSignUp
        ? signUpWithEmail(email, password)
        : signInWithEmail(email, password),
    );
    if (result.success) navigate("/dashboard", { replace: true });
  };

  const handlePasswordReset = async () => {
    if (!email.trim()) {
      setError("Enter your email address first.");
      return;
    }

    const result = await runAuth(() => resetPassword(email.trim()));
    if (result.success) {
      setNotice(
        "If an account exists for that address, password reset instructions have been sent.",
      );
    }
  };

  if (user) return null;

  return (
    <div className="auth-screen-container">
      <div className="mesh-gradient" />

      <div className="auth-content">
        <div className="text-center mb-12">
          <h1 className="text-white text-5xl font-extrabold tracking-tighter glow-text uppercase mb-2">
            Aevum
          </h1>
          <p className="text-white/60 text-lg font-medium">
            Your private family archive.
          </p>
        </div>

        <div className="glass-bento p-10 space-y-8">
          {error && (
            <div className="bg-red-500/10 border border-red-500/30 rounded-xl p-3 text-red-400 text-sm text-center">
              {error}
            </div>
          )}
          {notice && (
            <div className="bg-emerald-500/10 border border-emerald-500/30 rounded-xl p-3 text-emerald-300 text-sm text-center">
              {notice}
            </div>
          )}

          {!showEmailForm ? (
            <>
              <button
                onClick={() => handleProviderSignIn(signInWithGoogle)}
                disabled={isLoading}
                className="w-full h-16 rounded-2xl btn-glass text-white font-semibold text-lg flex items-center justify-center gap-3"
              >
                <span className="text-xl font-bold">G</span>
                <span>{isLoading ? "Authenticating..." : "Continue with Google"}</span>
              </button>

              <button
                onClick={() => handleProviderSignIn(signInWithApple)}
                disabled={isLoading}
                className="w-full h-16 rounded-2xl btn-glass text-white font-semibold text-lg flex items-center justify-center gap-3"
              >
                <span className="text-2xl"></span>
                <span>Continue with Apple</span>
              </button>

              <div className="relative flex items-center py-2">
                <div className="flex-grow border-t border-white/10" />
                <span className="flex-shrink mx-4 text-xs font-bold text-white/30 uppercase tracking-widest">
                  Or
                </span>
                <div className="flex-grow border-t border-white/10" />
              </div>

              <button
                onClick={() => setShowEmailForm(true)}
                className="w-full h-16 rounded-2xl btn-primary-gradient text-white font-bold text-lg hover:brightness-110 transition-all"
              >
                Continue with Email
              </button>
            </>
          ) : (
            <form onSubmit={handleEmailSubmit} className="flex flex-col gap-6">
              <div className="space-y-4">
                <div className="flex flex-col gap-2">
                  <label htmlFor="email" className="text-sm text-white/60">
                    Email
                  </label>
                  <input
                    id="email"
                    type="email"
                    autoComplete="email"
                    value={email}
                    onChange={(event) => setEmail(event.target.value)}
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
                    autoComplete={isSignUp ? "new-password" : "current-password"}
                    value={password}
                    onChange={(event) => setPassword(event.target.value)}
                    placeholder="Enter your password"
                    required
                    minLength={8}
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

              {!isSignUp && (
                <button
                  type="button"
                  onClick={handlePasswordReset}
                  disabled={isLoading}
                  className="text-sm text-indigo-400 hover:text-indigo-300 font-medium transition-colors"
                >
                  Forgot password?
                </button>
              )}

              <button
                type="button"
                onClick={() => setIsSignUp((value) => !value)}
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
            </form>
          )}
        </div>

        <div className="mt-10 flex items-center justify-center text-white/40">
          <span className="text-xs font-semibold tracking-wider uppercase text-center">
            Firebase Authentication • App Check enabled when configured
          </span>
        </div>
      </div>
    </div>
  );
}

export default AuthScreen;
