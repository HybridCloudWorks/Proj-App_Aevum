/**
 * Welcome Screen Component
 *
 * Based on Stitch screens:
 * - 973d07394bd54665a5cd17804886c6ca (Welcome to Kinship)
 * - 34a9ad1146ab484c95e958ab26476a42 (Welcome to Kinship)
 * - 2cec04d7d4554972b9857b9fe0955a14 (Welcome to Kinship)
 * - d31879317ea4433cb5467fee2f6e5b97 (Welcome to Kinship)
 *
 * TODO: Import actual Stitch-generated HTML/CSS
 */

import { Link } from "react-router-dom";
import "./WelcomeScreen.css";

function WelcomeScreen() {
  return (
    <div className="welcome-screen">
      <div className="welcome-content">
        {/* Hero Section */}
        <header className="welcome-hero">
          <div className="welcome-logo">
            <span className="logo-icon">🌳</span>
          </div>
          <h1 className="welcome-title">Kinship</h1>
          <p className="welcome-tagline">Connect with your roots.</p>
        </header>

        {/* Auth Section */}
        <main className="welcome-auth">
          <div className="auth-form">
            <div className="input-group">
              <label htmlFor="email">Email</label>
              <input
                id="email"
                type="email"
                placeholder="Enter your email"
                autoComplete="email"
              />
            </div>

            <div className="input-group">
              <label htmlFor="password">Password</label>
              <input
                id="password"
                type="password"
                placeholder="Enter your password"
                autoComplete="current-password"
              />
            </div>

            <Link to="/auth" className="forgot-password">
              Forgot Password?
            </Link>

            <button className="btn-primary">Sign In</button>
          </div>

          <p className="signup-prompt">
            Don't have an account?{" "}
            <Link to="/auth" className="signup-link">
              Sign Up
            </Link>
          </p>
        </main>
      </div>
    </div>
  );
}

export default WelcomeScreen;
