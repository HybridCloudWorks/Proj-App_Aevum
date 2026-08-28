# Aevum Mobile Authentication Setup

Status: required before Private Beta mobile authentication validation

The Flutter client uses Firebase Authentication as the authority for sessions and Firebase custom claims as the authority for platform-admin access. UI route labels or Firestore profile fields must never grant admin access.

## Google

1. Enable Google in Firebase Authentication -> Sign-in method.
2. Android: register the release/debug SHA-1 and SHA-256 certificates for every app signing identity used by Aevum, then refresh the Firebase Android configuration when required.
3. iOS: ensure the Firebase iOS application configuration and Google URL scheme are installed according to the current `google_sign_in` platform instructions.
4. The app uses the official `google_sign_in` Flutter plugin to obtain the Google ID token and exchanges it with `FirebaseAuth.signInWithCredential`.
5. `GoogleSignIn.initialize()` must complete before authentication is requested.

## Apple

1. Enable Apple in Firebase Authentication -> Sign-in method and complete the Apple provider configuration.
2. Add the Sign in with Apple capability to the iOS Runner target and provisioning profile.
3. Configure the Android/web return URL and Apple service identifiers if Apple sign-in will be offered on Android.
4. The app uses `AppleAuthProvider` with `FirebaseAuth.signInWithProvider` on native platforms.

## Email/password

1. Enable Email/Password in Firebase Authentication.
2. Keep password-reset behavior enabled and verify authorized action-code domains.
3. Authentication errors shown to users must not reveal privileged server information.

## Admin custom claim

Admin is a trusted Firebase Authentication custom claim:

```text
admin: true
```

Only a trusted administrative backend/process may assign or remove this claim. The mobile router and web `ProtectedRoute` read the ID-token claim; client-editable Firestore fields are not authoritative.

After changing a user's custom claims, force/await an ID-token refresh before testing admin access.

## Required validation

Before closing AEV-011/AEV-012 for release:

- run `flutter pub get` and commit the regenerated `pubspec.lock`;
- run Flutter analyzer and tests;
- verify Google sign-in on Android and iOS physical/test devices;
- verify Apple sign-in on iOS and any Android surface where it is enabled;
- verify email sign-in, account creation, password reset, sign-out, and session restoration;
- verify signed-out users cannot deep-link to protected routes;
- verify authenticated non-admin users cannot access `/dev-menu` or `/admin-*` routes;
- verify an account with `admin: true` can access admin routes;
- verify removing the claim removes admin access after token refresh.

Current Firebase provider guidance: https://firebase.google.com/docs/auth/flutter/federated-auth
