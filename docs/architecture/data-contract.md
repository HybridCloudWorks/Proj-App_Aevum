# Aevum Canonical Data Contract

Status: Private Beta baseline
Owner: Aevum platform
Applies to: Web, Flutter, Firestore Rules, Storage Rules, Cloud Functions, indexes, tests

## 1. Design principles

1. Authentication identity and genealogy identity are different concepts.
   - A Firebase Auth user is an application collaborator.
   - A genealogical person is family data and does not grant application access.
2. Family authorization is the root of access control for family-scoped data.
3. Client-writable documents carry immutable provenance fields.
4. Server-side processing may enrich media and AI state using trusted service identities.
5. Security Rules are authorization boundaries, not UI hints.
6. Collection/path names in clients, Rules, indexes, and backend functions must match this contract.

## 2. Roles

Family roles are:

- `owner`: represented by `families/{familyId}.ownerId`; exactly one owner.
- `editor`: may read and mutate normal family content.
- `viewer`: read-only family collaborator.

The owner is always included in `families/{familyId}.collaboratorIds` for queryability. Owner privilege is derived from `ownerId`, not from a client-editable role field.

Admin is a platform role represented by a trusted Firebase Auth custom claim (`request.auth.token.admin == true`). Client profile documents must never be authoritative for admin access.

## 3. Collections

### 3.1 `users/{uid}`

Purpose: application profile for one authenticated Firebase user.

Required/standard fields:

- `uid`: string, immutable, equal to document ID.
- `email`: string/null.
- `displayName`: string.
- `photoURL`: string.
- `onboardingComplete`: boolean.
- `createdAt`: timestamp, immutable.
- `updatedAt`: timestamp.

Forbidden client-authoritative fields include `admin`, `role`, `roles`, and `claims`.

Authorization:

- User may read/update their own profile.
- Platform admins may read profiles for support/administration when required.
- Client writes may not create or mutate privilege-bearing fields.

### 3.2 `families/{familyId}`

Purpose: family archive and collaboration boundary.

Required fields:

- `name`: string.
- `description`: string.
- `ownerId`: Firebase UID, immutable.
- `createdBy`: Firebase UID, immutable and equal to initial owner.
- `collaboratorIds`: array of Firebase UIDs; must always include owner.
- `memberCount`: number of genealogical people, derived/maintained by application/backend.
- `createdAt`: timestamp, immutable.
- `updatedAt`: timestamp.

Authorization:

- Owner/editor/viewer/admin may read.
- Owner/editor/admin may update ordinary family metadata.
- Only owner/admin may manage collaborator membership and delete a family.
- `ownerId`, `createdBy`, and `createdAt` are immutable through normal client updates.

Primary query:

`families where collaboratorIds array-contains <uid> order by updatedAt desc`

### 3.3 `families/{familyId}/collaborators/{uid}`

Purpose: role and invitation state for authenticated collaborators other than the owner. The owner does not require a role document because owner authority is defined by `families.ownerId`.

Fields:

- `userId`: Firebase UID, immutable, equal to document ID.
- `role`: `editor` or `viewer`.
- `status`: `active`, `invited`, or `revoked`.
- `invitedBy`: Firebase UID.
- `createdAt`: timestamp, immutable.
- `updatedAt`: timestamp.

Authorization:

- Owner/admin manage collaborator records.
- A collaborator may read their own role record.
- Collaborator documents cannot grant `owner` or platform `admin` privilege.

When membership changes, `families.collaboratorIds` and the collaborator document should be updated atomically.

### 3.4 `family_members/{personId}`

Purpose: a genealogical person in a family tree. This is intentionally separate from authenticated collaborators.

Required/standard fields:

- `familyId`: string, immutable.
- `createdBy`: Firebase UID, immutable.
- `name`: string.
- `role`: display/genealogy label only; never authorization.
- `parentIds`: array of person IDs.
- `spouseIds`: array of person IDs.
- `childIds`: array of person IDs when materialized by the UI/model.
- `birthDate`: date/string/null.
- `deathDate`: date/string/null.
- `photoUrl`: string/null.
- `metadata`: map for non-security genealogy attributes.
- `createdAt`: timestamp, immutable.
- `updatedAt`: timestamp.

Authorization:

- Family owner/editor/admin may create/update/delete.
- Family viewer may read.
- No field on this document grants application access.

### 3.5 `media_items/{mediaId}`

Purpose: canonical metadata record for an original memory and its processed derivatives.

Required/standard fields:

- `familyId`: string, immutable.
- `createdBy`: Firebase UID, immutable.
- `uploadedBy`: Firebase UID, immutable where present.
- `title`: string.
- `description`: string.
- `memberIds`: array of `family_members` IDs.
- `tags`: array of strings.
- `status`: upload/processing lifecycle state.
- `aiStatus`: AI lifecycle state; AI must never block core memory availability.
- `storage`: map containing canonical object paths and derivative references.
- `imageMetadata`: map for dimensions/EXIF/GPS where permitted.
- `createdAt`: timestamp, immutable.
- `updatedAt`: timestamp.

Authorization:

- Family owner/editor/admin may create/update/delete normal client fields.
- Family viewer may read.
- Family scope and provenance fields are immutable through client updates.
- Trusted backend services may update processing/AI fields using server credentials; server SDKs are governed by IAM rather than client Security Rules.

Primary query:

`media_items where familyId == <familyId> order by createdAt desc`

### 3.6 `albums/{albumId}`

Purpose: family-scoped grouping of media items.

Fields:

- `familyId`: string, immutable.
- `createdBy`: Firebase UID, immutable.
- `name`: string.
- `description`: string.
- `mediaIds`: array of media item IDs or an equivalent scalable relation when album size requires it.
- `createdAt`: timestamp, immutable.
- `updatedAt`: timestamp.

Authorization follows the family owner/editor/viewer model.

### 3.7 `ai_tasks/{taskId}`

Purpose: user-visible asynchronous AI task state.

Fields:

- `userId`: Firebase UID, immutable.
- `familyId`: optional family ID.
- `mediaId`: optional media item ID.
- `type`: string.
- `status`: string.
- `result`: map/null.
- `createdAt`: timestamp, immutable.
- `updatedAt`: timestamp.

Authorization:

- Task owner and platform admin may read.
- Client may create tasks only for itself.
- Client may update only explicitly permitted task fields; trusted backend workers own processing/result fields.

### 3.8 `audit_events/{eventId}`

Purpose: reserved append-only security/product provenance stream.

Client contract:

- No direct client writes.
- Backend/service identities create events.
- Read access is admin-only unless a future user export view is introduced deliberately.

## 4. Canonical Storage paths

Private Beta target paths:

- Original family media: `families/{familyId}/media/{mediaId}/original/{fileName}`
- Derived family media: `families/{familyId}/media/{mediaId}/derived/{fileName}`
- Genealogical member photo: `families/{familyId}/members/{personId}/{fileName}`
- User profile image: `users/{uid}/profile/{fileName}`
- AI staging, when needed: `ai-processing/{uid}/{taskId}/{fileName}`
- Managed public assets: `public/{allPaths=**}`

Client rules:

- Owner/editor may create originals for an authorized family.
- Viewers may read but not upload/delete family media.
- Clients do not write derived media; backend processors own derivative generation.
- Object replacement is not used for immutable originals. New content creates a new object/media version.

## 5. Transitional compatibility

PR-02 establishes the canonical Firestore model and authorization boundary. The recovered PR-01 web uploader still writes the legacy paths:

- `families/{familyId}/memories/...`
- `families/{familyId}/thumbnails/...`

Storage Rules may temporarily authorize these two legacy paths for owner/editor clients so PR-02 does not strand the recovered web application. They are deprecated immediately and must be removed by the media-pipeline PR after the uploader moves to the canonical media-ID path.

No new feature should be built on a legacy path.

## 6. Immutable client fields

The following fields are immutable after creation unless changed by a trusted migration/backend process:

- family: `ownerId`, `createdBy`, `createdAt`
- collaborator: `userId`, `createdAt`
- family member: `familyId`, `createdBy`, `createdAt`
- media item: `familyId`, `createdBy`, `uploadedBy`, `createdAt`
- album: `familyId`, `createdBy`, `createdAt`
- AI task: `userId`, `createdAt`

## 7. Query/index contract

Required manual indexes for current client query shapes:

1. `families`: `collaboratorIds ARRAY_CONTAINS`, `updatedAt DESC`
2. `media_items`: `familyId ASC`, `createdAt DESC`
3. `ai_tasks`: `userId ASC`, `createdAt DESC`
4. `albums`: `familyId ASC`, `updatedAt DESC` when sorted album listing is enabled

Basic equality-only queries rely on automatic indexes unless emulator/integration tests demonstrate a manual index is needed.

## 8. Migration rules

1. Do not infer authorization from genealogical `role` values.
2. Do not authorize family content solely from `createdBy`/`uploadedBy`; authorize from family membership/role.
3. Legacy `members` documents migrate to `family_members` before Private Beta data is treated as durable.
4. Legacy family `members` arrays must not be reused for access control. `collaboratorIds` is the queryable authenticated-user list.
5. Legacy `photoUrl`/`thumbnailUrl` fields may be read during migration, but new processing work should populate the canonical `storage` map.
6. Client and Rules changes that alter a path or required field must ship atomically in the same release train.
