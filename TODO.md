# Aevum Project Roadmap & TODO 📝

## 🚀 Phase 1: Foundation & Design System (GDEF/FED Focused)

_Goal: Solidify the core UI framework, accessibility, and cross-browser stability._

- [x] **CSS Compatibility (Critical)**
  - [x] Fix `backdrop-filter` vendor prefixing and property order globally.
  - [x] Standardize scrollbar hiding using `tailwind-scrollbar-hide` plugin.
  - [x] Remove local CSS hacks in favor of global utilities.
- [x] **Collection Standardization**
  - [x] Consolidate `family_members` (mobile) into top-level `members`.
  - [x] Consolidate `memories` into `media_items`.
- [x] **Light Mode Foundation**
  - [x] Locked "Summer Garden Party" visual style for Light Mode.
- [ ] **Mobile Safe Area (Urgent)**
  - [ ] Implement `pb-safe` utility leveraging `env(safe-area-inset-bottom)`.
  - [ ] Standardize bottom padding across `VaultHealth`, `Settings`, and `Infrastructure`.
- [ ] **Navigation & Layout Architecture**
  - [ ] Create `FocusLayout` for immersive routes (Settings, Spatial) to prevent user flow "traps".
  - [ ] Create `NotFoundScreen` (404) to replace silent redirects to Home.
  - [ ] Extract `BottomNav` to a reusable component in `apps/web/src/components/Navigation/`.
- [ ] **Component Library (Eliminate Starvation)**
  - [ ] Extract `GlassCard` (dark/light variants) to `/components/ui/`.
  - [ ] Extract `Button` (primary/secondary/glass variants) to `/components/ui/`.
  - [ ] General audit of repetitive UI patterns (headers, list items) for componentization.
- [ ] **Light Mode Audit**
  - [ ] Audit `mesh-bg` keyframes in `index.css` to adapt to light themes (currently dark hex values).
  - [ ] Audit legacy screens (`MessengerHub`, `FamilyTree`, `AuthScreen`) for color contrast compliance.

## 🎯 Phase 2: MVP Features & Core Integration (GDEF Focused)

_Goal: Deliver the "Meal Ticket" features for the Minimum Viable Product._

- [ ] **Family Tree "Pannable" Explorer (Priority #1)**
  - [ ] Integrate Stitch-generated HTML/CSS into `FamilyTreeScreen.jsx`.
  - [ ] Implement smooth panning and zooming for the visual canvas.
  - [ ] Connect tree nodes to the standardized `members` collection.
- [ ] **Stitch Integration Status**
  - [ ] `FamilyTreeScreen.jsx` - Integration of "Explorer" view.
  - [ ] `MemoriesScreen.jsx` - Integration of "Member Memories".
  - [ ] `WelcomeScreen.jsx` - Integration of "Welcome to Kinship".
  - [ ] `HeritageMapScreen.jsx` - Integration of "Global Heritage Map".
- [ ] **Firestore Security & Data Integrity**
  - [ ] Implement `request.auth.uid` isolation code for all family data.
  - [ ] Validate and deploy rules for the new `members` collection.
  - [ ] Lockdown `media_items` and `ai_tasks` collections.

## 🤖 Phase 3: AI Features & UX Polish (AAI/FED Focused)

_Goal: Add the premium "magic" and backend AI capabilities._

- [ ] **Premium Animation System**
  - [ ] Install `framer-motion` library.
  - [ ] Refactor route transitions (Settings enter/exit, Gallery opening) for fluid, physics-based motion.
- [ ] **Identity & Tagging Engine**
  - [ ] Implement Face Detection triggers (Single, Bulk, and Periodic scanning).
  - [ ] Implement **Vector Storage** solution (Firestore Vector Search or similar) for matching.
  - [ ] Build **Approval Hub** for connections and AI tagging confirmations.
- [ ] **Functional AI Connections**
  - [ ] Connect `MemoriesScreen` "Start Restore" action to backend workers.
  - [ ] Link `AIFeaturesScreen` to live backend analysis status.

## 🌌 Phase 4: Spatial & VisionOS (MAD/Architecture Focused)

_Goal: Extend the experience into immersive environments._

- [x] **Spatial Prototypes (Implemented)**
  - [x] `SpatialMemoryGallery.jsx` (Event-based grouping).
  - [x] `SpatialHeritageTree.jsx` (Profile quick-view flows).
  - [x] `AIResourceManager.jsx` (Prioritization queue).
- [ ] **VisionOS Porting & Optimization**
  - [ ] Adapt 3D spacing logic (`preserve-3d` context) for native VisionOS viewing.
  - [ ] Adapt hover/focus states for eye-tracking interaction models.
- [ ] **The "Immersive Bridge"**
  - [ ] Add "Enter Spatial Mode" button to 2D `MemoriesScreen` for compatible hardware.

## 📦 Phase 5: Build & GitOps (GHE Focused)

_Goal: Production readiness and deployment._

- [ ] **GitOps Protocol Deployment**
  - [ ] Verify build status for Web and Mobile platforms.
  - [ ] Final environment variable audit (Notion Sync).
  - [ ] Merge and push to main for deployment.

---

_Note: Architecture follows the Firebase Serverless stack. Kubernetes/VPS tasks have been moved to legacy reference._
