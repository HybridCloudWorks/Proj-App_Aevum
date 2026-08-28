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
4. Media uses a reserve -> upload -> process lifecycle so every object has a stable `mediaId` before bytes are uploaded.
5. Server-side processing enriches media and AI state using trusted service identities.
6. Original objects are immutable. Derived and archive objects are generation-aware so retries are idempotent and a replaced source can never overwrite prior preservation output.
7. Security Rules are authorization boundaries, not UI hints.
8. Collection/path names in clients, Rules, indexes, infrastructure, and backend functions must match this contract.

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

When membership changes, `families.collaboratorIds` and the collaborator document must be updated atomically.

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

Purpose: canonical metadata record for one immutable uploaded original and its preservation/AI lifecycle.

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
- `storage`: map containing canonical original, derivative, and archive references.
- `processing`: map containing source generation, event ID, processing timestamps, dimensions, and extracted preservation metadata.
- `imageMetadata`: client-extracted metadata when available and permitted.
- `createdAt`: timestamp, immutable.
- `updatedAt`: timestamp.

Canonical lifecycle:

1. Client reserves `media_items/{mediaId}` with `status = uploading`.
2. Client uploads the original to the canonical Storage path using that `mediaId`.
3. Client finalizes upload metadata with `status = uploaded` and the original reference.
4. The Storage finalize event invokes the preservation processor.
5. Processor records `status = processing`, source generation, and event identity.
6. Processor creates generation-specific derivatives and an immutable archive copy.
7. Processor records `status = processed`, canonical `storage` references, and `aiStatus = pending`.
8. AI enrichment may continue asynchronously. Failure of AI does not invalidate the preserved memory.

Expected processing/error states include `uploading`, `uploaded`, `upload_failed`, `processing`, `processed`, and `processing_failed`.

Canonical `storage` fields after preservation:

- `originalPath`: Firebase Storage object path.
- `originalGsUri`: `gs://` URI for the original.
- `displayPath`: generation-specific display derivative path.
- `displayGsUri`: `gs://` URI consumed by backend AI analysis.
- `thumbnailPath`: generation-specific thumbnail derivative path.
- `thumbnailGsUri`: `gs://` URI for the thumbnail.
- `archiveGsUri`: immutable archive-bucket URI for the exact source generation.

Authorization:

- Family owner/editor/admin may create/update/delete normal client fields.
- Family viewer may read.
- Family scope and provenance fields are immutable through client updates.
- Trusted backend services update processing/AI fields using server credentials; server SDKs are governed by IAM rather than client Security Rules.

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

## 4. Canonical Storage and preservation paths

The Firebase Storage bucket used by authenticated web/mobile clients is the event source for preservation.

Client-write path:

- Original family media: `families/{familyId}/media/{mediaId}/original/{fileName}`

Backend-write paths in the same Firebase Storage bucket:

- Display derivative: `families/{familyId}/media/{mediaId}/derived/{sourceGeneration}/display.webp`
- Thumbnail derivative: `families/{familyId}/media/{mediaId}/derived/{sourceGeneration}/thumbnail.webp`

Archive-bucket path:

- Exact original generation: `families/{familyId}/media/{mediaId}/originals/{sourceGeneration}/{fileName}`

Other app paths:

- Genealogical member photo: `families/{familyId}/members/{personId}/{fileName}`
- User profile image: `users/{uid}/profile/{fileName}`
- AI staging, when needed: `ai-processing/{uid}/{taskId}/{fileName}`
- Managed public assets: `public/{allPaths=**}`

Private Beta media capability is image-only. Supported image types are JPEG, PNG, TIFF, WebP, HEIC, and HEIF where the client platform can supply a valid MIME type. Video/audio/document preservation must not be enabled in client rules until a processor for those types exists.

Client rules:

- Owner/editor may create originals for an authorized family.
- Viewers may read but not upload/delete family media.
- A reserved `mediaId` is mandatory before family-media upload.
- Clients do not write derived media; backend processors own derivative generation.
- Object replacement is not the media-versioning mechanism. New content creates a new media record/object.

Backend rules:

- Storage finalize processing ignores non-canonical-original paths, preventing derivative recursion.
- The processor validates that the object path family matches `media_items/{mediaId}.familyId`.
- Processing is generation-aware and retry-safe.
- Derivative/archive creation uses create-if-absent preconditions so duplicate events reuse existing output rather than overwrite it.
- The source original remains in Firebase Storage; the archive is an additional preservation copy, not a move.

## 5. Legacy storage retirement

The PR-01 legacy family-media paths are retired from new client authorization:

- `families/{familyId}/memories/...`
- `families/{familyId}/thumbnails/...`
- user-oriented `uploads/{uid}/...`

No new feature may use these paths. Historical objects may require a controlled backend migration, but client Security Rules must not reopen legacy paths simply to make old code work.

Legacy `photoUrl`, `thumbnailUrl`, or `urls.display` fields may be read during data migration. New preservation work writes the canonical `storage` map, and AI analysis consumes `storage.displayGsUri` (with any legacy fallback treated as transitional compatibility only).

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
5. Legacy media URL fields may remain readable during migration but new writes use the canonical `storage` map.
6. Legacy family-media Storage paths are not valid new-write targets.
7. Client, Rules, infrastructure, and processor changes that alter a path or required field must ship in the same release train.
8. Security and processing behavior is not release-validated until Emulator Suite and end-to-end tests execute successfully in CI.
