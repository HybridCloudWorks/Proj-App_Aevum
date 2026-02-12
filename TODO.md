# Aevum Project Roadmap & TODO 📝

## 🎯 The "Meal Ticket": MVP Priority #1

- [ ] **Family Tree "Pannable" Screen** (Feature #1)
  - [ ] Integrate Stitch-generated HTML/CSS into `FamilyTreeScreen.jsx`.
  - [ ] Implement smooth panning and zooming for the tree canvas.
  - [ ] Connect tree nodes to the standardized `members` collection.
  - [ ] Handle real-time updates when new branches are merged.
  - [ ] Ensure flawless interaction on both mobile and web viewports.

## 🛠️ Core Infrastructure (GDEF Focused)

- [x] **Collection Standardization**
  - [x] Consolidate `family_members` (mobile) into top-level `members`.
  - [x] Consolidate `memories` into `media_items`.
  - [x] Ensure real-time sync works across platforms without dual-writes.
- [ ] **Firestore Security Rules**
  - [ ] Implement `request.auth.uid` isolation for all family data.
  - [ ] Validate rules against the new top-level `members` structure.
  - [ ] Lock down `media_items` and `ai_tasks` collections.
- [ ] **Bottom Navigation Standardization**
  - [ ] Create a reusable `BottomNav` component in `apps/web/src/components/Navigation/`.
  - [ ] Standardize the mobile nav in `apps/mobile/lib/widgets/`.
  - [ ] Link all primary screens: Home, Family Tree, Memories, Heritage Map.

## 🤖 AI Features & Backend Integration

- [ ] **Semantic Discovery / Face Detection**
  - [ ] Link `AIFeaturesScreen` to trigger backend analysis.
  - [ ] Implement the "Confirm & Merge Branch" logic (Data flow: AI Suggestion -> `members` collection).
- [ ] **Photo Restoration**
  - [ ] Connect `MemoriesScreen` "Start Restore" action to trigger backend workers.
  - [ ] Monitor `ai_tasks` status in real-time.

## 📦 Deployment & DevOps

- [ ] **GitOps Protocol**
  - [ ] Commit and stage all standardized code changes.
  - [ ] Verify build status for Web and Mobile.
  - [ ] Push to main for deployment.

---

## Artifact: Stitch Integration Status

- [ ] Import Stitch-generated UI into the following screens:
      | Screen Title | Component Path | Status |
      | :--- | :--- | :--- |
      | Family Tree Explorer | `FamilyTreeScreen.jsx` | 🔄 Priority |
      | Member Memories | `MemoriesScreen.jsx` | ⏳ Pending |
      | Welcome to Kinship | `WelcomeScreen.jsx` | ⏳ Pending |
      | Aevum Global Heritage Map | `HeritageMapScreen.jsx` | ⏳ Pending |

---

_Note: Any references to Kubernetes, VPS, or ArgoCD have been struck from the project architecture to focus exclusively on the Firebase Serverless stack._
