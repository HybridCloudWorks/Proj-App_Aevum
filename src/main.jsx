/**
 * Aevum Main Entry Point
 *
 * Following MAD (Mobile Application Developer) and FED best practices:
 * - StrictMode for development warnings
 * - Clean initialization
 */

import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import App from "./App";
import "./styles/index.css";

// Initialize app
createRoot(document.getElementById("root")).render(
  <StrictMode>
    <App />
  </StrictMode>,
);
