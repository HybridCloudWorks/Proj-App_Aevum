/**
 * File Conflict Resolution Screen
 *
 * Handles detection and resolution of duplicate or conflicting file uploads.
 *
 * Implements logic:
 * - Detects sync conflict (Version A vs Version B)
 * - Allows user to select one version to keep
 * - Moves replaced file to "Archive" (simulated Cold Storage)
 */

import { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import "./FileConflictScreen.css";

function FileConflictScreen() {
  const navigate = useNavigate();
  const location = useLocation();
  const [selectedVersion, setSelectedVersion] = useState("version_b");

  // Simulated data (would come from location state or API)
  const conflictData = {
    fileName: "family_pic_1984.jpg",
    conflictTime: "12m ago",
    existingFile: {
      id: "version_a",
      uploader: "John Doe",
      time: "10:42 AM",
      date: "1924-04-12",
      place: "Liverpool, UK",
      note: "Updated birth records from parish register found in attic.",
      avatar: "JD",
      avatarColor: "from-blue-500 to-indigo-600",
      status: "Existing Record",
    },
    newFile: {
      id: "version_b",
      uploader: "Sarah Miller",
      time: "10:45 AM",
      date: "1924-04-14",
      place: "Liverpool, UK",
      note: "Corrected date based on birth certificate scan.",
      avatar: "SM",
      avatarColor: "from-purple-500 to-pink-600",
      status: "New Upload",
    },
  };

  const handleResolve = () => {
    if (selectedVersion === "version_b") {
      // Keep New Upload
      alert(
        `Conflict Resolved! New version kept. The existing file has been moved to the 'Replaced' archive.`,
      );
    } else {
      // Keep Existing
      alert(
        `Conflict Resolved! Existing version kept. The uploaded file has been discarded.`,
      );
    }

    // Navigate back to upload or dashboard
    navigate("/memories/upload");
  };

  const handleManualEdit = () => {
    alert("Manual edit mode not implemented in this demo.");
  };

  return (
    <div className="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-white antialiased selection:bg-primary selection:text-white min-h-screen flex flex-col">
      <div className="ambient-glow"></div>

      {/* Header */}
      <header className="sticky top-0 z-50 flex items-center justify-between p-5 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-xl border-b border-white/5">
        <div className="flex items-center gap-3">
          <div className="flex items-center justify-center size-10 rounded-xl bg-gradient-to-br from-red-500/20 to-purple-500/20 text-red-500 border border-white/5">
            <span className="material-symbols-outlined text-[24px]">
              sync_problem
            </span>
          </div>
          <div>
            <h1 className="text-lg font-bold leading-tight tracking-tight">
              Sync Conflict
            </h1>
            <div className="flex items-center gap-1.5">
              <span className="text-xs font-medium text-slate-500 dark:text-slate-400">
                {conflictData.fileName}
              </span>
              <span className="size-1 rounded-full bg-slate-600"></span>
              <span className="text-xs font-medium text-red-500">
                2 versions found
              </span>
            </div>
          </div>
        </div>
        <button
          onClick={() => navigate(-1)}
          className="flex items-center justify-center size-8 rounded-full bg-white/5 hover:bg-white/10 text-slate-400 transition-colors"
        >
          <span className="material-symbols-outlined text-[20px]">close</span>
        </button>
      </header>

      {/* Main Content */}
      <main className="flex-1 p-5 flex flex-col gap-6 w-full max-w-md mx-auto relative z-10 pb-32">
        <section className="text-center mb-2">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full glass-badge text-xs font-medium text-slate-300 mb-3">
            <span className="material-symbols-outlined text-[16px] text-accent">
              history
            </span>
            Conflict detected {conflictData.conflictTime}
          </div>
          <h2 className="text-2xl font-bold mb-2 bg-gradient-to-r from-white to-slate-400 bg-clip-text text-transparent">
            Resolve Data Mismatch
          </h2>
          <p className="text-sm text-slate-400 leading-relaxed">
            A file with this name already exists. Please select which version to
            correct.
          </p>
        </section>

        <form className="flex flex-col gap-4">
          {/* Version A (Existing) */}
          <label className="relative cursor-pointer group">
            <input
              className="peer sr-only"
              name="conflict_resolution"
              type="radio"
              value="version_a"
              checked={selectedVersion === "version_a"}
              onChange={() => setSelectedVersion("version_a")}
            />
            <div
              className={`glass-card p-5 rounded-2xl border border-white/10 transition-all duration-300 hover:bg-white/5 relative overflow-hidden ${selectedVersion === "version_a" ? "glass-card-selected" : ""}`}
            >
              <div
                className={`absolute top-0 right-0 p-3 transition-opacity ${selectedVersion === "version_a" ? "opacity-100" : "opacity-0"}`}
              >
                <div className="bg-emerald-500 text-white rounded-full p-1 shadow-lg shadow-emerald-500/20">
                  <span className="material-symbols-outlined text-[20px]">
                    check
                  </span>
                </div>
              </div>
              <div className="flex flex-col gap-4">
                <div className="flex items-center justify-between border-b border-white/5 pb-3">
                  <div className="flex items-center gap-3">
                    <div
                      className={`size-8 rounded-full bg-gradient-to-br ${conflictData.existingFile.avatarColor} flex items-center justify-center text-xs font-bold text-white shadow-lg`}
                    >
                      {conflictData.existingFile.avatar}
                    </div>
                    <div>
                      <div className="text-xs text-slate-400 font-medium">
                        Original Uploader
                      </div>
                      <div className="text-sm font-bold text-white">
                        {conflictData.existingFile.uploader}
                      </div>
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="text-xs text-slate-400 font-medium">
                      Uploaded
                    </div>
                    <div className="text-sm font-bold text-white">
                      {conflictData.existingFile.time}
                    </div>
                  </div>
                </div>
                <div className="space-y-3">
                  <div className="flex justify-between items-center group/field">
                    <span className="text-xs uppercase tracking-wider text-slate-500 font-bold">
                      Date
                    </span>
                    <span className="text-sm font-mono bg-white/5 px-2 py-1 rounded text-slate-300 group-hover/field:bg-white/10 transition-colors">
                      {conflictData.existingFile.date}
                    </span>
                  </div>
                  <div className="flex justify-between items-center group/field">
                    <span className="text-xs uppercase tracking-wider text-slate-500 font-bold">
                      Location
                    </span>
                    <span className="text-sm font-mono bg-white/5 px-2 py-1 rounded text-slate-300 group-hover/field:bg-white/10 transition-colors">
                      {conflictData.existingFile.place}
                    </span>
                  </div>
                  <div className="mt-2 bg-white/5 rounded-lg p-3 border border-white/5">
                    <div className="text-xs text-slate-500 mb-1 font-medium">
                      Status
                    </div>
                    <p className="text-sm text-slate-300 italic">
                      {conflictData.existingFile.status}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </label>

          {/* Version B (New Upload) */}
          <label className="relative cursor-pointer group">
            <input
              className="peer sr-only"
              name="conflict_resolution"
              type="radio"
              value="version_b"
              checked={selectedVersion === "version_b"}
              onChange={() => setSelectedVersion("version_b")}
            />
            <div
              className={`glass-card p-5 rounded-2xl border border-white/10 transition-all duration-300 hover:bg-white/5 relative overflow-hidden ${selectedVersion === "version_b" ? "glass-card-selected" : ""}`}
            >
              <div
                className={`absolute top-0 right-0 p-3 transition-opacity ${selectedVersion === "version_b" ? "opacity-100" : "opacity-0"}`}
              >
                <div className="bg-emerald-500 text-white rounded-full p-1 shadow-lg shadow-emerald-500/20">
                  <span className="material-symbols-outlined text-[20px]">
                    check
                  </span>
                </div>
              </div>
              <div className="flex flex-col gap-4">
                <div className="flex items-center justify-between border-b border-white/5 pb-3">
                  <div className="flex items-center gap-3">
                    <div
                      className={`size-8 rounded-full bg-gradient-to-br ${conflictData.newFile.avatarColor} flex items-center justify-center text-xs font-bold text-white shadow-lg`}
                    >
                      {conflictData.newFile.avatar}
                    </div>
                    <div>
                      <div className="text-xs text-slate-400 font-medium">
                        New Uploader
                      </div>
                      <div className="text-sm font-bold text-white">
                        {conflictData.newFile.uploader}
                      </div>
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="text-xs text-slate-400 font-medium">
                      Uploaded
                    </div>
                    <div className="text-sm font-bold text-white">
                      {conflictData.newFile.time}
                    </div>
                  </div>
                </div>
                <div className="space-y-3">
                  <div className="flex justify-between items-center group/field">
                    <span className="text-xs uppercase tracking-wider text-slate-500 font-bold">
                      Date
                    </span>
                    <span className="text-sm font-mono diff-highlight-new border border-emerald-500/30">
                      {conflictData.newFile.date}
                    </span>
                  </div>
                  <div className="flex justify-between items-center group/field">
                    <span className="text-xs uppercase tracking-wider text-slate-500 font-bold">
                      Location
                    </span>
                    <span className="text-sm font-mono bg-white/5 px-2 py-1 rounded text-slate-300 group-hover/field:bg-white/10 transition-colors">
                      {conflictData.newFile.place}
                    </span>
                  </div>
                  <div className="mt-2 bg-white/5 rounded-lg p-3 border border-white/5">
                    <div className="text-xs text-slate-500 mb-1 font-medium">
                      Status
                    </div>
                    <p className="text-sm text-slate-300 italic">
                      {conflictData.newFile.status}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </label>
        </form>
      </main>

      {/* Floating Action Bar */}
      <div className="fixed bottom-0 left-0 w-full p-5 bg-gradient-to-t from-background-dark via-background-dark/95 to-transparent z-20">
        <div className="max-w-md mx-auto flex flex-col gap-3">
          <button
            onClick={handleManualEdit}
            className="w-full bg-white/5 hover:bg-white/10 text-slate-300 font-medium py-3.5 rounded-xl transition-all border border-white/10 flex items-center justify-center gap-2"
          >
            <span className="material-symbols-outlined">edit</span>
            <span>Manually Edit</span>
          </button>
          <button
            onClick={handleResolve}
            className="w-full bg-emerald-500 hover:bg-emerald-600 text-white font-bold py-3.5 rounded-xl transition-all shadow-[0_0_20px_rgba(16,185,129,0.3)] flex items-center justify-center gap-2 group"
          >
            <span className="material-symbols-outlined">call_merge</span>
            <span>Confirm Selection</span>
          </button>
        </div>
      </div>
    </div>
  );
}

export default FileConflictScreen;
