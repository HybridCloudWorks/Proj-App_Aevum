# Dependency management

Aevum uses one reviewed dependency graph per ecosystem.

## JavaScript

Run `npm ci` from the repository root. The root `package-lock.json` is the only npm lockfile and covers the `apps/web` workspace. Do not run app-local installs that create nested lockfiles.

## Flutter

Run `flutter pub get` in `apps/mobile` with the supported stable Flutter SDK. Commit `pubspec.lock`; CI fails if dependency resolution changes it.

## Cloud Functions

Every direct Python requirement uses an exact `==` pin. CI rejects unpinned direct requirements before installing and testing the preservation processor.

## Terraform

Each root module commits its own `.terraform.lock.hcl`. CI requires both files, initializes with `-lockfile=readonly`, validates both roots, and fails if initialization changes either lock.

## Automated updates

Dependabot checks npm, pub, both Python functions, both Terraform roots, and GitHub Actions weekly. Minor and patch updates are grouped where supported; changes remain pull requests subject to the normal validation and review gates. Major updates remain isolated for explicit compatibility review.
