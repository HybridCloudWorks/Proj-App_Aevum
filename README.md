# 🌳 Aevum - Global Family Heritage Platform

> **Vision**: Bridging generations by preserving and connecting global family heritage through AI-enhanced storytelling and geographic visualization.

![Aevum Banner](https://img.shields.io/badge/Aevum-Heritage-blue?style=for-the-badge&logo=firebase)
![Status](https://img.shields.io/badge/Status-In--Development-orange?style=for-the-badge)

---

## 🏛️ Project Architecture (Monorepo)

Aevum is organized as a unified monorepo containing both the web and native mobile platforms.

### 🧩 Core Modules

| Path              | Platform  | Tech Stack                        | Status      |
| :---------------- | :-------- | :-------------------------------- | :---------- |
| `apps/web`        | Web/PWA   | React 18, Vite, Tailwind, GDEF    | Refactoring |
| `apps/mobile`     | Native    | Flutter Stable, MAD Best Factors  | Active Dev  |
| `docs/`           | Shared    | Strategic Docs & Design Baselines | Centralized |
| `infrastructure/` | DevSecOps | Firebase Rules, Terraform, CI/CD  | Locked      |

## 🚀 Quick Start

### 🌐 Web Project

```bash
cd apps/web
npm install
npm run dev
```

### 📱 Mobile Project

```bash
cd apps/mobile
flutter pub get
flutter run
```

### 🔐 Shared Infrastructure

To deploy Firestore or Storage rules:

```bash
firebase deploy --only firestore:rules
```

## 🗺️ Documentation & Mapping

We maintain a centralized documentation hub in the `docs/` folder:

- **[Strategic Docs](docs/)**: Migration logs, implementation plans, and walkthroughs.
- **[Design Baselines](docs/baselines/)**: 57 high-fidelity design captures for 1-to-1 UI matching.
- **[Master Mapping](docs/mapping.md)**: Registry of design-to-code components.

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
