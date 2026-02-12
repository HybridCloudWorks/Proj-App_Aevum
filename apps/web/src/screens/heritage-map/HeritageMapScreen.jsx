/**
 * Aevum Global Heritage Map Screen
 *
 * Migrated from Stitch screen: 732382af817245b4a058aeb99c40d215
 * Displays family heritage locations on an interactive stylized map.
 */

import { useState } from "react";
import { useNavigate } from "react-router-dom";
import "./HeritageMapScreen.css";

function HeritageMapScreen() {
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState("Ancestral Roots");
  const [selectedRegion, setSelectedRegion] = useState({
    name: "London, United Kingdom",
    period: "Origin Region • 1820 - 1945",
    memories: 14,
    latestStory: "The Miller Arrival",
    stats: "Traced back to 1824 immigration records.",
  });

  return (
    <div className="heritage-map-container">
      {/* Background Map Canvas Placeholder */}
      <div className="map-canvas">
        <div className="map-grid"></div>

        {/* Interactive Pins */}
        <div
          className="heritage-pin"
          style={{ top: "30%", left: "45%" }}
          onClick={() =>
            setSelectedRegion({
              name: "London, UK",
              period: "Origin Region • 1820 - 1945",
              memories: 14,
              latestStory: "The Miller Arrival",
              stats: "6 Generations traced here.",
            })
          }
        >
          <div className="pulse"></div>
          <img
            src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100"
            alt="Pin"
          />
        </div>

        <div
          className="heritage-pin"
          style={{ top: "55%", left: "25%" }}
          onClick={() =>
            setSelectedRegion({
              name: "New York, USA",
              period: "Immigration Hub • 1910 - 1950",
              memories: 8,
              latestStory: "Ellis Island Days",
              stats: "First arrival in the Americas.",
            })
          }
        >
          <div className="pulse"></div>
          <img
            src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100"
            alt="Pin"
          />
        </div>

        <div
          className="heritage-pin"
          style={{ top: "45%", left: "70%" }}
          onClick={() =>
            setSelectedRegion({
              name: "Naples, Italy",
              period: "Maternal Roots • 1750 - 1900",
              memories: 24,
              latestStory: "The Ricci Vineyard",
              stats: "Largest cluster of vintage photos.",
            })
          }
        >
          <div className="pulse"></div>
          <img
            src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100"
            alt="Pin"
          />
        </div>
      </div>

      {/* Top Navigation UI */}
      <div className="map-top-nav fixed top-12 left-0 right-0 px-6 flex flex-col items-center gap-6 z-20">
        <div className="glass-ui-header px-4 py-2 flex items-center gap-4 w-full justify-between">
          <button
            onClick={() => navigate(-1)}
            className="p-2 rounded-full hover:bg-white/5 text-white"
          >
            <svg
              className="w-6 h-6"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path strokeWidth="2" d="M15 19l-7-7 7-7" />
            </svg>
          </button>
          <h1 className="text-sm font-bold uppercase tracking-widest text-white/80">
            Global Heritage Map
          </h1>
          <div className="w-10"></div>
        </div>

        <div className="pill-toggle flex gap-1 glass-ui-pill p-1">
          <button
            onClick={() => setActiveTab("Ancestral Roots")}
            className={`pill-item ${activeTab === "Ancestral Roots" ? "pill-active" : "text-white/50"}`}
          >
            Ancestral Roots
          </button>
          <button
            onClick={() => setActiveTab("Family Travels")}
            className={`pill-item ${activeTab === "Family Travels" ? "pill-active" : "text-white/50"}`}
          >
            Family Travels
          </button>
        </div>
      </div>

      {/* Bottom Sheet Bento */}
      <div className="map-bottom-sheet glass-ui-sheet p-6">
        <div className="flex items-center justify-between mb-6">
          <div className="text-left">
            <h2 className="text-xl font-extrabold tracking-tight text-white">
              {selectedRegion.name}
            </h2>
            <p className="text-xs text-indigo-400 font-bold uppercase tracking-tighter">
              {selectedRegion.period}
            </p>
          </div>
          <div className="text-right">
            <span className="text-2xl font-black text-white">
              {selectedRegion.memories}
            </span>
            <p className="text-[10px] text-white/30 font-bold uppercase">
              Memories
            </p>
          </div>
        </div>

        <div className="grid grid-cols-2 gap-4 h-24">
          <div className="bg-white/5 rounded-2xl p-3 border border-white/5 flex gap-3 items-center">
            <img
              src="https://images.unsplash.com/photo-1542037104857-ffbb0b9155fb?w=100&h=100&fit=crop"
              className="w-16 h-16 rounded-xl object-cover"
              alt="Thumb"
            />
            <div className="text-left">
              <p className="text-[10px] font-bold text-white/40">
                Latest Story
              </p>
              <p className="text-xs font-semibold leading-tight text-white">
                {selectedRegion.latestStory}
              </p>
            </div>
          </div>
          <div className="bg-white/5 rounded-2xl p-3 border border-white/5 flex flex-col justify-center text-left">
            <div className="flex items-center gap-2 mb-1">
              <div className="w-2 h-2 rounded-full bg-indigo-500"></div>
              <span className="text-xs font-bold text-white/80">
                Region Stats
              </span>
            </div>
            <p className="text-[10px] text-white/40 leading-tight">
              {selectedRegion.stats}
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}

export default HeritageMapScreen;
