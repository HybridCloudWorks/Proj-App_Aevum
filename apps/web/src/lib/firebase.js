/**
 * Aevum Firebase configuration.
 *
 * App Check is initialized before Firebase data services when a production
 * reCAPTCHA Enterprise site key is configured. Enforcement is enabled later in
 * Firebase Console only after legitimate traffic has been observed in metrics.
 */

import { getAnalytics, isSupported } from "firebase/analytics";
import { getApp, getApps, initializeApp } from "firebase/app";
import {
  initializeAppCheck,
  ReCaptchaEnterpriseProvider,
} from "firebase/app-check";
import { connectAuthEmulator, getAuth } from "firebase/auth";
import { connectFirestoreEmulator, getFirestore } from "firebase/firestore";
import { connectStorageEmulator, getStorage } from "firebase/storage";

const firebaseConfig = {
  apiKey: import.meta.env.VITE_FIREBASE_API_KEY,
  authDomain: import.meta.env.VITE_FIREBASE_AUTH_DOMAIN,
  projectId: import.meta.env.VITE_FIREBASE_PROJECT_ID,
  storageBucket: import.meta.env.VITE_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: import.meta.env.VITE_FIREBASE_MESSAGING_SENDER_ID,
  appId: import.meta.env.VITE_FIREBASE_APP_ID,
  measurementId: import.meta.env.VITE_FIREBASE_MEASUREMENT_ID,
};

const app = getApps().length ? getApp() : initializeApp(firebaseConfig);
const useEmulators =
  import.meta.env.DEV && import.meta.env.VITE_USE_EMULATORS === "true";
const appCheckSiteKey = import.meta.env.VITE_FIREBASE_APPCHECK_ENTERPRISE_SITE_KEY;

export const appCheck =
  typeof window !== "undefined" && !useEmulators && appCheckSiteKey
    ? initializeAppCheck(app, {
        provider: new ReCaptchaEnterpriseProvider(appCheckSiteKey),
        isTokenAutoRefreshEnabled: true,
      })
    : null;

if (import.meta.env.PROD && !appCheckSiteKey) {
  console.warn(
    "Firebase App Check is not initialized because VITE_FIREBASE_APPCHECK_ENTERPRISE_SITE_KEY is missing.",
  );
}

export const auth = getAuth(app);
export const db = getFirestore(app);
export const storage = getStorage(app);

export const analytics =
  typeof window !== "undefined"
    ? isSupported().then((yes) => (yes ? getAnalytics(app) : null))
    : Promise.resolve(null);

if (useEmulators) {
  connectAuthEmulator(auth, "http://localhost:9099", { disableWarnings: true });
  connectFirestoreEmulator(db, "localhost", 8080);
  connectStorageEmulator(storage, "localhost", 9199);
}

export default app;
