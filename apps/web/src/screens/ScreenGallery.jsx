/**
 * Stitch Screen Gallery
 *
 * Browse all 57 exported Stitch screens with thumbnails and preview.
 * This is the main entry point for viewing the Aevum design system.
 */

import { useState } from "react";
import { STITCH_SCREENS, getAllScreens } from "../stitch-screens";
import StitchViewer from "../components/StitchViewer";
import "./ScreenGallery.css";

function ScreenGallery() {
  const [selectedScreen, setSelectedScreen] = useState(null);
  const [activeCategory, setActiveCategory] = useState("all");

  const categories = [
    { key: "all", label: "All Screens" },
    { key: "onboarding", label: "Onboarding" },
    { key: "auth", label: "Auth" },
    { key: "familyTree", label: "Family Tree" },
    { key: "memories", label: "Memories" },
    { key: "heritageMap", label: "Heritage Map" },
    { key: "ai", label: "AI Features" },
    { key: "identity", label: "Identity" },
    { key: "admin", label: "Admin" },
    { key: "catalog", label: "Catalog" },
    { key: "settings", label: "Settings" },
    { key: "firebase", label: "Firebase" },
    { key: "design", label: "Design" },
    { key: "launch", label: "Launch" },
  ];

  const getScreensForCategory = (categoryKey) => {
    if (categoryKey === "all") {
      return getAllScreens();
    }
    const category = STITCH_SCREENS[categoryKey];
    if (!category) return [];
    return Object.values(category).flat();
  };

  const screens = getScreensForCategory(activeCategory);

  const formatScreenName = (folder) => {
    return folder
      .replace(/_/g, " ")
      .replace(/(\d+)$/, " $1")
      .replace(/\s+/g, " ")
      .trim();
  };

  return (
    <div className="screen-gallery">
      {/* Header */}
      <header className="gallery-header">
        <h1>Aevum Screen Gallery</h1>
        <p className="gallery-subtitle">57 screens from Stitch</p>
      </header>

      {/* Category Tabs */}
      <nav className="gallery-categories">
        {categories.map((cat) => (
          <button
            key={cat.key}
            className={`category-tab ${activeCategory === cat.key ? "active" : ""}`}
            onClick={() => setActiveCategory(cat.key)}
          >
            {cat.label}
          </button>
        ))}
      </nav>

      {/* Screen Grid */}
      <div className="gallery-grid">
        {screens.map((screen) => (
          <button
            key={screen}
            className={`screen-card ${selectedScreen === screen ? "selected" : ""}`}
            onClick={() => setSelectedScreen(screen)}
          >
            <div className="screen-thumbnail">
              <img
                src={`/src/stitch-screens/${screen}/screen.png`}
                alt={formatScreenName(screen)}
                loading="lazy"
              />
            </div>
            <p className="screen-name">{formatScreenName(screen)}</p>
          </button>
        ))}
      </div>

      {/* Preview Modal */}
      {selectedScreen && (
        <div className="preview-modal" onClick={() => setSelectedScreen(null)}>
          <div className="preview-content" onClick={(e) => e.stopPropagation()}>
            <header className="preview-header">
              <h2>{formatScreenName(selectedScreen)}</h2>
              <button
                className="close-btn"
                onClick={() => setSelectedScreen(null)}
              >
                ✕
              </button>
            </header>
            <div className="preview-body">
              <StitchViewer screenFolder={selectedScreen} />
            </div>
            <footer className="preview-footer">
              <a
                href={`/src/stitch-screens/${selectedScreen}/code.html`}
                target="_blank"
                rel="noopener noreferrer"
                className="view-code-btn"
              >
                View HTML Source
              </a>
            </footer>
          </div>
        </div>
      )}
    </div>
  );
}

export default ScreenGallery;
