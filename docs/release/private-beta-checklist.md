# Aevum Private Beta Release Checklist

This checklist separates implementation status from validation status. A merged implementation is not considered release-validated until its required runtime checks have executed successfully. The canonical capability classification and disabled-feature release notes are maintained in [the Private Beta feature registry](./feature-registry.md).

## Implemented in repository

- [x] Canonical family, collaborator, genealogy, media, album, and AI task data contract
- [x] Firestore and Storage authorization rules aligned to the canonical contract
- [x] Canonical media reservation, upload, preservation, derivative, and archive flow
- [x] Web and Flutter authentication wired to Firebase Auth providers
- [x] Admin access guarded by trusted Firebase Auth custom claim
- [x] Web and Flutter App Check initialization added
- [x] Terraform validation job defined
- [x] Flutter dependency, analyzer, and test jobs defined
- [x] Executable Firebase Firestore and Storage Rules test suite added
- [x] Production/Beta/Prototype/Planned feature registry maintained
- [x] Prototype web routes hidden by default in Private Beta builds
- [x] Prototype Flutter routes hidden by default in Private Beta builds
- [x] Unclassified Flutter routes fail closed
- [x] Mock Flutter family tree and companion mock-data routes excluded
- [x] Planned mobile admin/developer routes unavailable, including to admins
- [x] Misleading FaceID and zero-knowledge encryption claims removed
- [x] Fabricated admin telemetry and release controls removed
- [x] Preservation and AI service identities separated with reduced permissions
- [x] AI runtime migrated to the supported Google Gen AI SDK

## Validation required before external beta release

- [ ] GitHub Actions registers and executes repository workflows
- [ ] Web lint, unit tests, rules tests, Terraform validation, Flutter analysis/tests, and web build all pass in CI
- [ ] Flutter `pubspec.lock` regenerated with the real Flutter toolchain and lockfile drift gate passes
- [ ] Google and Apple mobile authentication validated on real provider configuration and devices
- [ ] Firebase App Check valid-client metrics observed before enforcement is enabled
- [ ] Firebase Security Rules emulator suite passes
- [ ] End-to-end family isolation and collaborator RBAC validated
- [ ] End-to-end media upload -> preservation -> metadata -> derivative -> reload flow validated
- [ ] Golden beta journey passes: account -> family -> genealogy person -> upload -> reload -> collaborator -> authorization isolation
- [ ] Failure paths validated: interrupted upload, duplicate, revoked collaborator, deleted media, expired session, malformed file, unsupported file, AI timeout
- [ ] `main` protected with required checks and review/merge policy
- [ ] Deployment health and rollback procedure validated
- [ ] Error/404 surface implemented for unknown web routes
- [ ] Observability and release telemetry connected to real sources

## Release policy

Do not interpret this document, a merged PR, or a green local build as evidence that the Private Beta exit criteria have passed. Runtime validation must be captured from the actual CI, Firebase/GCP environment, provider configuration, and supported client devices.
