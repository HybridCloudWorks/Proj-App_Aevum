# Aevum CSS Technical Specifications & Design System

This document outlines the core design tokens and CSS patterns used in the Aevum project, derived from Google Stitch UI designs.

## 1. Core Visual Effects

### 1.1 Signature Glassmorphism

The "Frosted Glass" effect is the foundation of the Aevum UI.

```css
.glass-panel {
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(25px) saturate(180%);
  -webkit-backdrop-filter: blur(25px) saturate(180%);
  border: 1px solid rgba(255, 255, 255, 0.15);
  border-radius: 24px;
}
```

### 1.2 Vibrant Mesh Gradient

Used as a background for high-impact screens like Auth and Welcome.

```css
.mesh-gradient {
  background:
    radial-gradient(at 0% 0%, #6366f1 0px, transparent 50%),
    radial-gradient(at 100% 0%, #a855f7 0px, transparent 50%),
    radial-gradient(at 50% 100%, #ec4899 0px, transparent 50%);
  filter: blur(80px);
  opacity: 0.6;
}
```

### 1.3 Bento Grid Pattern

Cards should have consistent padding and interactive transitions.

```css
.bento-card {
  padding: 1.5rem;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.bento-card:hover {
  transform: translateY(-4px);
  background: rgba(255, 255, 255, 0.12);
  border-color: rgba(255, 255, 255, 0.25);
}
```

## 2. Typography

- **Primary Sans**: `Inter` (Geometric, clean)
- **Branding Display**: `Playfair Display` (Classic, elegant)
- **Alternative UI**: `Manrope` / `Plus Jakarta Sans`

## 3. Color Palette

- **Background**: `#09090b` (Deep Black/Navy)
- **Primary Accent**: `#6366f1` (Vibrant Indigo)
- **Secondary Accent**: `#a855f7` (Purple)
- **Success**: `#22c55e` (Emerald)
- **Alert**: `#ef4444` (Coral Red)

## 4. Components

### 4.1 Buttons

- **Primary**: Linear gradient from Indigo to Purple.
- **Secondary**: Glass-styled with subtle white border.

### 4.2 Status Indicators

- **Active Orb**: `8x8px` with `radial-shadow`.
- **Match Badge**: Semi-transparent green background with bright green text.
