/**
 * Authentication context for Firebase user and trusted ID-token claims.
 */

import { createContext, useContext, useEffect, useMemo, useState } from "react";
import { onIdTokenChanged } from "firebase/auth";
import { auth } from "../lib/firebase";

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [claims, setClaims] = useState({});
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let active = true;

    const unsubscribe = onIdTokenChanged(auth, async (authUser) => {
      if (!active) return;
      setUser(authUser);

      if (!authUser) {
        setClaims({});
        setLoading(false);
        return;
      }

      try {
        const token = await authUser.getIdTokenResult();
        if (active) setClaims(token.claims || {});
      } catch (error) {
        console.error("Failed to read authentication claims:", error);
        if (active) setClaims({});
      } finally {
        if (active) setLoading(false);
      }
    });

    return () => {
      active = false;
      unsubscribe();
    };
  }, []);

  const value = useMemo(
    () => ({
      user,
      claims,
      loading,
      isAuthenticated: Boolean(user),
      isAdmin: claims.admin === true,
    }),
    [user, claims, loading],
  );

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === null) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
}

export default AuthContext;
