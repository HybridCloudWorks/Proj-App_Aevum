/**
 * AI Restoration Screen
 *
 * Implements improved logic for cost-effective photo restoration:
 * - Before/After comparison slider
 * - Enhancement controls (Colorize, Sharpen, Repair)
 * - "Keep This?" confirmation flow to minimize storage costs
 * - Simulates moving original to "Cold Storage" upon confirmation
 */

import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import "./RestorationScreen.css";

function RestorationScreen() {
  const navigate = useNavigate();
  const [sliderPosition, setSliderPosition] = useState(50);
  const [isProcessing, setIsProcessing] = useState(false);
  const [showConfirmation, setShowConfirmation] = useState(false);

  // Toggle states
  const [colorize, setColorize] = useState(true);
  const [sharpen, setSharpen] = useState(true);
  const [repair, setRepair] = useState(false);

  const handleSliderChange = (e) => {
    setSliderPosition(e.target.value);
  };

  const handleProcess = () => {
    setIsProcessing(true);
    // Simulate AI processing time
    setTimeout(() => {
      setIsProcessing(false);
      setShowConfirmation(true);
    }, 2000);
  };

  const handleConfirmYes = () => {
    // Logic: Save restored as primary, move original to cold storage
    console.log(
      "Saving restored image. Moving original to Cold Storage (Archive).",
    );
    alert(
      "Enhancement Saved! The original has been moved to the Archive vault.",
    );
    navigate("/memories");
  };

  const handleConfirmNo = () => {
    // Logic: Discard result, original remains primary
    console.log("Discarding restoration result.");
    setShowConfirmation(false);
    alert("Restoration discarded. Original photo kept.");
  };

  return (
    <div className="bg-background-light dark:bg-background-dark text-slate-900 dark:text-white font-display overflow-x-hidden antialiased min-h-screen flex flex-col items-center">
      <div className="relative flex h-full min-h-screen w-full flex-col max-w-md mx-auto shadow-2xl bg-gray-50 dark:bg-[#0B1121]">
        {/* Header */}
        <div className="sticky top-0 z-40 bg-white/70 dark:bg-[#0B1121]/70 backdrop-blur-xl border-b border-white/20 dark:border-white/5 px-6 py-4 pt-12 flex items-center justify-between">
          <button
            onClick={() => navigate(-1)}
            className="flex size-10 items-center justify-center rounded-full hover:bg-black/5 dark:hover:bg-white/10 transition-colors"
          >
            <span className="material-symbols-outlined text-slate-900 dark:text-white">
              arrow_back_ios_new
            </span>
          </button>
          <div className="text-center">
            <h1 className="font-bold text-lg tracking-tight">Aevum</h1>
            <p className="text-[10px] font-medium text-slate-500 dark:text-slate-400 uppercase tracking-widest">
              AI Restoration
            </p>
          </div>
          <button className="flex size-10 items-center justify-center rounded-full hover:bg-black/5 dark:hover:bg-white/10 transition-colors">
            <span className="material-symbols-outlined text-slate-900 dark:text-white">
              ios_share
            </span>
          </button>
        </div>

        {/* Main Content */}
        <div className="flex-1 px-5 py-6 space-y-6 pb-32">
          {/* Before/After Container */}
          <div className="relative group">
            <div className="before-after-container shadow-2xl shadow-indigo-500/20 dark:shadow-indigo-900/20">
              <div
                className="before-image"
                style={{
                  backgroundImage:
                    "url('https://lh3.googleusercontent.com/aida-public/AB6AXuD6rLWYNqR4sQgKqUxA8itpYbWXVX2-AazxpOq2ruKAUHeE88QzbLzddOdrSSPueXXolY0mRc53w7JH1MHgnxowqUH38duGKayQBL3QGkFmy67PfrafwkAncBVgXFshhCrlV5O9l5XYFtSWDjvsZgOmDibOqOf9VfohVZPB8t3L1XsH0o7Gc8wHDiTMDJLR3Mkv8u1JKpekBv7hqaZN-XbkutgK1HMXkryD667osEYGmVBJUXNSmRkMazqU6vZYrXp21beGfnhnR_Q')",
                }}
              >
                <span className="absolute top-4 left-4 bg-black/60 backdrop-blur-md text-white px-3 py-1 rounded-full text-xs font-bold border border-white/10">
                  Before
                </span>
              </div>
              <div
                className="after-image"
                style={{
                  backgroundImage:
                    "url('https://lh3.googleusercontent.com/aida-public/AB6AXuD6rLWYNqR4sQgKqUxA8itpYbWXVX2-AazxpOq2ruKAUHeE88QzbLzddOdrSSPueXXolY0mRc53w7JH1MHgnxowqUH38duGKayQBL3QGkFmy67PfrafwkAncBVgXFshhCrlV5O9l5XYFtSWDjvsZgOmDibOqOf9VfohVZPB8t3L1XsH0o7Gc8wHDiTMDJLR3Mkv8u1JKpekBv7hqaZN-XbkutgK1HMXkryD667osEYGmVBJUXNSmRkMazqU6vZYrXp21beGfnhnR_Q')",
                  width: `${sliderPosition}%`,
                }}
              >
                <span className="absolute top-4 right-4 bg-indigo-600/90 backdrop-blur-md text-white px-3 py-1 rounded-full text-xs font-bold shadow-lg">
                  After
                </span>
              </div>

              {/* Slider Handle */}
              <div
                className="slider-handle"
                style={{ left: `${sliderPosition}%` }}
              >
                <div className="slider-button">
                  <span className="material-symbols-outlined text-xl">
                    compare_arrows
                  </span>
                </div>
              </div>

              {/* Range Input for Interaction */}
              <input
                type="range"
                min="0"
                max="100"
                value={sliderPosition}
                onChange={handleSliderChange}
                className="absolute inset-0 w-full h-full opacity-0 cursor-ew-resize z-30"
              />
            </div>

            <div className="flex justify-between mt-3 px-2">
              <p className="text-xs text-slate-500 dark:text-slate-400 font-medium">
                Original
              </p>
              <p className="text-xs font-bold text-indigo-500">
                Enhanced Result
              </p>
            </div>
          </div>

          {/* Controls Header */}
          <div className="flex items-center gap-2 mt-8">
            <span className="material-symbols-outlined text-indigo-500 text-xl">
              tune
            </span>
            <h2 className="text-lg font-bold text-slate-900 dark:text-white">
              Restoration Controls
            </h2>
          </div>

          {/* Controls Grid */}
          <div className="grid grid-cols-2 gap-4">
            {/* Colorize Card */}
            <div className="glass-card p-4 rounded-3xl flex flex-col justify-between h-40 relative overflow-hidden group">
              <div className="absolute inset-0 bg-gradient-to-br from-indigo-500/10 to-purple-500/10 dark:from-indigo-500/20 dark:to-purple-500/20 opacity-0 group-hover:opacity-100 transition-opacity"></div>
              <div className="relative z-10 flex justify-between items-start">
                <div className="p-2.5 rounded-xl bg-indigo-100 dark:bg-indigo-900/40 text-indigo-600 dark:text-indigo-400">
                  <span className="material-symbols-outlined text-2xl">
                    palette
                  </span>
                </div>
                <div className="relative inline-block w-10 mr-2 align-middle select-none transition duration-200 ease-in">
                  <input
                    checked={colorize}
                    onChange={() => setColorize(!colorize)}
                    className="toggle-checkbox absolute block w-5 h-5 rounded-full bg-white border-4 border-indigo-500 appearance-none cursor-pointer right-0"
                    id="toggle-colorize"
                    name="toggle"
                    type="checkbox"
                  />
                  <label
                    className="toggle-label block overflow-hidden h-5 rounded-full bg-indigo-500 cursor-pointer"
                    htmlFor="toggle-colorize"
                  ></label>
                </div>
              </div>
              <div className="relative z-10">
                <h3 className="font-bold text-slate-900 dark:text-white">
                  Colorize
                </h3>
                <p className="text-[11px] text-slate-500 dark:text-slate-400 leading-tight mt-1">
                  Add natural colors to B&W photos
                </p>
              </div>
            </div>

            {/* Sharpen Card */}
            <div className="glass-card p-4 rounded-3xl flex flex-col justify-between h-40 relative overflow-hidden group">
              <div className="absolute inset-0 bg-gradient-to-br from-blue-500/10 to-cyan-500/10 dark:from-blue-500/20 dark:to-cyan-500/20 opacity-0 group-hover:opacity-100 transition-opacity"></div>
              <div className="relative z-10 flex justify-between items-start">
                <div className="p-2.5 rounded-xl bg-blue-100 dark:bg-blue-900/40 text-blue-600 dark:text-blue-400">
                  <span className="material-symbols-outlined text-2xl">
                    shutter_speed
                  </span>
                </div>
                <div className="relative inline-block w-10 mr-2 align-middle select-none transition duration-200 ease-in">
                  <input
                    checked={sharpen}
                    onChange={() => setSharpen(!sharpen)}
                    className="toggle-checkbox absolute block w-5 h-5 rounded-full bg-white border-4 border-blue-500 appearance-none cursor-pointer right-0"
                    id="toggle-sharpen"
                    name="toggle"
                    type="checkbox"
                  />
                  <label
                    className="toggle-label block overflow-hidden h-5 rounded-full bg-blue-500 cursor-pointer"
                    htmlFor="toggle-sharpen"
                  ></label>
                </div>
              </div>
              <div className="relative z-10">
                <h3 className="font-bold text-slate-900 dark:text-white">
                  Sharpen
                </h3>
                <p className="text-[11px] text-slate-500 dark:text-slate-400 leading-tight mt-1">
                  Enhance details and remove blur
                </p>
              </div>
            </div>

            {/* Repair Scratches Card (Full Width) */}
            <div className="col-span-2 glass-card p-4 rounded-3xl flex items-center justify-between relative overflow-hidden group">
              <div className="absolute inset-0 bg-gradient-to-r from-emerald-500/10 to-teal-500/10 dark:from-emerald-500/20 dark:to-teal-500/20 opacity-0 group-hover:opacity-100 transition-opacity"></div>
              <div className="flex items-center gap-4 relative z-10">
                <div className="p-2.5 rounded-xl bg-emerald-100 dark:bg-emerald-900/40 text-emerald-600 dark:text-emerald-400">
                  <span className="material-symbols-outlined text-2xl">
                    healing
                  </span>
                </div>
                <div>
                  <h3 className="font-bold text-slate-900 dark:text-white">
                    Repair Scratches
                  </h3>
                  <p className="text-[11px] text-slate-500 dark:text-slate-400">
                    Fix tears, dust and damage
                  </p>
                </div>
              </div>
              <div className="relative inline-block w-12 mr-2 align-middle select-none transition duration-200 ease-in z-10">
                <input
                  checked={repair}
                  onChange={() => setRepair(!repair)}
                  className={`toggle-checkbox absolute block w-6 h-6 rounded-full bg-white border-4 appearance-none cursor-pointer ${repair ? "right-0 border-emerald-500" : "left-0 border-gray-300"}`}
                  id="toggle-repair"
                  name="toggle"
                  type="checkbox"
                />
                <label
                  className={`toggle-label block overflow-hidden h-6 rounded-full cursor-pointer ${repair ? "bg-emerald-500" : "bg-gray-300"}`}
                  htmlFor="toggle-repair"
                ></label>
              </div>
            </div>
          </div>

          {/* Action Button */}
          <button
            onClick={handleProcess}
            disabled={isProcessing}
            className="w-full mt-6 bg-slate-900 dark:bg-white text-white dark:text-slate-900 py-4 px-6 rounded-2xl font-bold shadow-lg shadow-indigo-500/20 active:scale-[0.98] transition-all flex items-center justify-center gap-3 group disabled:opacity-70 disabled:cursor-not-allowed"
          >
            {isProcessing ? (
              <span
                className="material-symbols-outlined animate-spin"
                style={{ fontSize: "20px" }}
              >
                sync
              </span>
            ) : (
              <span
                className="group-hover:hidden material-symbols-outlined"
                style={{ fontSize: "20px" }}
              >
                download
              </span>
            )}
            <span>{isProcessing ? "Enhancing..." : "Save Enhanced Photo"}</span>
          </button>
        </div>

        {/* Floating Confirmation Modal */}
        {showConfirmation && (
          <div className="fixed inset-0 z-50 flex items-center justify-center px-4 bg-black/60 backdrop-blur-sm animate-in fade-in duration-200">
            <div className="bg-white dark:bg-slate-900 rounded-3xl p-6 shadow-2xl max-w-sm w-full border border-white/20">
              <div className="w-12 h-12 rounded-full bg-indigo-100 dark:bg-indigo-900/30 flex items-center justify-center text-indigo-600 dark:text-indigo-400 mb-4 mx-auto">
                <span className="material-symbols-outlined text-2xl">save</span>
              </div>
              <h3 className="text-xl font-bold text-center text-slate-900 dark:text-white mb-2">
                Keep Restoration?
              </h3>
              <p className="text-sm text-center text-slate-500 dark:text-slate-400 mb-6 px-2">
                If you save this version, the original will be moved to{" "}
                <span className="text-indigo-500 font-bold">
                  Cold Storage (Archive)
                </span>{" "}
                to save detailed history.
              </p>
              <div className="grid grid-cols-2 gap-3">
                <button
                  onClick={handleConfirmNo}
                  className="py-3 px-4 rounded-xl font-bold text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors"
                >
                  Discard
                </button>
                <button
                  onClick={handleConfirmYes}
                  className="py-3 px-4 rounded-xl font-bold bg-indigo-600 text-white shadow-lg shadow-indigo-500/30 hover:bg-indigo-700 transition-colors"
                >
                  Yes, Save
                </button>
              </div>
            </div>
          </div>
        )}

        {/* Custom Bottom Nav */}
        <div className="fixed bottom-0 w-full max-w-md pb-safe z-30 pointer-events-none">
          <div className="mx-4 mb-4 rounded-3xl glass-panel shadow-2xl backdrop-blur-xl bg-white/80 dark:bg-slate-900/80 border border-white/40 dark:border-white/10 pointer-events-auto">
            <div className="flex justify-around items-center h-16 px-2">
              <Link
                to="/memories"
                className="flex flex-col items-center gap-1 w-14 text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors"
              >
                <span
                  className="material-symbols-outlined"
                  style={{ fontSize: "22px" }}
                >
                  photo_library
                </span>
              </Link>
              <Link
                to="/family-tree"
                className="flex flex-col items-center gap-1 w-14 text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors"
              >
                <span
                  className="material-symbols-outlined"
                  style={{ fontSize: "22px" }}
                >
                  account_tree
                </span>
              </Link>
              <button className="flex flex-col items-center gap-1 w-14 group">
                <div className="p-1.5 rounded-xl bg-indigo-100 dark:bg-indigo-500/20 text-indigo-600 dark:text-indigo-400 shadow-sm ring-1 ring-indigo-500/20">
                  <span
                    className="material-symbols-outlined filled"
                    style={{ fontSize: "24px" }}
                  >
                    auto_fix_high
                  </span>
                </div>
              </button>
              <Link
                to="/settings"
                className="flex flex-col items-center gap-1 w-14 text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors"
              >
                <span
                  className="material-symbols-outlined"
                  style={{ fontSize: "22px" }}
                >
                  person
                </span>
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default RestorationScreen;
