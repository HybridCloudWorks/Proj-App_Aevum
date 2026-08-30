# Private Beta feature registry

Statuses are release claims, not roadmap priority.

| Status | Meaning |
| --- | --- |
| Production | Security or platform behavior validated for production use. |
| Beta | Available to Private Beta users and covered by blocking validation. |
| Prototype | Experimental UI or behavior; unavailable by default and enabled only with an explicit development feature flag. |
| Planned | Not operational. Routes remain unavailable even when prototype flags are enabled. |

## Current classifications

| Capability | Status | Private Beta behavior |
| --- | --- | --- |
| Security rules and trusted admin authorization | Production | Enforced for released clients. |
| Authentication, family archive, collaboration, canonical media upload, AI metadata analysis | Beta | Available and covered by blocking CI/emulator validation. |
| AI restoration, identity matching, semantic discovery, spatial experiences | Prototype | Hidden by default on web and mobile. |
| Mobile family-tree, map, messenger, search, media-detail, and related mock screens | Prototype | Redirected to the dashboard; mock records are not shown as live data. |
| Infrastructure, vault, redundancy, storage architecture, and catalog demos | Prototype | Hidden by default. |
| Mobile developer menu and admin operational screens | Planned | Unavailable in Private Beta, including for administrators. |
| Admin deployment, crash, tester, and release telemetry | Planned | Admin web UI explicitly reports each integration as not connected and shows no synthetic values. |
| Google and Apple mobile sign-in | Planned | Disabled unless provider-specific build flags and real provider configuration are supplied. |

## Feature flags

- Web prototypes require `VITE_ENABLE_PROTOTYPE_FEATURES=true`.
- Flutter prototypes require `--dart-define=AEVUM_ENABLE_PROTOTYPE_FEATURES=true`.
- Planned routes are never unlocked by prototype flags.
- Unclassified Flutter routes fail closed as prototypes.

## Intentionally disabled for Private Beta

AI restoration and discovery experiments, spatial galleries and trees, the mock Flutter family tree and companion mock-data screens, infrastructure demonstration screens, operational admin controls/telemetry, and unconfigured Google/Apple sign-in are intentionally disabled. Enabling one requires reclassification plus data, authorization, reliability, and release validation.
