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
          DEFAULT: "#8b5cf6",
          50: "#faf5ff",
          100: "#f3e8ff",
          200: "#e9d5ff",
          300: "#d8b4fe",
          400: "#c084fc",
          500: "#a855f7",
          600: "#8b5cf6",
          700: "#7c3aed",
          800: "#6d28d9",
          900: "#5b21b6",
        },
        // Glass effects
        "glass-border": "rgba(255, 255, 255, 0.08)",
        "glass-surface": "rgba(255, 255, 255, 0.05)",
        // Dark backgrounds
        "background-dark": "#101922",
        "background-light": "#f6f7f8",
        "card-glass": "rgba(255, 255, 255, 0.04)",
        "card-border": "rgba(255, 255, 255, 0.08)",
        gold: "#d4af37",
        success: "#22c55e",
        danger: "#ef4444",
      },
      fontFamily: {
        display: [
          "Space Grotesk",
          "Plus Jakarta Sans",
          "Manrope",
          "sans-serif",
        ],
        body: ["Inter", "sans-serif"],
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
