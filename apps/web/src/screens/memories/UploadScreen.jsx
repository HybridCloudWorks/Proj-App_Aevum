/**
 * Upload Screen
 *
 * Converted from Stitch: aevum_global_heritage_map_1/code.html
 * Photo upload with AI processing and family branch selection.
 */

import { useState, useRef } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import { uploadPhoto } from "@lib/storage";

function UploadScreen() {
  const navigate = useNavigate();
  const { user } = useAuth();
  const fileInputRef = useRef(null);
  const [files, setFiles] = useState([]);
  const [processing, setProcessing] = useState([]);
  const [selectedBranch, setSelectedBranch] = useState("ricci");

  const handleFileSelect = (e) => {
    const selectedFiles = Array.from(e.target.files);
    setFiles((prev) => [...prev, ...selectedFiles]);

    // Start processing simulation
    selectedFiles.forEach((file, i) => {
      setProcessing((prev) => [...prev, { file: file.name, progress: 0 }]);
      simulateProcessing(file.name);
    });
  };

  const simulateProcessing = (fileName) => {
    let progress = 0;
    const interval = setInterval(() => {
      progress += Math.random() * 15;
      if (progress >= 100) {
        progress = 100;
        clearInterval(interval);

        // Simulate a random conflict detection (e.g. 30% chance)
        if (Math.random() < 0.3) {
          setTimeout(() => {
            alert(
              "Duplicate file detected! Redirecting to conflict resolver...",
            );
            navigate("/upload/conflict", {
              state: {
                fileName: fileName,
                conflictTime: "Just now",
              },
            });
          }, 500);
        }
      }
      setProcessing((prev) =>
        prev.map((p) => (p.file === fileName ? { ...p, progress } : p)),
      );
    }, 500);
  };

  const handleDrop = (e) => {
    e.preventDefault();
    const droppedFiles = Array.from(e.dataTransfer.files);
    setFiles((prev) => [...prev, ...droppedFiles]);
  };

  const handleDragOver = (e) => {
    e.preventDefault();
  };

  return (
    <div className="font-display bg-background-dark text-white overflow-hidden h-screen w-full relative mesh-bg">
      {/* Header */}
      <header className="pt-12 px-6 pb-4 flex justify-between items-center z-20 relative">
        <div>
          <h1 className="text-2xl font-bold tracking-tight text-white">
            Upload Center
          </h1>
          <p className="text-sm text-gray-300 font-medium">
            Digitize your legacy
          </p>
        </div>
        <div className="glass-panel p-2 rounded-full relative cursor-pointer hover:bg-white/10 transition-colors">
          <span className="material-symbols-outlined text-gray-200">
            history
          </span>
        </div>
      </header>

      {/* Main Content */}
      <main className="flex-1 overflow-y-auto px-6 pb-24 scrollbar-hide z-10 relative h-[calc(100vh-160px)]">
        {/* Upload Area */}
        <section className="mb-8">
          <div
            className="h-48 rounded-2xl flex flex-col items-center justify-center cursor-pointer group hover:bg-white/5 glass-panel border-2 border-dashed border-white/20 hover:border-primary/50 transition-all"
            onClick={() => fileInputRef.current?.click()}
            onDrop={handleDrop}
            onDragOver={handleDragOver}
          >
            <div className="w-14 h-14 rounded-full bg-glass-panel flex items-center justify-center mb-3 group-hover:scale-110 transition-transform duration-300 border border-white/10 shadow-lg">
              <span className="material-symbols-outlined text-primary text-3xl">
                cloud_upload
              </span>
            </div>
            <h3 className="text-base font-bold text-white mb-1">
              Upload Photos
            </h3>
            <p className="text-xs text-gray-400 text-center max-w-[200px]">
              Drag & drop or tap to select from your gallery
            </p>
          </div>
          <input
            ref={fileInputRef}
            type="file"
            accept="image/*"
            multiple
            onChange={handleFileSelect}
            className="hidden"
          />
        </section>

        {/* AI Processing Section */}
        <section className="mb-8">
          <div className="flex justify-between items-center mb-3">
            <h3 className="text-sm font-bold text-gray-200 uppercase tracking-wider flex items-center gap-2">
              <span className="w-2 h-2 rounded-full bg-primary animate-pulse" />
              AI Processing
            </h3>
            <span className="text-xs text-primary font-semibold">
              {processing.filter((p) => p.progress < 100).length} items
              remaining
            </span>
          </div>

          <div className="grid grid-cols-2 gap-3">
            {/* Active Processing Item */}
            {processing.length > 0 && processing[0].progress < 100 && (
              <div className="col-span-2 glass-panel-active rounded-2xl p-4 flex items-center gap-4 relative overflow-hidden">
                <div className="w-16 h-16 rounded-xl overflow-hidden shrink-0 border border-primary/30 relative">
                  <div className="absolute inset-0 bg-primary/20" />
                  <div className="absolute top-0 left-0 w-full h-[2px] bg-primary shadow-[0_0_10px_#0ea5e9] animate-scan" />
                  <div className="w-full h-full bg-slate-700 flex items-center justify-center">
                    <span className="material-symbols-outlined text-slate-400">
                      image
                    </span>
                  </div>
                </div>
                <div className="flex-1">
                  <div className="flex justify-between mb-1">
                    <h4 className="font-bold text-white text-sm">
                      Scanning in Progress
                    </h4>
                    <span className="text-xs text-primary font-mono">
                      {Math.round(processing[0].progress)}%
                    </span>
                  </div>
                  <div className="w-full bg-gray-700/50 rounded-full h-1.5 mb-2 overflow-hidden">
                    <div
                      className="bg-primary h-1.5 rounded-full shadow-[0_0_10px_rgba(14,165,233,0.5)] transition-all"
                      style={{ width: `${processing[0].progress}%` }}
                    />
                  </div>
                  <p className="text-[10px] text-gray-300">
                    Analyzing pixel density & color grading...
                  </p>
                </div>
              </div>
            )}

            {/* Metadata Card */}
            <div className="glass-panel rounded-2xl p-4 flex flex-col justify-between h-32 relative group hover:bg-white/5 transition-colors">
              <div className="w-8 h-8 rounded-lg bg-indigo-500/20 flex items-center justify-center text-indigo-400 border border-indigo-500/30">
                <span className="material-symbols-outlined text-lg">
                  data_object
                </span>
              </div>
              <div>
                <div className="flex items-center gap-2 mb-1">
                  <span className="material-symbols-outlined text-green-500 text-sm">
                    check_circle
                  </span>
                  <h4 className="font-bold text-gray-200 text-xs">Metadata</h4>
                </div>
                <p className="text-[10px] text-gray-400 leading-tight">
                  Date: 1984-05-12
                  <br />
                  Loc: Tuscany, IT
                </p>
              </div>
            </div>

            {/* Face ID Card */}
            <div className="glass-panel rounded-2xl p-4 flex flex-col justify-between h-32 relative group hover:bg-white/5 transition-colors">
              <div className="w-8 h-8 rounded-lg bg-pink-500/20 flex items-center justify-center text-pink-400 border border-pink-500/30">
                <span className="material-symbols-outlined text-lg">
                  face_retouching_natural
                </span>
              </div>
              <div>
                <div className="flex items-center gap-2 mb-1">
                  <div className="w-3 h-3 border-2 border-t-pink-500 border-r-pink-500 border-b-transparent border-l-transparent rounded-full animate-spin" />
                  <h4 className="font-bold text-gray-200 text-xs">Face ID</h4>
                </div>
                <div className="flex -space-x-2 mt-1">
                  <div className="w-5 h-5 rounded-full bg-slate-600 border border-gray-800" />
                  <div className="w-5 h-5 rounded-full bg-gray-700 border border-gray-800 flex items-center justify-center text-[8px] text-gray-300">
                    +2
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Target Branch Section */}
        <section className="mb-24">
          <h3 className="text-sm font-bold text-gray-200 uppercase tracking-wider mb-3">
            Target Branch
          </h3>
          <div className="glass-panel rounded-2xl p-1 flex items-center relative">
            <div className="w-full grid grid-cols-1 gap-1">
              <BranchOption
                letter="R"
                name="Ricci Branch"
                subtitle="Primary Lineage"
                gradient="from-indigo-500 to-primary"
                selected={selectedBranch === "ricci"}
                onClick={() => setSelectedBranch("ricci")}
              />
              <BranchOption
                letter="S"
                name="Smith Branch"
                subtitle="Maternal Side"
                gradient="from-emerald-500 to-teal-600"
                selected={selectedBranch === "smith"}
                onClick={() => setSelectedBranch("smith")}
              />
            </div>
          </div>
        </section>
      </main>

      {/* Floating Action Button */}
      <div className="fixed bottom-24 right-6 z-30">
        <button className="bg-gradient-to-r from-primary to-blue-400 hover:from-blue-600 hover:to-blue-500 text-white rounded-full p-4 flex items-center gap-2 transition-all hover:scale-105 active:scale-95 border border-white/20 shadow-[0_0_20px_rgba(14,165,233,0.3)]">
          <span className="material-symbols-outlined">auto_fix_high</span>
          <span className="text-sm font-bold pr-1">Start Processing</span>
        </button>
      </div>

      {/* Bottom Navigation */}
      <nav className="fixed bottom-0 w-full border-t border-white/10 px-6 py-4 flex justify-between items-center bg-[#101922]/90 backdrop-blur-xl z-50">
        <Link
          to="/dashboard"
          className="flex flex-col items-center gap-1 text-gray-400 hover:text-white transition-colors group"
        >
          <span className="material-symbols-outlined text-2xl group-hover:-translate-y-0.5 transition-transform">
            home
          </span>
          <span className="text-[10px] font-medium">Home</span>
        </Link>
        <Link
          to="/messages"
          className="flex flex-col items-center gap-1 text-gray-400 hover:text-white transition-colors group"
        >
          <span className="material-symbols-outlined text-2xl group-hover:-translate-y-0.5 transition-transform">
            chat_bubble
          </span>
          <span className="text-[10px] font-medium">Messages</span>
        </Link>
        <button className="relative flex flex-col items-center gap-1 text-white transition-colors">
          <div className="absolute -top-3 w-8 h-1 bg-primary rounded-full shadow-[0_0_10px_rgba(17,115,212,0.8)]" />
          <span className="material-symbols-outlined text-2xl fill-current text-primary">
            add_circle
          </span>
          <span className="text-[10px] font-medium text-primary">Upload</span>
        </button>
        <Link
          to="/vault"
          className="flex flex-col items-center gap-1 text-gray-400 hover:text-white transition-colors group"
        >
          <span className="material-symbols-outlined text-2xl group-hover:-translate-y-0.5 transition-transform">
            folder_open
          </span>
          <span className="text-[10px] font-medium">Vault</span>
        </Link>
        <Link
          to="/settings"
          className="flex flex-col items-center gap-1 text-gray-400 hover:text-white transition-colors group"
        >
          <span className="material-symbols-outlined text-2xl group-hover:-translate-y-0.5 transition-transform">
            settings
          </span>
          <span className="text-[10px] font-medium">Config</span>
        </Link>
      </nav>

      <style>{`
        @keyframes scan {
          0% {
            top: 0%;
            opacity: 0;
          }
          10% {
            opacity: 1;
          }
          90% {
            opacity: 1;
          }
          100% {
            top: 100%;
            opacity: 0;
          }
        }
        .animate-scan {
          animation: scan 2s linear infinite;
        }
        .mesh-bg {
          background-color: #0f172a;
          background-image:
            radial-gradient(at 0% 0%, hsla(253, 16%, 7%, 1) 0, transparent 50%),
            radial-gradient(
              at 50% 0%,
              hsla(225, 39%, 30%, 1) 0,
              transparent 50%
            ),
            radial-gradient(
              at 100% 0%,
              hsla(339, 49%, 30%, 1) 0,
              transparent 50%
            );
        }
        .glass-panel-active {
          background: linear-gradient(
            145deg,
            rgba(17, 115, 212, 0.25) 0%,
            rgba(14, 165, 233, 0.15) 100%
          );
          backdrop-filter: blur(24px);
          border: 1px solid rgba(17, 115, 212, 0.4);
          box-shadow: 0 0 15px rgba(17, 115, 212, 0.2);
        }
      `}</style>
    </div>
  );
}

// Branch Option Component
function BranchOption({ letter, name, subtitle, gradient, selected, onClick }) {
  return (
    <div
      className={`flex items-center justify-between p-3 rounded-xl cursor-pointer transition-colors ${selected ? "bg-white/10 border border-white/5" : "hover:bg-white/5"}`}
      onClick={onClick}
    >
      <div className="flex items-center gap-3">
        <div
          className={`w-10 h-10 rounded-lg bg-gradient-to-br ${gradient} flex items-center justify-center text-white font-bold shadow-lg ${!selected ? "opacity-70" : ""}`}
        >
          {letter}
        </div>
        <div>
          <h4
            className={`font-bold text-sm ${selected ? "text-white" : "text-gray-300"}`}
          >
            {name}
          </h4>
          <p
            className={`text-[10px] ${selected ? "text-gray-400" : "text-gray-500"}`}
          >
            {subtitle}
          </p>
        </div>
      </div>
      <span
        className={`material-symbols-outlined ${selected ? "text-primary" : "text-gray-600"}`}
      >
        {selected ? "radio_button_checked" : "radio_button_unchecked"}
      </span>
    </div>
  );
}

export default UploadScreen;
