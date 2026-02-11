# 🌳 Aevum - Global Family Heritage Platform

> **Vision**: Bridging generations by preserving and connecting global family heritage through AI-enhanced storytelling and geographic visualization.

![Aevum Banner](https://img.shields.io/badge/Aevum-Heritage-blue?style=for-the-badge&logo=firebase)
![Status](https://img.shields.io/badge/Status-In--Development-orange?style=for-the-badge)

---

## 🏛️ Project Architecture

Aevum is built as a high-performance, mobile-first React application powered by Firebase, following the **GDEF (Google Developer Expert for Firebase)** and **MAD (Mobile App Development)** best practices.

### 🧩 Core Modules

| Module           | Description                                                        |
| :--------------- | :----------------------------------------------------------------- |
| **Onboarding**   | Immersive multi-screen introduction to the Kinship journey.        |
| **Family Tree**  | Dynamic, interactive genealogy tree with identification features.  |
| **Memories**     | Multimedia repository for family photos, stories, and artifacts.   |
| **Heritage Map** | Geographic visualization of ancestral origins and global heritage. |
| **AI Features**  | Identity matching and automated family chronicling.                |
| **Identity**     | Security-first profile management and privacy controls.            |

## 🗺️ Navigation & Mapping

To facilitate implementation, we maintain detailed mapping between Stitch designs and React components:

- **[Master Mapping Registry](docs/mapping.md)**: 1-to-1 link between all 57 design folders and their target code.
- **[End-to-End User Flows](docs/user-flow.md)**: Visualized journey map (Mermaid) including Onboarding, Admin, and AI logic.

### 👓 Spatial & visionOS Strategy

Aevum is built with **Spatial Computing** in mind. The [Deployment Hub](src/stitch-screens/aevum_frontend_deployment_hub) manages build pipelines that sync heritage data to RealityKit-enabled environments, particularly for the **Heritage Map** and **3D Family Tree**.

## 🚀 Quick Start

### Prerequisites

- Node.js (v18+)
- Firebase CLI (`npm install -g firebase-tools`)

### Setup

```bash
# Clone and install
git clone <repo-url>
cd MVP-Aevum
npm install

# Start Development
npm run dev
```

### Emulators

To test locally with Firestore and Storage:

```bash
npm run firebase:emulators
```

## 🔐 Security & Data (GDEF Guidelines)

- **RBAC**: Role-Based Access Control implemented via Firestore Security Rules.
- **Validation**: Strict input validation for all heritage data entry.
- **Privacy**: User-scoped data isolation for sensitive family memories.

## 🛠️ Tech Stack

- **Frontend**: React 18, Vite, TypeScript, TailwindCSS
- **State**: Zustand (Atomic state management)
- **Backend**: Firebase Auth, Firestore, Cloud Storage
- **Routing**: React Router 6 (Lazy-loaded routes)

---

## 📄 License

MIT © 2026 Aevum Heritage Team
