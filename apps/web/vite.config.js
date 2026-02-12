import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { resolve } from "path";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],

  // Path aliases for cleaner imports
  resolve: {
    alias: {
      "@": resolve(__dirname, "./src"),
      "@screens": resolve(__dirname, "./src/screens"),
      "@components": resolve(__dirname, "./src/components"),
      "@styles": resolve(__dirname, "./src/styles"),
      "@assets": resolve(__dirname, "./src/assets"),
      "@lib": resolve(__dirname, "./src/lib"),
      "@hooks": resolve(__dirname, "./src/hooks"),
    },
  },

  // Build optimization
  build: {
    // Target modern browsers for smaller bundles
    target: "esnext",

    // Output directory for Firebase Hosting
    outDir: "dist",

    // Chunk splitting for better caching
    rollupOptions: {
      output: {
        manualChunks: {
          // Vendor chunks
          "vendor-react": ["react", "react-dom", "react-router-dom"],
          "vendor-firebase": [
            "firebase/app",
            "firebase/auth",
            "firebase/firestore",
            "firebase/storage",
          ],
          "vendor-state": ["zustand"],
        },
      },
    },

    // Enable source maps for debugging
    sourcemap: true,

    // Minification
    minify: "esbuild",
  },

  // Development server
  server: {
    port: 3000,
    strictPort: true,
    host: true,

    // CORS configuration for Firebase emulators
    cors: true,

    // Proxy API requests if needed
    proxy: {
      // Example: proxy to Firebase Functions emulator
      // '/api': {
      //   target: 'http://localhost:5001',
      //   changeOrigin: true,
      // },
    },
  },

  // Preview server (for production build testing)
  preview: {
    port: 4173,
    strictPort: true,
  },

  // CSS configuration
  css: {
    // Enable CSS modules
    modules: {
      localsConvention: "camelCase",
    },
  },

  // Environment variables prefix
  envPrefix: "VITE_",

  // Define global constants
  define: {
    __APP_VERSION__: JSON.stringify(process.env.npm_package_version),
  },
});
