/**
 * Welcome Screen Component
 *
 * Migrated from Stitch screen: 973d07394bd54665a5cd17804886c6ca
 */

import { Link, useNavigate } from "react-router-dom";
import "./WelcomeScreen.css";

function WelcomeScreen() {
  const navigate = useNavigate();

  const handleLogin = (e) => {
    e.preventDefault();
    // In a real app, this would handle Firebase auth
    navigate("/dashboard");
  };

  return (
    <div className="welcome-screen-container">
      <div className="w-full max-w-md flex flex-col items-center">
        {/* Logo Section */}
        <div className="mb-8 text-center flex flex-col items-center">
          <div className="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center mb-6 backdrop-blur-md border border-white/30">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              className="h-8 w-8 text-white"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"
              />
            </svg>
          </div>
          <h1 className="brand-font text-6xl text-white mb-2 tracking-tight">
            Kinship
          </h1>
          <p className="text-white/80 text-lg">Connect with your roots.</p>
        </div>

        {/* Login Form Container */}
        <div className="glass-container w-full rounded-[40px] p-8 space-y-6">
          <form onSubmit={handleLogin} className="space-y-6">
            <div className="space-y-4">
              {/* Email Input */}
              <div className="relative">
                <span className="absolute inset-y-0 left-0 pl-4 flex items-center">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className="h-5 w-5 text-gray-400"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth="2"
                      d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.206"
                    />
                  </svg>
                </span>
                <input
                  type="email"
                  placeholder="Email address"
                  className="input-field w-full h-14 pl-12 pr-4 rounded-2xl text-white placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all"
                  required
                />
              </div>

              {/* Password Input */}
              <div className="relative">
                <span className="absolute inset-y-0 left-0 pl-4 flex items-center">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className="h-5 w-5 text-gray-400"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth="2"
                      d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"
                    />
                  </svg>
                </span>
                <input
                  type="password"
                  placeholder="Password"
                  className="input-field w-full h-14 pl-12 pr-12 rounded-2xl text-white placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all"
                  required
                />
                <button
                  type="button"
                  className="absolute inset-y-0 right-0 pr-4 flex items-center"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className="h-5 w-5 text-gray-400"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth="2"
                      d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
                    />
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth="2"
                      d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"
                    />
                  </svg>
                </button>
              </div>
            </div>

            <div className="text-right">
              <Link
                to="/auth"
                className="text-gray-400 text-sm hover:text-white transition-colors"
              >
                Forgot Password?
              </Link>
            </div>

            {/* Log In Button */}
            <button
              type="submit"
              className="w-full h-14 bg-blue-600 hover:bg-blue-500 text-white font-semibold rounded-2xl transition-all transform active:scale-[0.98]"
            >
              Log In
            </button>
          </form>

          {/* Divider */}
          <div className="relative flex items-center py-2">
            <div className="flex-grow border-t border-gray-700"></div>
            <span className="flex-shrink mx-4 text-xs font-medium text-gray-500 uppercase tracking-widest">
              Or continue with
            </span>
            <div className="flex-grow border-t border-gray-700"></div>
          </div>

          {/* Social Logins */}
          <div className="grid grid-cols-2 gap-4">
            <button className="flex items-center justify-center gap-2 h-14 bg-white rounded-2xl text-black font-semibold hover:bg-gray-100 transition-all text-sm">
              <svg className="w-5 h-5" viewBox="0 0 24 24" fill="currentColor">
                <path d="M17.05 20.28c-.98.95-2.05 1.61-3.21 1.61-1.11 0-1.46-.68-2.75-.68-1.28 0-1.69.66-2.73.68-1.12.02-2.31-.76-3.32-1.74-2.07-1.99-3.64-5.63-1.5-9.34 1.07-1.85 2.97-3.02 4.7-3.04 1.32-.02 2.56.89 3.37.89.8 0 2.33-1.09 3.91-.93 1.65.17 2.89.76 3.56 1.74-3.41 2.05-2.86 6.13.52 7.5-.72 1.83-1.65 3.33-2.55 4.31zm-2.06-15.15c1.4-1.68 1.25-3.21 1.25-3.21s-1.46.06-2.86 1.74c-1.4 1.68-1.19 3.09-1.19 3.09s1.37.11 2.8-.1.01-1.52.01-1.52z" />
              </svg>
              Apple
            </button>
            <button className="flex items-center justify-center gap-2 h-14 bg-white rounded-2xl text-black font-semibold hover:bg-gray-100 transition-all text-sm">
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
                <path fill="none" d="M0 0h48v48H0z" />
              </svg>
              Google
            </button>
          </div>
        </div>

        {/* Footer */}
        <p className="mt-8 text-white text-sm">
          Don't have an account?{" "}
          <Link to="/auth" className="font-semibold hover:underline">
            Sign Up
          </Link>
        </p>
      </div>
    </div>
  );
}

export default WelcomeScreen;
