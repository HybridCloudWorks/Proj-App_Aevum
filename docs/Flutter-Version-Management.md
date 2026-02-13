# FVM setup for this repo

This project targets Flutter `3.41.0` (Dart 3.10.3). Use FVM to install and use the correct SDK locally.

Windows steps:

1. Install FVM (requires Dart or Flutter SDK already available):

```powershell
dart pub global activate fvm
```

2. Install and select Flutter 3.41.0 for the project:

```powershell
fvm install 3.41.0
fvm use 3.41.0 --force
```

3. Run `pub get` for the mobile app:

```powershell
cd apps/mobile
fvm flutter pub get --no-example
```

Notes:
- If you prefer global Flutter, ensure it's at `3.41.0`.
- If you cannot install FVM, you can relax the SDK constraint in `apps/mobile/pubspec.yaml` (not recommended).
