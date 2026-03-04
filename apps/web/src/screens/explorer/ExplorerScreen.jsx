import { useState } from "react";
import { useNavigate } from "react-router-dom";
import "./ExplorerScreen.css";
// import BottomNav from "../../components/BottomNav"; // Assuming we might want to use the app's standard bottom nav, but the design shows a specific one.

/**
 * Aevum - Global Heritage Search
 * Frame 1: Explorer / Search Screen
 */

// ⚡ Bolt Optimization: Define eras outside component to prevent recreation on every render
const eras = ["1700s", "1800s", "1900s", "2000s"];

function ExplorerScreen() {
  const navigate = useNavigate();
  const [activeEra, setActiveEra] = useState("1800s");
  const [searchQuery, setSearchQuery] = useState("");

  const handleResultClick = (id) => {
    // Navigate to a detail view or story
    // For demo purposes, if it's the AI Story card, go to story view
    if (id === "story-1") {
      navigate("/story/sample-id");
    }
  };

  return (
    <div className="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-white antialiased min-h-screen selection:bg-primary selection:text-white pb-24 relative overflow-x-hidden">
      {/* Background Ambient Glow */}
      <div className="explorer-bg-glow"></div>

      <div className="relative flex flex-col min-h-screen w-full max-w-md mx-auto">
        {/* Header */}
        <header className="flex items-center justify-between px-6 pt-6 pb-2 sticky top-0 z-50 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-md">
          <div className="flex items-center gap-3">
            <button className="flex items-center justify-center p-2 -ml-2 rounded-full hover:bg-slate-200 dark:hover:bg-slate-800 transition-colors">
              <span className="material-symbols-outlined text-[28px]">
                menu
              </span>
            </button>
          </div>
          <h1 className="text-xl font-bold tracking-tight uppercase">Aevum</h1>
          <button className="relative flex items-center justify-center size-10 overflow-hidden rounded-full border border-slate-200 dark:border-slate-700">
            <img
              alt="User profile"
              className="w-full h-full object-cover"
              src="https://lh3.googleusercontent.com/aida-public/AB6AXuBmmoe1TEBEd6C8-6c9Wm3GvWnHn5QsrQDFFbiPZ5_v0FFA0E3Yuh9tCZZfrW89Yzx-ARjsOMkT_jRhlEmQsN6P4MnK_Oz62hl3nhOJ-9eTJKrP5HrkvTH3OW-PQgrkM1ElKRpMpDHEblHn3UUqlmMTBXTgcCSbk9M_Peg-17XxZ2xEny6_9MfMj4QsCiFfUsh9KAD0sqJu_iD640nLkRGNaRdS9Hb93W7CIuNFdMiiqg7jLJ-ih-X3VDUkpMCaOzNrMpxEf0bti8E"
            />
          </button>
        </header>

        {/* Main Content Scroll Area */}
        <main className="flex-1 px-4 pt-4 flex flex-col gap-6">
          {/* Search Bar */}
          <div className="relative z-10">
            <div className="glass-panel h-14 rounded-2xl flex items-center px-4 shadow-lg shadow-black/5">
              <span className="material-symbols-outlined text-slate-400 text-[24px]">
                search
              </span>
              <input
                className="flex-1 bg-transparent border-none text-base font-medium placeholder-slate-400 focus:ring-0 text-slate-900 dark:text-white h-full px-3 focus:outline-none"
                placeholder="Search ancestors, locations..."
                type="text"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
              />
              <button className="p-2 rounded-full hover:bg-white/10 text-primary">
                <span className="material-symbols-outlined text-[24px]">
                  mic
                </span>
              </button>
            </div>
          </div>

          {/* Bento Filter Grid */}
          <section className="grid grid-cols-2 gap-3">
            {/* Era Module */}
            <div className="col-span-2 glass-panel p-4 rounded-2xl flex flex-col gap-3">
              <div className="flex justify-between items-center">
                <h3 className="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-widest">
                  Era
                </h3>
                <button
                  className="text-primary text-xs font-semibold"
                  onClick={() => setActiveEra("")}
                >
                  RESET
                </button>
              </div>
              <div className="flex gap-3 overflow-x-auto hide-scrollbar pb-1">
                {eras.map((era) => (
                  <button
                    key={era}
                    onClick={() => setActiveEra(era)}
                    className={`flex-shrink-0 px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
                      activeEra === era
                        ? "bg-primary text-white shadow-md shadow-primary/20"
                        : "bg-slate-200 dark:bg-slate-800 hover:bg-primary hover:text-white"
                    }`}
                  >
                    {era}
                  </button>
                ))}
              </div>
            </div>

            {/* Family Branch Module */}
            <div className="col-span-1 glass-panel p-4 rounded-2xl flex flex-col justify-between h-32 relative group cursor-pointer hover:border-primary/50 transition-colors">
              <div className="absolute top-4 right-4 text-slate-400 group-hover:text-primary transition-colors">
                <span className="material-symbols-outlined text-[20px]">
                  arrow_drop_down_circle
                </span>
              </div>
              <h3 className="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-widest">
                Branch
              </h3>
              <div>
                <p className="text-lg font-bold leading-tight line-clamp-2">
                  Rutherford Line
                </p>
                <p className="text-xs text-slate-400 mt-1">Paternal Side</p>
              </div>
            </div>

            {/* Media Type Module */}
            <div className="col-span-1 glass-panel p-4 rounded-2xl flex flex-col justify-between h-32">
              <h3 className="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-widest">
                Media Type
              </h3>
              <div className="flex justify-between items-end">
                <button className="flex flex-col items-center gap-1 group">
                  <div className="w-8 h-8 rounded-full bg-slate-200 dark:bg-slate-800 flex items-center justify-center group-hover:bg-primary group-hover:text-white transition-colors">
                    <span className="material-symbols-outlined text-[16px]">
                      image
                    </span>
                  </div>
                  <span className="text-[10px] font-medium opacity-60">
                    Photos
                  </span>
                </button>
                <button className="flex flex-col items-center gap-1 group">
                  <div className="w-8 h-8 rounded-full bg-primary text-white flex items-center justify-center shadow-lg shadow-primary/25">
                    <span className="material-symbols-outlined text-[16px]">
                      description
                    </span>
                  </div>
                  <span className="text-[10px] font-medium text-primary">
                    Docs
                  </span>
                </button>
                <button className="flex flex-col items-center gap-1 group">
                  <div className="w-8 h-8 rounded-full bg-slate-200 dark:bg-slate-800 flex items-center justify-center group-hover:bg-purple-500 group-hover:text-white transition-colors">
                    <span className="material-symbols-outlined text-[16px]">
                      auto_awesome
                    </span>
                  </div>
                  <span className="text-[10px] font-medium opacity-60">AI</span>
                </button>
              </div>
            </div>
          </section>

          {/* Results Section Header */}
          <div className="flex items-center justify-between mt-2">
            <h2 className="text-lg font-bold">
              Results{" "}
              <span className="text-slate-400 text-sm font-normal ml-1">
                (24 found)
              </span>
            </h2>
            <div className="flex gap-2">
              <button className="p-1.5 rounded-lg bg-slate-200 dark:bg-slate-800 hover:bg-slate-300 dark:hover:bg-slate-700">
                <span className="material-symbols-outlined text-[18px]">
                  grid_view
                </span>
              </button>
              <button className="p-1.5 rounded-lg text-slate-400 hover:bg-slate-200 dark:hover:bg-slate-800">
                <span className="material-symbols-outlined text-[18px]">
                  list
                </span>
              </button>
            </div>
          </div>

          {/* Dynamic Results Grid */}
          <section className="grid grid-cols-2 gap-4 auto-rows-min">
            {/* Result Card 1: Photo */}
            <div className="glass-card rounded-xl overflow-hidden relative aspect-[3/4] group cursor-pointer">
              {/* Optimization: Added lazy loading to off-screen images in the results grid to improve initial load time */}
              <img
                alt="Old vintage family portrait"
                className="absolute inset-0 w-full h-full object-cover transition-transform duration-500 group-hover:scale-105"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuCWE_IqL41lrLpnj8LNuCfPOh51R3MmX4w-DRGkaiap0qzBhYlyKYmYAcYAPcz05S0HG24B0-H0FaFYzZJvocIY0uJGVlPkiQ29uz9Hxcjyod93h_kAAOw_83qOyoUYTPSlJhxvFxmaEmhmGzdPSniL18MUX66RsVqW9urCKgk0OnZUJqShabZAxwmL47DUuOUwfqeTQr2b-OD70rgQKcW4uIYwLqaAUfF_7M6bwt3a66b5ul5hFegapH8vdn6siIWxhfNRGDvv_Js"
                loading="lazy"
                decoding="async"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent p-3 flex flex-col justify-end">
                <div className="mb-1 inline-flex items-center gap-1 bg-black/40 backdrop-blur-sm px-2 py-0.5 rounded-full w-fit">
                  <span className="material-symbols-outlined text-[10px] text-white">
                    calendar_today
                  </span>
                  <span className="text-[10px] font-bold text-white">1892</span>
                </div>
                <h4 className="text-white font-bold text-sm leading-tight">
                  Arthur J. Rutherford
                </h4>
                <p className="text-slate-300 text-xs mt-0.5">
                  Portrait • London
                </p>
              </div>
            </div>

            {/* Result Card 2: Document */}
            <div
              className="glass-card rounded-xl overflow-hidden relative aspect-square group cursor-pointer"
              onClick={() => navigate("/vault")} // Link to vault?
            >
              <div className="absolute inset-0 bg-slate-800 flex items-center justify-center">
                <img
                  alt="Old handwritten document"
                  className="w-full h-full object-cover opacity-60 group-hover:opacity-80 transition-opacity"
                  src="https://lh3.googleusercontent.com/aida-public/AB6AXuA80M32QfNAG2r0yeDhlL_o_TmHFahTen2pKpaPVUdPmppf7-F0hiOndSx9Pf1qWEsO4vEUzbth3rxbzlAZrNEcg4ieuXxZLJmrIFSbjHb5Op-jRfVCO0h_vDlnv0bc62_Bx-YmT0RvEvahxbBRQJqUn4OMavmEvty4vOqW-WRpyp3a9oxZxphjdnP8bW41NuizEjIjpDixLeYCgG6hgeQ0vShJANSacKe-3fc4hNUzmT_Itp6uqlWa-Ecx6Y23xLH5TGO7fiDnMCs"
                  loading="lazy"
                  decoding="async"
                />
              </div>
              <div className="absolute top-2 right-2 bg-primary/90 text-white text-[10px] font-bold px-2 py-1 rounded-md backdrop-blur-sm">
                RECORD
              </div>
              <div className="absolute inset-0 flex flex-col justify-end p-3 bg-gradient-to-t from-black/90 to-transparent">
                <h4 className="text-white font-bold text-sm">Census Record</h4>
                <p className="text-slate-300 text-xs mt-0.5">1880 • New York</p>
              </div>
            </div>

            {/* Result Card 3: AI Story */}
            <div
              className="glass-card rounded-xl overflow-hidden relative aspect-square p-4 bg-gradient-to-br from-indigo-900/40 to-purple-900/40 border-purple-500/20 group cursor-pointer col-span-1"
              id="story-1"
              onClick={() => handleResultClick("story-1")}
            >
              <div className="absolute top-2 left-2 w-6 h-6 rounded-full bg-purple-500/20 flex items-center justify-center border border-purple-500/40">
                <span className="material-symbols-outlined text-[14px] text-purple-300">
                  auto_awesome
                </span>
              </div>
              <div className="h-full flex flex-col justify-end">
                <h4 className="text-white font-bold text-sm leading-tight mb-1">
                  The Journey West
                </h4>
                <p className="text-purple-200 text-xs line-clamp-2">
                  AI reconstruction of the 1845 migration path based on diary
                  entries.
                </p>
              </div>
            </div>

            {/* Result Card 4: Photo */}
            <div className="glass-card rounded-xl overflow-hidden relative aspect-[3/4] group cursor-pointer">
              <img
                alt="Vintage woman portrait"
                className="absolute inset-0 w-full h-full object-cover transition-transform duration-500 group-hover:scale-105 filter sepia-[.3] contrast-125"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuDjd2FPPHYYjMcY2PShy7_Fg6lrwXNXHWRdZFyhO2HN0p8JphCf6R-iursB9egVm0L6v0lvGhlVHy9eXdoBGIXlYJVBcME3tQZst9q9A6aUZdq75hSa8_0anG6fIwG-PUZoJwcTsk0gn8RyPy-fkAGwpM3DdGXYCLW_PBYGfmbLUqkorNEFWSoAjUJHukmFiccPgijs3tKHLLqh8e0VslnBpWiP5fYoIpzfaZdeQjFVsHeLR08AinPqw4K-edOCaCJUd6yOqPlImWA"
                loading="lazy"
                decoding="async"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent p-3 flex flex-col justify-end">
                <h4 className="text-white font-bold text-sm leading-tight">
                  Sarah E. Miller
                </h4>
                <p className="text-slate-300 text-xs mt-0.5">1921 • Chicago</p>
              </div>
            </div>

            {/* Result Card 5: Map Location */}
            <div className="glass-card rounded-xl overflow-hidden relative aspect-square group cursor-pointer col-span-2">
              <img
                alt="Map"
                className="absolute inset-0 w-full h-full object-cover opacity-70 group-hover:scale-105 transition-transform duration-700"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuAhFNHDbom14qDQ3NxKqdCrFI0YGs9iJvbLImrJySDZOjZykmvvt7x1UK7U7zrl291plaqLA0mSPiTvbnf6Pu3K61IRspubxt0pmNnS-XjriYBDi66knyQERYA5-2rQ30zY5LxElpb32KTBR7_9pTPkk6USHHkXmsW1p7Y98Yk7XUz58OMXjo2lggV0wONLmlMDyQiaa3GhFjRrGiOnloHBeuEvIGkNZzeiG5i7ZKy21ctJCIb0JjhLGCW08YXTN2QHsaM5v0Mskt0"
                loading="lazy"
                decoding="async"
              />
              <div className="absolute inset-0 bg-black/40 group-hover:bg-black/20 transition-colors"></div>
              <div className="absolute bottom-3 left-3 right-3">
                <div className="flex items-center gap-2 mb-1">
                  <span className="material-symbols-outlined text-white text-[16px]">
                    location_on
                  </span>
                  <span className="text-white text-xs font-bold uppercase tracking-wider">
                    Heritage Site
                  </span>
                </div>
                <h4 className="text-white font-bold text-lg">
                  Edinburgh Homestead
                </h4>
              </div>
            </div>
          </section>
        </main>
      </div>
    </div>
  );
}

export default ExplorerScreen;
