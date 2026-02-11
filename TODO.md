# Aevum Stitch Code Export - Action Required

## The Problem

The Stitch MCP provides **download URLs** for the HTML code, but these URLs require **authentication** to access. When I tried to fetch them directly, they returned parsed markdown instead of raw HTML/CSS code.

---

## Option 1: You Export from Stitch Web UI (Recommended)

### Steps

1. **Open Stitch in your browser**

   ```
   https://stitch.withgoogle.com/projects/6323824354776268694
   ```

2. **For each screen, export the code**:
   - Click on a screen in the canvas
   - Click the **"Code"** or **"</>"** button in the toolbar
   - Copy the HTML code
   - Save to the corresponding file in `src/screens/[category]/`

3. **Screen-to-File Mapping**:

   | Screen Title                    | Save To                                          |
   | ------------------------------- | ------------------------------------------------ |
   | Welcome to Kinship (4 variants) | `src/screens/onboarding/WelcomeScreen.jsx`       |
   | Aevum Secure Auth               | `src/screens/auth/AuthScreen.jsx`                |
   | Family Tree Explorer (3)        | `src/screens/family-tree/FamilyTreeScreen.jsx`   |
   | Member Memories (5)             | `src/screens/memories/MemoriesScreen.jsx`        |
   | Aevum Global Heritage Map (12)  | `src/screens/heritage-map/HeritageMapScreen.jsx` |
   | AI Identity Matcher (3)         | `src/screens/ai-features/AIFeaturesScreen.jsx`   |
   | Aevum Identity Profile (5)      | `src/screens/identity/IdentityScreen.jsx`        |
   | Privacy & Security Settings (2) | `src/screens/settings/SettingsScreen.jsx`        |
   | Aevum Admin Infrastructure (14) | `src/screens/admin/AdminScreen.jsx`              |

---

## Option 2: Provide Me Browser Access

If you want me to do it, I can use the **browser automation** to:

1. Navigate to Stitch
2. Log in using your session
3. Export each screen's code
4. Save to the project files

### How to Enable This

**You have two choices:**

### A) Let Me Use Your Browser Session

1. Open Stitch in your browser and log in
2. Tell me to proceed - I'll use browser automation to:
   - Open each screen in Stitch
   - Copy the code
   - Save it to your project

### B) Provide API Token (If Available)

If Stitch supports API authentication:

1. Go to Stitch settings
2. Generate an API token or find existing credentials
3. Share the token (I'll use it securely via MCP)

---

## Option 3: Bulk Export Script

If Stitch has a bulk export feature, you could:

1. **Check for export option** in Stitch:
   - Project settings → Export
   - Download all screens as HTML/CSS bundle

2. **If available**, download the ZIP and tell me the path - I'll integrate it into the project structure.

---

## Quick Reference: All 61 Screen IDs

See the full list in: [`docs/screens-inventory.md`](file:///c:/Users/saulp/.gemini/antigravity/playground/rapid-protostar/docs/screens-inventory.md)

---

## What's Already Done ✅

- Project structure created
- All placeholder components ready
- Firebase security rules configured
- CI/CD pipeline set up
- Design system matches Stitch theme

**All that's left is importing the actual Stitch-generated HTML/CSS into each component.**

---

## Recommended Action

**Tell me**: "Use the browser to export the Stitch screens"

I'll then:

1. Open Stitch in a browser window
2. Navigate to each screen
3. Export the code
4. Update the component files

This is the fastest way to get all 61 screens imported!
