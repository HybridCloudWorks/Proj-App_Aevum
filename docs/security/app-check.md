# Firebase App Check Rollout

Status: Private Beta hardening
Applies to: Aevum web, Android, iOS, Firestore, Storage, and supported Firebase backends

## Goal

App Check adds application/device attestation on top of Firebase Authentication and Security Rules. It does not replace either boundary.

Aevum initializes App Check before normal Firebase service use:

- Web: reCAPTCHA Enterprise provider.
- Android debug: App Check debug provider.
- Android release: Play Integrity.
- Apple debug: App Check debug provider.
- Apple release: App Attest with DeviceCheck fallback.

## Web configuration

1. Create/register the Aevum web app in Firebase App Check.
2. Configure a reCAPTCHA Enterprise site key for the real Aevum web domains.
3. Store the public site key in GitHub as `FIREBASE_APPCHECK_ENTERPRISE_SITE_KEY`.
4. CI exposes it to Vite as `VITE_FIREBASE_APPCHECK_ENTERPRISE_SITE_KEY`.
5. Do not put a production reCAPTCHA Enterprise key on unrestricted localhost/test domains.
6. Emulator development intentionally skips App Check initialization.

A missing production key currently produces a client warning rather than making the app unusable before rollout is complete.

## Android configuration

1. Register the Android Firebase app with App Check.
2. Configure Play Integrity for production signing identities.
3. Verify package name and signing certificates match the Firebase application registration.
4. For local/debug builds, obtain the App Check debug token and register it in Firebase Console.
5. Treat debug tokens as secrets. Never commit them.

## Apple configuration

1. Register each iOS/macOS Firebase app with App Check.
2. Configure App Attest for production.
3. Aevum uses DeviceCheck fallback for devices that cannot use App Attest.
4. For local/debug builds, register the App Check debug token in Firebase Console.
5. Treat debug tokens as secrets. Never commit them.

## Safe enforcement sequence

Do not enable enforcement immediately after shipping client initialization.

1. Deploy App Check-capable clients first.
2. Observe Firebase App Check metrics for legitimate web/mobile traffic.
3. Confirm current supported app versions obtain valid tokens.
4. Confirm background functions/admin SDK workloads are unaffected; trusted server SDKs use their server-side trust/IAM path.
5. Investigate unknown/invalid traffic before enforcement.
6. Enable enforcement one Firebase product at a time, starting with the highest-value data surfaces such as Firestore and Storage.
7. Monitor errors and invalid-token metrics after each enforcement change.
8. Keep a documented rollback procedure in case a legitimate production client version cannot attest.

Only enable enforcement for products shown as supported in the current Firebase App Check console/documentation.

## Release validation

Before Private Beta exit:

- production web obtains valid reCAPTCHA Enterprise App Check tokens;
- Android release build obtains Play Integrity tokens;
- iOS release build obtains App Attest/DeviceCheck tokens;
- debug environments use registered debug tokens where required;
- Firestore and Storage still enforce family Security Rules independently;
- invalid/unattested test clients are rejected after enforcement is enabled;
- App Check failures are observable in Firebase metrics/logging;
- no App Check secret/debug token is committed to Git.

## References

- https://firebase.google.com/docs/app-check/web/recaptcha-enterprise-provider
- https://firebase.google.com/docs/app-check/flutter/default-providers
