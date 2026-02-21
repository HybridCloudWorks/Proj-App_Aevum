/**
 * Auth Context Provider
 *
 * React context for authentication state management.
 * Provides user state and auth methods to all components.
 */

import { createContext, useContext, useEffect, useState } from "react";
import { onAuthChange } from "../lib/auth";

const AuthContext = createContext(null);

/**
 * Auth Provider Component
 * Wraps the app and provides auth state to all children.
 */
export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Subscribe to auth state changes
    const unsubscribe = onAuthChange((authUser) => {
      setUser(authUser);
      setLoading(false);
    });

    // Cleanup subscription
    return () => unsubscribe();
  }, []);

  const value = {
    user,
    loading,
    isAuthenticated: !!user,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

/**
 * Hook to access auth context
 * @returns {Object} Auth context value
 */
export function useAuth() {
  const context = useContext(AuthContext);
  if (context === null) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
}

export default AuthContext;
