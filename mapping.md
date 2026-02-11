# Aevum Project Mapping

This document provides a comprehensive mapping between the **Stitch Designs** and the **React Implementation**.

## 📊 Mapping Table

| Category         | Stitch Screen ID                   | Stitch Folder Name             | Target React Component                           | Status      |
| :--------------- | :--------------------------------- | :----------------------------- | :----------------------------------------------- | :---------- |
| **Onboarding**   | `973d07394bd54665a5cd17804886c6ca` | `welcome_to_kinship_1`         | `src/screens/onboarding/WelcomeScreen.jsx`       | Placeholder |
| **Auth**         | `d18bca27a6284f32b50c8ee4cd7b4f05` | `aevum_secure_auth`            | `src/screens/auth/AuthScreen.jsx`                | Placeholder |
| **Family Tree**  | `fef0a14dac3348a486017a9f336418e4` | `family_tree_explorer_1`       | `src/screens/family-tree/FamilyTreeScreen.jsx`   | Placeholder |
| **Memories**     | `72a1ca49f3894dc7bf419d937d2c4d96` | `member_memories_1`            | `src/screens/memories/MemoriesScreen.jsx`        | Placeholder |
| **Heritage Map** | `732382af817245b4a058aeb99c40d215` | `aevum_global_heritage_map_1`  | `src/screens/heritage-map/HeritageMapScreen.jsx` | Placeholder |
| **AI Features**  | `9205c379075a4bbba03dd845382fb51b` | `ai_identity_matcher_1`        | `src/screens/ai-features/AIFeaturesScreen.jsx`   | Placeholder |
| **Identity**     | `daddb58a32cf445ba688d4ea17f63f9f` | `aevum_identity_profile`       | `src/screens/identity/IdentityScreen.jsx`        | Placeholder |
| **Admin**        | `c6166617709a433e8aa9baab60d601a9` | `aevum_admin_infrastructure_1` | `src/screens/admin/AdminScreen.jsx`              | Placeholder |
| **Catalog**      | `e6552b0875324958b10c5ad973af4e2d` | `aevum_catalog_engine`         | `src/screens/catalog/CatalogScreen.jsx`          | Placeholder |
| **Settings**     | `70d98399822f4c2dbb95846e7f8844bb` | `privacy_&_security_settings`  | `src/screens/settings/SettingsScreen.jsx`        | Placeholder |

> [!NOTE]
> This table lists primary screens. Many screens have multiple variants (e.g., Onboarding has 6 screens). These are all accessible via the `src/screens/ScreenGallery.jsx` for review before being integrated into their respective components.

## 📁 Directory Structure

- `src/screens/`: Contains the React functional components that will eventually host the logic and UI.
- `src/stitch-screens/`: Contains the raw HTML/CSS exported from Stitch, organized by folder name.
- `src/stitch-screens/index.js`: The central registry of all 57 exported screens.

## 🛠️ Next Steps

1. **Extract UI**: Use the `StitchViewer` or direct HTML copy-paste from `src/stitch-screens/` to populate the `src/screens/` placeholders.
2. **Componentize**: Break down the large HTML blocks into reusable React components in `src/components/`.
3. **Logic Integration**: Connect Firebase Auth, Firestore, and Storage to the reactive UI elements.
