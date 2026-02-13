# Aevum - Master Screen & Flow Mapping

This registry maps all **57** exported Stitch Design folders to their React components and logical application flow.

## 🏷️ Flow Mapping Key

- **Zone**: The functional area of the app.
- **Trigger/Action**: The primary interaction that leads to this screen or its variant.
- **Destination**: Where the user goes next or returns to.

---

## 🚀 Zone 1: Entry & Onboarding (12 Screens)

| Design Folder / ID                | Title              | React Component (Placeholder) | Primary Action / Flow              |
| :-------------------------------- | :----------------- | :---------------------------- | :--------------------------------- |
| `welcome_to_kinship_1` ... `4`    | Welcome to Kinship | `onboarding/WelcomeScreen`    | Initial Landing -> Auth / Signup   |
| `aevum_log_in_sign_up`            | Log In / Sign Up   | `auth/AuthScreen`             | Credentials Entry -> Journey Start |
| `start_your_aevum_journey...` [6] | Start Your Journey | `onboarding/JourneyScreen`    | Multi-step guide -> Final Privacy  |
| `aevum_onboarding_privacy...`     | Privacy Rules      | `onboarding/PrivacyScreen`    | Consent -> Dashboard Entry         |

---

## 🌳 Zone 2: Core Heritage Experience (18 Screens)

| Design Folder / ID               | Title              | React Component (Placeholder) | Primary Action / Flow            |
| :------------------------------- | :----------------- | :---------------------------- | :------------------------------- |
| `aevum_family_tree_explorer`     | Tree Explorer      | `family-tree/TreeScreen`      | View Pedigree -> Member Details  |
| `identify_&_grow_tree`           | Grow Your Tree     | `family-tree/GrowthScreen`    | Add Person -> Metadata Entry     |
| `member_memories` [4 variants]   | Member Memories    | `memories/MemoriesVault`      | Gallery View -> Upload Picture   |
| `aevum_global_heritage_map` [10] | Heritage Map       | `heritage-map/MapScreen`      | Geo-Visual -> Location Deep Dive |
| `global_heritage_search`         | Heritage Search    | `heritage-map/MapSearch`      | Query -> Map Result              |
| `restricted_parent_profile`      | Restricted Profile | `identity/RestrictedProfile`  | Secondary Access Control View    |

---

## 🤖 Zone 3: Identity & AI Suite (5 Screens)

| Design Folder / ID           | Title            | React Component (Placeholder) | Primary Action / Flow             |
| :--------------------------- | :--------------- | :---------------------------- | :-------------------------------- |
| `aevum_identity_profile` [2] | Identity Profile | `identity/ProfileScreen`      | View Personal Bio -> Edit / Share |
| `ai_identity_matcher` [2]    | AI Matcher       | `ai/MatcherTask`              | Logic Match -> Verification       |
| `ai_family_chronicles`       | AI Chronicles    | `ai/ChroniclesScreen`         | Narrative Gen -> Export Story     |

---

## 🛠️ Zone 4: Admin & Infrastructure (17 Screens)

| Design Folder / ID                | Title            | React Component (Placeholder) | Primary Action / Flow               |
| :-------------------------------- | :--------------- | :---------------------------- | :---------------------------------- |
| `aevum_admin_infrastructure` [13] | Admin Command    | `admin/InfraScreen`           | System Stats -> Deployment          |
| `aevum_admin_delegation` [2]      | Admin Delegation | `admin/DelegationScreen`      | Permission Grant -> Role Management |
| `aevum_catalog_engine`            | Catalog Engine   | `admin/CatalogScreen`         | Data Indexing -> Asset Review       |
| `aevum_firebase_nerve_center`     | Firebase Center  | `admin/FirebaseScreen`        | Cloud Sync -> Security Oversight    |

---

## 🌐 Zone 5: System Strategy & Vision (5 Screens)

| Design Folder / ID            | Title            | React Component (Placeholder) | Primary Action / Flow             |
| :---------------------------- | :--------------- | :---------------------------- | :-------------------------------- |
| `aevum_frontend_deployment`   | Deployment Hub   | `admin/DeployHub`             | Build Stat -> **visionOS Launch** |
| `privacy_&_security_settings` | Privacy Settings | `settings/PrivacySettings`    | Toggle Access -> Save             |
| `data_structure_portability`  | Data Settings    | `settings/DataSettings`       | Export JSON/CSV -> Local Backup   |
| `aevum_design_system_audit`   | Design Audit     | `admin/DesignAudit`           | Component Review -> CSS Sync      |
| `aevum_alpha_launch_control`  | Launch Control   | `admin/LaunchControl`         | Feature Flags -> Production Push  |

---

## 🕶️ visionOS Compatibility Strategy

The **Aevum Frontend Deployment Hub** serves as the gateway for "Spatial" builds.

- Screens tagged as "Heritage Map" and "3D Tree" in development will link to RealityKit anchors managed in the **DeployHub**.
- Storage management (Add Pictures/People) is centralized in **MemoriesVault** and **GrowthScreen**, synced via the **Firebase Nerve Center**.
