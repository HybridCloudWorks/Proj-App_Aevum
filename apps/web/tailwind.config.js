/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        // Primary colors from Stitch designs
        primary: {
          DEFAULT: "#1173d4",
          50: "#eef2ff",
          100: "#e0e7ff",
          200: "#c7d2fe",
          300: "#a5b4fc",
          400: "#818cf8",
          500: "#5a5cf2",
          600: "#4f46e5",
          700: "#4338ca",
          800: "#3730a3",
          900: "#312e81",
        },
        // FamilyTree alternate blue
        "primary-blue": {
          DEFAULT: "#1173d4",
          50: "#eff6ff",
          100: "#dbeafe",
          200: "#bfdbfe",
          300: "#93c5fd",
          400: "#60a5fa",
          500: "#1173d4",
          600: "#0e5fb3",
          700: "#0a4b8c",
          800: "#073766",
          900: "#042340",
        },
        accent: {
          DEFAULT: "#0ea5e9", // Updated to match new designs (cyan-blue)
          50: "#f0f9ff",
          100: "#e0f2fe",
          200: "#bae6fd",
          300: "#7dd3fc",
          400: "#38bdf8",
          500: "#0ea5e9",
          600: "#0284c7",
          700: "#0369a1",
          800: "#075985",
          900: "#0c4a6e",
        },
        // Glass effects
        "glass-border": "rgba(255, 255, 255, 0.08)",
        "glass-surface": "rgba(23, 29, 37, 0.7)",
        "glass-surface-light": "rgba(255, 251, 247, 0.7)", // Warm light glass

        // Dark backgrounds
        "background-dark": "#101922",
        "background-light": "#FFFBF7", // Warm Cream (Summer Garden)

        // Peach/Warm Palette (Light Mode Primary)
        peach: {
          50: "#FFF8F3",
          100: "#FFEBDD",
          200: "#FFD6BB",
          300: "#FFBA94",
          400: "#FF9966",
          500: "#FF7D3F", // Primary Brand for Light Mode
          600: "#E65D20",
          700: "#BF4315",
          800: "#993311",
          900: "#7A2A0F",
        },

        "card-glass": "rgba(255, 255, 255, 0.04)",
        "card-border": "rgba(255, 255, 255, 0.08)",
        "card-glass-light": "rgba(255, 255, 255, 0.6)",
        "card-border-light": "rgba(231, 229, 228, 0.6)",

        gold: "#d4af37",
        success: "#22c55e",
        danger: "#ef4444",
        "tier-full": "#10b981",
        "tier-limited": "#f59e0b",
        locked: "#64748b",
      },
      fontFamily: {
        display: [
          "Plus Jakarta Sans",
          "Space Grotesk",
          "Manrope",
          "sans-serif",
        ],
        body: ["Plus Jakarta Sans", "Inter", "sans-serif"],
        serif: ["Playfair Display", "serif"],
      },
      borderRadius: {
        DEFAULT: "0.5rem",
        lg: "1rem",
        xl: "1.5rem",
        "2xl": "2rem",
        "3xl": "2.5rem",
      },
      backdropBlur: {
        xs: "2px",
      },
      animation: {
        "pulse-slow": "pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite",
      },
    },
  },
  plugins: [require("@tailwindcss/forms"), require("tailwind-scrollbar-hide")],
};
