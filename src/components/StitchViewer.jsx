/**
 * Stitch Screen Viewer Component
 *
 * Renders the raw HTML from Stitch exports in an iframe.
 * This allows viewing the original Stitch designs before React conversion.
 */

import { useEffect, useRef, useState } from "react";
import "./StitchViewer.css";

export function StitchViewer({ screenFolder, onLoad }) {
  const iframeRef = useRef(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    if (!screenFolder) return;

    const loadScreen = async () => {
      setLoading(true);
      setError(null);

      try {
        // Fetch the HTML content
        const response = await fetch(
          `/src/stitch-screens/${screenFolder}/code.html`,
        );
        if (!response.ok) throw new Error("Screen not found");

        const html = await response.text();

        // Write to iframe
        const iframe = iframeRef.current;
        if (iframe) {
          const doc = iframe.contentDocument || iframe.contentWindow.document;
          doc.open();
          doc.write(html);
          doc.close();
        }

        setLoading(false);
        onLoad?.();
      } catch (err) {
        setError(err.message);
        setLoading(false);
      }
    };

    loadScreen();
  }, [screenFolder, onLoad]);

  return (
    <div className="stitch-viewer">
      {loading && (
        <div className="stitch-viewer__loading">
          <div className="stitch-viewer__spinner" />
          <p>Loading {screenFolder}...</p>
        </div>
      )}

      {error && (
        <div className="stitch-viewer__error">
          <p>Error: {error}</p>
        </div>
      )}

      <iframe
        ref={iframeRef}
        className="stitch-viewer__iframe"
        title={`Stitch Screen: ${screenFolder}`}
        sandbox="allow-same-origin allow-scripts"
      />
    </div>
  );
}

export default StitchViewer;
