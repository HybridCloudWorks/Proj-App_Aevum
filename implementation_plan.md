# Implementation Plan - Recreate Aevum Mapping and README

The goal is to provide a clear, updated "mapping" between Stitch designs and the React implementation, and to establish a high-quality README that reflects the project's current state and vision.

## User Review Required

> [!IMPORTANT]
> The project currently uses `src/stitch-screens/` as a "gallery" of exported HTML/CSS, while the main React screens in `src/screens/` are largely placeholders. Recreating the "mapping" will focus on explicitly linking the Stitch IDs to these React components and their corresponding export folders.

## Proposed Changes

### Documentation

#### [NEW] [mapping.md](file:///c:/Users/saulp/.gemini/antigravity/playground/rapid-protostar/docs/mapping.md)
Create a comprehensive mapping document that links:
- **Stitch Screen ID** (from [screens-inventory.md](file:///c:/Users/saulp/.gemini/antigravity/playground/rapid-protostar/docs/screens-inventory.md))
- **Stitch Folder Name** (from [src/stitch-screens/index.js](file:///c:/Users/saulp/.gemini/antigravity/playground/rapid-protostar/src/stitch-screens/index.js))
- **Target React Component** (from `src/screens/`)
- **Implementation Status** (Placeholder vs. Dynamic)

#### [MODIFY] [README.md](file:///c:/Users/saulp/.gemini/antigravity/playground/rapid-protostar/README.md)
Update the README to:
- Reflect the "Global Family Heritage" vision.
- Add clear "Navigation & Mapping" section.
- Use premium formatting and icons.
- Document the directory structure and how to import new Stitch screens.

## Verification Plan

### Manual Verification
- Verify all links in the new `mapping.md` point to existing files.
- Ensure the [README.md](file:///c:/Users/saulp/.gemini/antigravity/playground/rapid-protostar/README.md) correctly describes the active project structure.
- Review the mapping with the user to ensure it covers all 61 screens mentioned in the inventory.
