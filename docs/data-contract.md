# Aevum Data Contract

Status: **Canonical v1**  
Contract version: **1.0.0**  
Effective: 2026-08-29  
Tracks: [AEV-004](https://github.com/HybridCloudWorks/Proj-App_Aevum/issues/138)

This document is the authoritative persistence contract shared by web, mobile,
Firebase Security Rules, indexes, and backend processors. New fields or paths
must be added here before production code depends on them. Breaking changes
require a new major contract version and an explicit migration.

## Conventions

- Firestore identifiers are document IDs and are immutable.
- All timestamps are Firestore timestamps in UTC. Clients may propose
  `updatedAt`; trusted services own processing timestamps.
- `createdAt`, `createdBy`, `familyId`, `ownerId`, `userId`,
  `uploadedBy`, and storage object identity are immutable after creation unless
  a migration explicitly says otherwise.
- Authentication and genealogical identity are separate. A
  `family_members` document never grants access.
- Application authorization comes from Firebase Auth, the server-controlled
  `admin` custom claim, and family collaborator membership.
- Undeclared Firestore collections and Storage paths are denied.

## Roles and access

| Principal | Source | Scope |
| --- | --- | --- |
| Admin | Firebase Auth custom claim `admin == true` | Operational access defined by Rules; never a user-editable profile field |
| Owner | `families/{familyId}.ownerId` | Full family management; must remain an active collaborator |
| Editor | Active `families/{familyId}/collaborators/{uid}` with role `editor` | Family content create/update/delete |
| Viewer | Active collaborator with role `viewer` | Family content read |
| Genealogical person | `family_members/{personId}` | Heritage data only; grants no authentication or authorization |

## Firestore entities

### `users/{uid}`

One authenticated-user profile.

| Field | Type | Required | Mutation |
| --- | --- | --- | --- |
| `uid` | string | yes | Immutable; equals document ID and Auth UID |
| `displayName` | string | no | Owner editable |
| `email` | string | no | Owner editable display copy; Auth remains authoritative |
| `photoUrl` | string | no | Owner editable |
| `createdAt` | timestamp | yes | Immutable |
| `updatedAt` | timestamp | yes | Owner editable |

Client documents must not contain `admin`, `role`, `roles`, or `claims`.

### `families/{familyId}`

Authorization root and family metadata.

| Field | Type | Required | Mutation |
| --- | --- | --- | --- |
| `ownerId` | UID | yes | Immutable |
| `createdBy` | UID | yes | Immutable; equals creator |
| `collaboratorIds` | UID[] | yes | Owner-managed membership cache; includes owner |
| `name` | string | yes | Owner/editor editable |
| `createdAt` | timestamp | yes | Immutable |
| `updatedAt` | timestamp | yes | Owner/editor editable |

### `families/{familyId}/collaborators/{uid}`

Authenticated application membership. Document ID and `userId` are the same
Auth UID.

| Field | Type | Required | Mutation |
| --- | --- | --- | --- |
| `userId` | UID | yes | Immutable |
| `role` | `editor` or `viewer` | yes | Owner/admin managed |
| `status` | `active`, `invited`, or `revoked` | yes | Owner/admin managed |
| `invitedBy` | UID | yes | Immutable |
| `createdAt` | timestamp | yes | Immutable |
| `updatedAt` | timestamp | yes | Owner/admin managed |

Only active entries appear in the parent `collaboratorIds` cache. Membership
updates must keep both records consistent atomically.

### `family_members/{personId}`

A genealogical person belonging to one family. This entity never authorizes a
user.

Required identity fields are `familyId`, `createdBy`, `createdAt`, and
`updatedAt`. Supported content includes `name`, life dates, relationships,
biography, and canonical member-photo references. `familyId`, `createdBy`,
and `createdAt` are immutable.

### `media_items/{mediaId}`

Canonical record for one client upload and all derivatives.

| Field | Type | Required | Mutation |
| --- | --- | --- | --- |
| `familyId` | document ID | yes | Immutable |
| `createdBy` / `uploadedBy` | UID | yes | Immutable and equal to reserving uploader |
| `status` | state | yes | State-machine controlled |
| `aiStatus` | state | yes | State-machine controlled |
| `storage.originalPath` | string | after upload | Set once during finalization |
| `storage.displayPath` | string | after processing | Trusted processor only |
| `storage.thumbnailPath` | string | after processing | Trusted processor only |
| `memberIds` / `albumIds` | ID[] | no | Owner/editor editable |
| `title`, `description`, `tags`, `date` | content | no | Owner/editor editable |
| `createdAt` | timestamp | yes | Immutable |
| `updatedAt` | timestamp | yes | Updated with transitions |

Client lifecycle: `uploading -> uploaded | upload_failed`. Trusted preservation
moves uploaded media to `processed` and writes immutable derivative/archive
provenance. Client AI requests transition `aiStatus` from `waiting` to
`pending` or `restoration_pending`; trusted workers write results/failures.
Processors must be idempotent by media ID plus source generation.

### `albums/{albumId}`

Family-scoped grouping. Required identity fields are `familyId`, `createdBy`,
`createdAt`, and `updatedAt`; identity fields are immutable. Album membership
references `media_items` IDs in the same family.

### `ai_tasks/{taskId}`

User-visible asynchronous AI work.

Required fields: immutable `userId`, `createdAt`; mutable `status` and
`updatedAt`. A task that operates on family media must also record immutable
`familyId` and `mediaId`; backend workers must verify the task user can access
that family before processing.

### `audit_events/{eventId}`

Append-only backend provenance. Required fields: `eventType`, `actorType`,
`actorId`, `occurredAt`, `targetType`, `targetId`, and non-secret
`metadata`. Clients cannot write this collection; only admins may read it.

## Canonical Storage paths

| Purpose | Path | Client behavior |
| --- | --- | --- |
| Profile image | `users/{uid}/profile/{fileName}` | Owner create/read/delete |
| Original media | `families/{familyId}/media/{mediaId}/original/{fileName}` | Authorized editor creates once after reserving matching media record |
| Derivatives | `families/{familyId}/media/{mediaId}/derived/{generation}/{fileName}` | Family-readable; trusted processor writes |
| Member photo | `families/{familyId}/members/{personId}/{fileName}` | Authorized editor creates/deletes |
| AI staging | `ai-processing/{uid}/{taskId}/{fileName}` | Owning user create/read/delete; temporary |
| Managed assets | `public/{path}` | Authenticated read; admin write |

Client image uploads are limited to JPEG, PNG, TIFF, WebP, HEIC, or HEIF and
10 MiB. Original objects are immutable. The Firebase Storage original path is
the client upload front door; the archive bucket holds exact source generations,
and Firebase Storage holds display/thumbnail derivatives. The legacy gallery
bucket receives no new application dependencies.

## Change process

1. Propose the contract change and compatibility/migration impact here.
2. Update clients, Rules, indexes, processors, and tests in the same rollout.
3. Add an emulator test for each allowed behavior and its cross-user or
   cross-family denial.
4. Deploy additive changes before writers; remove old fields only after readers
   and stored data have migrated.

## Enforcement references

This contract is referenced by `firestore.rules`, `storage.rules`, and
`tests/firebase/security-rules.cjs`. Those executable artifacts remain the source
of truth for currently enforced behavior; any mismatch is a release blocker.
