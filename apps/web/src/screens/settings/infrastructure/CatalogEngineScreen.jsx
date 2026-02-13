import { useNavigate } from "react-router-dom";
import { useInfrastructure } from "@/contexts/InfrastructureContext";
import "./CatalogEngineScreen.css";

function CatalogEngineScreen() {
  const navigate = useNavigate();
  const { indexingStatus, itemsIndexed, throughput } = useInfrastructure();

  return (
    <div className="bg-background-light dark:bg-background-dark min-h-screen font-display text-slate-900 dark:text-white overflow-x-hidden selection:bg-primary selection:text-white pb-24">
      <div className="relative flex h-full w-full max-w-md mx-auto flex-col pb-24">
        <header className="flex items-center justify-between p-6 pb-2">
          <div className="flex items-center gap-3">
            <button
              className="flex items-center justify-center text-slate-400 hover:text-white transition-colors size-10 rounded-full hover:bg-white/5"
              onClick={() => navigate(-1)}
            >
              <span className="material-symbols-outlined">arrow_back</span>
            </button>
            <div className="flex size-10 items-center justify-center rounded-xl bg-primary/20 text-primary">
              <span className="material-symbols-outlined text-2xl">
                grid_view
              </span>
            </div>
            <div>
              <h1 className="text-lg font-bold leading-tight tracking-tight">
                Aevum Engine
              </h1>
              <p className="text-xs font-medium text-slate-500 dark:text-slate-400 tracking-widest uppercase">
                v2.4 // Build 892
              </p>
            </div>
          </div>
          <div className="flex items-center gap-2 rounded-full bg-green-500/10 px-3 py-1 border border-green-500/20">
            <div className="h-1.5 w-1.5 rounded-full bg-green-500 animate-pulse"></div>
            <span className="text-xs font-bold text-green-500 uppercase tracking-wide">
              {indexingStatus === "Active" ? "Online" : "Paused"}
            </span>
          </div>
        </header>
        <div className="px-6 py-4">
          <h2 className="text-2xl font-bold tracking-tight text-white/90">
            Cataloging &amp;
            <br />
            Indexing
          </h2>
        </div>
        <div className="flex flex-col gap-4 px-4">
          <div className="glass-card rounded-2xl p-5 relative overflow-hidden group">
            <div className="absolute -right-10 -top-10 h-32 w-32 rounded-full bg-primary/10 blur-3xl pointer-events-none"></div>
            <div className="flex justify-between items-start mb-4">
              <div className="flex flex-col gap-1">
                <span className="text-xs font-bold uppercase tracking-widest text-slate-500 dark:text-slate-400">
                  Storage Path
                </span>
                <h3 className="text-lg font-bold">High-Res Vault</h3>
              </div>
              <span className="material-symbols-outlined text-primary/80">
                cloud_upload
              </span>
            </div>
            <div className="flex flex-col gap-4">
              <div
                className="h-32 w-full rounded-xl bg-slate-900/50 border border-white/5 relative overflow-hidden"
                style={{
                  backgroundImage:
                    "url('https://lh3.googleusercontent.com/aida-public/AB6AXuDboHInGxe63iPNEbsLh5xcXR14DFxxtfFKFe1r9GmUhnoM1lP1df3ePk9RHUUAgVSomUQFxFpHJFEtbbRWw2bYzoXMNVRTwkY4_JnkLvJlXT4JL939aD64el3ZFOXfNqK-NeGzlPxXVs_4RtjvqmytIM2wlrfd7mrXAV_oO_E6PWFwALHdJvEqVBg8tnsdIk4hWpT3ItAo8jwamk51MXQGFZbVbQfiKsvMmkhJWjJdmBJt8F6BsPELRcTU38Oqhyv47O5rjOCrgm4')",
                  backgroundSize: "cover",
                  backgroundPosition: "center",
                }}
              >
                <div className="absolute inset-0 bg-gradient-to-t from-background-dark via-transparent to-transparent opacity-90"></div>
                <div className="absolute bottom-3 left-3 right-3">
                  <div className="flex items-center justify-between text-xs text-white/70 mb-1">
                    <span>Throughput</span>
                    <span className="text-primary font-mono">
                      {throughput} MB/s
                    </span>
                  </div>
                  <div className="h-1 w-full bg-white/10 rounded-full overflow-hidden">
                    <div className="h-full bg-primary w-[75%] rounded-full animate-pulse-slow"></div>
                  </div>
                </div>
              </div>
              <div className="flex items-center justify-between rounded-lg bg-white/5 p-3 border border-white/5">
                <div className="flex items-center gap-3">
                  <span className="material-symbols-outlined text-sm text-slate-400">
                    dns
                  </span>
                  <div className="flex flex-col">
                    <span className="text-xs font-bold text-white">
                      AWS S3 (us-east-1)
                    </span>
                    <span className="text-[10px] text-slate-400">
                      Managed Cloud • Encrpyted
                    </span>
                  </div>
                </div>
                <div className="h-2 w-2 rounded-full bg-primary shadow-[0_0_8px_rgba(17,115,212,0.6)]"></div>
              </div>
            </div>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div className="glass-card rounded-2xl p-4 flex flex-col justify-between min-h-[140px]">
              <div className="flex items-start justify-between">
                <span className="text-xs font-bold uppercase tracking-widest text-slate-500 dark:text-slate-400">
                  Indexed
                </span>
                <span className="material-symbols-outlined text-sm text-slate-600">
                  perm_media
                </span>
              </div>
              <div className="flex flex-col gap-1">
                <span className="text-3xl font-bold tabular-nums tracking-tight">
                  {itemsIndexed.toLocaleString()}
                </span>
                <div className="flex items-center gap-1 text-xs text-green-400 font-medium">
                  <span className="material-symbols-outlined text-xs">
                    trending_up
                  </span>
                  <span>+120 today</span>
                </div>
              </div>
            </div>
            <div className="glass-card rounded-2xl p-4 flex flex-col justify-between min-h-[140px]">
              <div className="flex items-start justify-between">
                <span className="text-xs font-bold uppercase tracking-widest text-slate-500 dark:text-slate-400">
                  Volume
                </span>
                <span className="material-symbols-outlined text-sm text-slate-600">
                  hard_drive
                </span>
              </div>
              <div className="flex flex-col gap-1">
                <span className="text-3xl font-bold tabular-nums tracking-tight">
                  452<span className="text-lg text-slate-500 ml-1">GB</span>
                </span>
                <div className="flex items-center gap-1 text-xs text-slate-400 font-medium">
                  <span>Of 2TB Allocation</span>
                </div>
              </div>
              <div className="h-1 w-full bg-white/10 rounded-full overflow-hidden mt-1">
                <div className="h-full bg-slate-400 w-[22%] rounded-full"></div>
              </div>
            </div>
          </div>
          <div className="glass-card rounded-2xl p-5">
            <div className="flex justify-between items-center mb-5">
              <div className="flex items-center gap-2">
                <span className="material-symbols-outlined text-primary text-lg">
                  psychology
                </span>
                <h3 className="text-base font-bold text-white">
                  Neural Processing
                </h3>
              </div>
              <span className="text-xs font-mono text-primary bg-primary/10 px-2 py-0.5 rounded border border-primary/20">
                ACTIVE
              </span>
            </div>
            <div className="relative pl-2 space-y-6 before:absolute before:left-3.5 before:top-2 before:bottom-2 before:w-px before:bg-gradient-to-b before:from-primary before:via-primary/20 before:to-transparent">
              <div className="relative pl-6">
                <div className="absolute left-0 top-1 h-2.5 w-2.5 rounded-full bg-background-dark border-2 border-primary z-10"></div>
                <div className="flex justify-between items-start mb-1">
                  <h4 className="text-sm font-bold text-white">
                    EXIF Extraction
                  </h4>
                  <span className="text-xs text-slate-400 font-mono">12ms</span>
                </div>
                <p className="text-xs text-slate-400 leading-relaxed">
                  Parsing metadata, geolocation, and device headers.
                </p>
              </div>
              <div className="relative pl-6">
                <div className="absolute left-0 top-1 h-2.5 w-2.5 rounded-full bg-background-dark border-2 border-primary z-10"></div>
                <div className="flex justify-between items-start mb-1">
                  <h4 className="text-sm font-bold text-white">
                    WebP Optimization
                  </h4>
                  <span className="text-xs text-green-400 font-mono">
                    85% Ratio
                  </span>
                </div>
                <div className="flex items-center gap-2 mt-2">
                  <div className="h-8 w-12 rounded bg-slate-800 border border-white/10 flex items-center justify-center overflow-hidden">
                    <span className="material-symbols-outlined text-xs text-white/20">
                      image
                    </span>
                  </div>
                  <span className="material-symbols-outlined text-slate-600 text-xs">
                    arrow_right_alt
                  </span>
                  <div className="h-8 w-12 rounded bg-slate-800 border border-primary/30 flex items-center justify-center overflow-hidden shadow-[0_0_10px_rgba(17,115,212,0.1)]">
                    <span className="material-symbols-outlined text-xs text-primary">
                      image
                    </span>
                  </div>
                </div>
              </div>
              <div className="relative pl-6 opacity-80">
                <div className="absolute left-0 top-1 h-2.5 w-2.5 rounded-full bg-background-dark border-2 border-slate-600 z-10"></div>
                <div className="flex justify-between items-start mb-1">
                  <h4 className="text-sm font-bold text-white">
                    Vector Embedding
                  </h4>
                  <span className="text-xs text-slate-400 font-mono">
                    Queue: 4
                  </span>
                </div>
                <div className="mt-2 w-full bg-white/5 rounded-full h-1.5 overflow-hidden">
                  <div className="bg-gradient-to-r from-primary to-purple-500 h-full w-[65%]"></div>
                </div>
                <p className="text-[10px] text-slate-500 mt-1 font-mono">
                  Generative 1536-dim vectors
                </p>
              </div>
            </div>
          </div>
          <div className="glass-card rounded-2xl p-4 flex items-center gap-4">
            <div className="relative size-12 shrink-0">
              <svg className="size-full -rotate-90" viewBox="0 0 36 36">
                <path
                  className="text-slate-800"
                  d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="4"
                ></path>
                <path
                  className="text-primary"
                  d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
                  fill="none"
                  stroke="currentColor"
                  strokeDasharray="98, 100"
                  strokeLinecap="round"
                  strokeWidth="4"
                ></path>
              </svg>
              <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-[10px] font-bold text-white">
                98%
              </div>
            </div>
            <div className="flex flex-col">
              <span className="text-sm font-bold text-white">
                Semantic Readiness
              </span>
              <span className="text-xs text-slate-400">
                Search index is healthy and optimized.
              </span>
            </div>
          </div>
          <div className="w-full bg-[#050505] rounded-xl p-3 font-mono text-[10px] border border-white/5 shadow-inner opacity-80 mt-2">
            <div className="flex items-center gap-2 mb-2 border-b border-white/5 pb-1">
              <div className="flex gap-1">
                <div className="size-1.5 rounded-full bg-red-500"></div>
                <div className="size-1.5 rounded-full bg-yellow-500"></div>
                <div className="size-1.5 rounded-full bg-green-500"></div>
              </div>
              <span className="text-slate-500 uppercase tracking-wider">
                System Log
              </span>
            </div>
            <div className="flex flex-col gap-1 text-slate-400 h-20 overflow-hidden relative">
              <div className="absolute bottom-0 left-0 w-full h-8 bg-gradient-to-t from-[#050505] to-transparent pointer-events-none"></div>
              <p>
                <span className="text-blue-500">14:23:01</span> [IMG_2901]
                Upload complete
              </p>
              <p>
                <span className="text-blue-500">14:23:02</span> [IMG_2901] EXIF:
                lat:40.7128, long:-74.0060
              </p>
              <p>
                <span className="text-purple-500">14:23:04</span> [IMG_2900]
                Vector embedding generated
              </p>
              <p>
                <span className="text-green-500">14:23:05</span> Index update:
                +1 item
              </p>
            </div>
          </div>
          <div className="h-10"></div>
        </div>
      </div>
    </div>
  );
}

export default CatalogEngineScreen;
