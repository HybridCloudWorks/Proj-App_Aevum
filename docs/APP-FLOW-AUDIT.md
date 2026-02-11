# APP-FLOW-AUDIT: Technical Gap Analysis

**Date:** February 10, 2026
**Lead Personas:** MAD, GDEF, AAI, CGOA, FED

## 🛡️ Devil's Advocate: The "Hole" Report

### 1. The Mobile Native "Glass Ceiling" (MAD Persona)

- **Problem:** Currently, Aevum is a web-first wrapper.
- **The Hole:** Missing **Offline-First Resilience**. If a user is at a graveyard or ancestral home with poor reception, the current flow (Vite/React) will fail or hang.
- **The Plug:** Implement a **Zustand-Persist** or **IndexedDB** buffer for story recording and image capture. Add an "Offline Mode" indicator to the Global Nav.

### 2. The Relationship Privacy Paradox (GDEF Persona)

- **Problem:** The flow moves from "Tree Explorer" to "Identity Profile" without a clear **Consent/Relationship Guard**.
- **The Hole:** Firebase Security Rules need more than just `auth.uid`. We need **Relationship-Based Access Control (RBAC)**.
- **The Plug:** The `aevum_onboarding__privacy_rules` screen must be more than a checkbox; it needs to trigger a "Kinship Verification" logic in the Firebase Nerve Center.

### 3. AI as a "Menu Item" vs. "Engine" (AAI Persona)

- **Problem:** AI features are separate screens users must click to.
- **The Hole:** **Passive Intelligence**. The app doesn't "watch" the tree. If I add a person, the AI should immediately background-query the **Global Heritage Map** for matches.
- **The Plug:** Integrated **AI Matcher** listeners on the `family_tree_explorer`. Instead of a separate screen, use a "Smart Toast" or "Match Overlay" that triggers as you build.

### 4. Admin vs. Reality (CGOA Persona)

- **Problem:** The Deployment Hub shows "visionOS (RealityKit) 45%".
- **The Hole:** **Backend Invisibility**. The Admin Infrastructure maps to UI, but not to the **ArgoCD/Kubernetes Power Zone** mentioned in `AGENTS.md`.
- **The Plug:** Integrate the **Firebase Nerve Center** with the **n8n Automation Engine** status. Admin screens should surface the health of the "Power Zone" (Vector DB, FinOps calcs).

### 5. Scale & Fragmented Assets (FED Persona)

- **Problem:** 57 folders of raw HTML/Tailwind.
- **The Hole:** **Component Entropy**. Maintaining 13 variants of "Admin Infrastructure" as raw HTML is a maintenance nightmare.
- **The Plug:** Pivot the `aevum_design_system_audit` from a "view" to a **Functional Component Library**. Extract common "Glass Card" and "Header" components into a shared React `components/` directory.

## 🚀 Technical Leverage Opportunities

1.  **Spatial Graph Integration**: Leverage the visionOS 3D tree to allow "Walking Through Your Heritage" (Virtual Immersion).
2.  **Metadata Auto-Extraction**: Leverage `ffmpeg` or `EXIF` workers in the **Power Zone** to auto-place photos on the **Global Heritage Map** based on timestamp/GPS.
3.  **Encrypted Vaults**: Use the `sops` logic from `AGENTS.md` to offer "Private Archives" for sensitive family documents that not even Aevum admins can see.
