import { useNavigate } from "react-router-dom";
import { useInfrastructure } from "@/contexts/InfrastructureContext";
import "./InfrastructureControlScreen.css";

function InfrastructureControlScreen() {
  const navigate = useNavigate();
  const {
    vaultUsage,
    vaultCapacity,
    photosSynced,
    totalPhotos,
    indexingStatus,
  } = useInfrastructure();

  return (
    <div className="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-white antialiased selection:bg-primary selection:text-white relative flex min-h-screen w-full flex-col overflow-x-hidden pb-6">
      <header className="sticky top-0 z-50 flex items-center justify-between p-4 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-md border-b border-white/10">
        <div className="flex items-center gap-3">
          <button
            className="flex items-center justify-center text-slate-400 hover:text-white transition-colors size-10 rounded-full hover:bg-white/5"
            onClick={() => navigate(-1)}
          >
            <span className="material-symbols-outlined">arrow_back</span>
          </button>
          <div className="flex items-center justify-center size-10 rounded-full bg-primary/20 text-primary">
            <span className="material-symbols-outlined text-[24px]">
              verified_user
            </span>
          </div>
          <div>
            <h1 className="text-lg font-bold leading-tight tracking-tight">
              Infrastructure Control
            </h1>
            <div className="flex items-center gap-1">
              <span className="size-2 rounded-full bg-emerald-500 animate-pulse"></span>
              <span className="text-xs font-medium text-slate-500 dark:text-slate-400">
                Secure Connection
              </span>
            </div>
          </div>
        </div>
        <button className="flex size-10 items-center justify-center rounded-full bg-white/5 border border-white/10 hover:bg-white/10 transition-colors">
          <span className="material-symbols-outlined text-[20px] text-slate-400 dark:text-slate-300">
            lock
          </span>
        </button>
      </header>
      <main className="flex-1 p-4 flex flex-col gap-4">
        <section className="grid grid-cols-2 gap-4">
          <div
            className="glass-card rounded-xl p-4 flex flex-col gap-1 cursor-pointer"
            onClick={() => navigate("/settings/vault-health")}
          >
            <div className="flex items-center gap-2 mb-2">
              <span className="material-symbols-outlined text-primary text-[20px]">
                activity_zone
              </span>
              <span className="text-xs font-bold uppercase tracking-wider text-slate-400">
                Uptime
              </span>
            </div>
            <div className="text-2xl font-bold">99.99%</div>
            <div className="text-xs text-emerald-500 font-medium">
              +0.01% vs last week
            </div>
          </div>
          <div
            className="glass-card rounded-xl p-4 flex flex-col gap-1 cursor-pointer"
            onClick={() => navigate("/settings/redundancy")}
          >
            <div className="flex items-center gap-2 mb-2">
              <span className="material-symbols-outlined text-primary text-[20px]">
                database
              </span>
              <span className="text-xs font-bold uppercase tracking-wider text-slate-400">
                Storage
              </span>
            </div>
            <div className="text-2xl font-bold">{vaultUsage.toFixed(1)} GB</div>
            <div className="w-full bg-white/10 h-1.5 rounded-full mt-1 overflow-hidden">
              <div
                className="bg-primary h-full rounded-full transition-all duration-1000"
                style={{ width: `${(vaultUsage / vaultCapacity) * 100}%` }}
              ></div>
            </div>
          </div>
        </section>
        <section className="glass-card rounded-xl p-5 relative overflow-hidden">
          <div className="flex justify-between items-start mb-4">
            <div className="flex items-center gap-2">
              <div className="p-1.5 rounded bg-primary/10 text-primary">
                <span className="material-symbols-outlined text-[20px]">
                  cloud_upload
                </span>
              </div>
              <div>
                <h2 className="text-lg font-bold leading-none">
                  Storage Strategy
                </h2>
                <span className="text-xs text-slate-400">
                  Bring Your Own Bucket (BYOB)
                </span>
              </div>
            </div>
            <button
              className="text-xs font-bold bg-white/5 hover:bg-white/10 border border-white/10 px-3 py-1.5 rounded-lg transition-colors"
              onClick={() => navigate("/settings/storage-architecture")}
            >
              CONFIGURE
            </button>
          </div>
          <div className="grid grid-cols-3 gap-2 mb-5">
            <div className="flex flex-col items-center gap-2 p-3 rounded-lg bg-primary/20 border border-primary/50 relative">
              <div className="size-2 rounded-full bg-emerald-500 absolute top-2 right-2 shadow-[0_0_8px_rgba(16,185,129,0.5)]"></div>
              <span className="material-symbols-outlined text-[24px] text-white">
                deployed_code
              </span>
              <span className="text-[10px] font-bold text-white uppercase tracking-wide">
                AWS S3
              </span>
            </div>
            <div className="flex flex-col items-center gap-2 p-3 rounded-lg bg-white/5 border border-white/5 opacity-60 grayscale">
              <span className="material-symbols-outlined text-[24px]">
                grid_view
              </span>
              <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wide">
                Azure
              </span>
            </div>
            <div className="flex flex-col items-center gap-2 p-3 rounded-lg bg-white/5 border border-white/5 opacity-60 grayscale">
              <span className="material-symbols-outlined text-[24px]">
                cloud
              </span>
              <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wide">
                GCP
              </span>
            </div>
          </div>
          <div
            className="bg-black/20 rounded-lg p-3 border border-white/5 mb-4 cursor-pointer hover:bg-white/5 transition-colors"
            onClick={() => navigate("/settings/catalog-engine")}
          >
            <div className="flex justify-between items-center mb-2">
              <span className="text-xs font-bold uppercase text-slate-400">
                Cataloging Engine
              </span>
              <span className="text-[10px] font-mono text-emerald-500">
                {indexingStatus === "Active"
                  ? "RUNNING_TASK_ID: 8X92"
                  : "PAUSED"}
              </span>
            </div>
            <div className="space-y-3">
              <div>
                <div className="flex justify-between text-xs mb-1">
                  <span className="text-slate-300">Thumbnail Generation</span>
                  <span className="text-white font-mono">
                    {photosSynced.toLocaleString()} /{" "}
                    {totalPhotos.toLocaleString()}
                  </span>
                </div>
                <div className="w-full bg-white/10 h-1 rounded-full overflow-hidden">
                  <div
                    className="bg-emerald-500 h-full rounded-full transition-all duration-300"
                    style={{ width: `${(photosSynced / totalPhotos) * 100}%` }}
                  ></div>
                </div>
              </div>
              <div>
                <div className="flex justify-between text-xs mb-1">
                  <span className="text-slate-300">AI Metadata Indexing</span>
                  <span className="text-white font-mono">Processing...</span>
                </div>
                <div className="w-full bg-white/10 h-1 rounded-full overflow-hidden relative">
                  <div className="absolute inset-0 bg-gradient-to-r from-transparent via-primary to-transparent w-1/2 h-full animate-[shimmer_1.5s_infinite]"></div>
                  <div className="bg-primary h-full rounded-full w-[65%]"></div>
                </div>
              </div>
            </div>
          </div>
          <div className="flex items-center justify-between p-3 rounded-lg bg-gradient-to-r from-purple-500/10 to-blue-500/10 border border-purple-500/20">
            <div className="flex items-center gap-3">
              <div className="p-1.5 bg-white/10 rounded text-white">
                <span className="material-symbols-outlined text-[20px]">
                  view_in_ar
                </span>
              </div>
              <div className="flex flex-col">
                <span className="text-sm font-bold text-white flex items-center gap-2">
                  Vision Pro
                  <span className="px-1.5 py-0.5 rounded text-[9px] bg-purple-500 text-white font-bold">
                    ALPHA
                  </span>
                </span>
                <span className="text-xs text-slate-400">
                  High-fidelity 3D Spatial View
                </span>
              </div>
            </div>
            <div className="w-10 h-6 bg-white/10 rounded-full relative cursor-pointer border border-white/10">
              <div className="absolute left-1 top-1 size-4 bg-slate-400 rounded-full shadow-sm transition-all"></div>
            </div>
          </div>
        </section>
        <section className="glass-card-highlight rounded-xl p-5 relative overflow-hidden group">
          <div className="absolute -right-10 -top-10 size-40 bg-primary/20 rounded-full blur-[60px] pointer-events-none"></div>
          <div className="flex justify-between items-start mb-6 relative z-10">
            <div>
              <h2 className="text-xl font-bold mb-1">AI Engine Optimization</h2>
              <p className="text-sm text-slate-400">
                Generative Model Configuration
              </p>
            </div>
            <div className="px-2 py-1 rounded bg-primary/20 border border-primary/30 text-primary text-xs font-bold">
              ACTIVE
            </div>
          </div>
          <div className="relative z-10 space-y-5">
            <div className="bg-black/20 rounded-lg p-1 flex items-center relative border border-white/5">
              <div className="flex-1 text-center py-2 text-sm font-bold text-white bg-primary/20 rounded shadow-sm border border-primary/30">
                Narrative v4.0
              </div>
              <div className="flex-1 text-center py-2 text-sm font-medium text-slate-400 hover:text-white transition-colors cursor-pointer">
                Fact Check
              </div>
            </div>
            <div className="flex items-end justify-between gap-4">
              <div className="flex-1">
                <div className="text-xs text-slate-400 mb-1">
                  Processing Load
                </div>
                <div className="h-16 w-full flex items-end gap-1">
                  <div className="bg-primary/30 w-full h-[40%] rounded-sm"></div>
                  <div className="bg-primary/50 w-full h-[60%] rounded-sm"></div>
                  <div className="bg-primary/40 w-full h-[30%] rounded-sm"></div>
                  <div className="bg-primary/60 w-full h-[75%] rounded-sm"></div>
                  <div className="bg-primary w-full h-[50%] rounded-sm"></div>
                  <div className="bg-primary/70 w-full h-[80%] rounded-sm"></div>
                  <div className="bg-primary/40 w-full h-[45%] rounded-sm"></div>
                </div>
              </div>
              <div className="text-right">
                <div className="text-3xl font-bold text-white">
                  98<span className="text-lg text-slate-400">%</span>
                </div>
                <div className="text-xs text-slate-400">Accuracy Score</div>
              </div>
            </div>
          </div>
        </section>
        <section className="glass-card rounded-xl p-5">
          <div className="flex items-center justify-between mb-4">
            <h3 className="text-lg font-bold">Redundancy Layer</h3>
            <span className="material-symbols-outlined text-slate-400">
              cloud_sync
            </span>
          </div>
          <div className="flex items-center justify-between gap-2 mb-6">
            <div className="flex flex-col items-center gap-2">
              <div className="size-12 rounded-full bg-white/5 border border-white/10 flex items-center justify-center relative">
                <span className="material-symbols-outlined text-white">
                  cloud
                </span>
                <div className="absolute -top-1 -right-1 size-3 bg-emerald-500 rounded-full border-2 border-[#101922]"></div>
              </div>
              <span className="text-xs font-medium text-slate-400">
                US-East
              </span>
            </div>
            <div className="h-[1px] flex-1 bg-gradient-to-r from-transparent via-primary to-transparent opacity-50 relative">
              <div className="absolute left-1/2 top-1/2 -translate-y-1/2 -translate-x-1/2 size-1.5 bg-primary rounded-full animate-ping"></div>
            </div>
            <div className="flex flex-col items-center gap-2">
              <div className="size-14 rounded-full bg-primary/20 border border-primary/50 flex items-center justify-center shadow-[0_0_15px_rgba(17,115,212,0.3)] relative">
                <span className="material-symbols-outlined text-white text-[28px]">
                  hub
                </span>
                <div className="absolute -bottom-1 size-3 bg-emerald-500 rounded-full border-2 border-[#101922] animate-pulse"></div>
              </div>
              <span className="text-xs font-bold text-white">Core</span>
            </div>
            <div className="h-[1px] flex-1 bg-gradient-to-r from-transparent via-primary to-transparent opacity-50 relative"></div>
            <div className="flex flex-col items-center gap-2">
              <div className="size-12 rounded-full bg-white/5 border border-white/10 flex items-center justify-center relative">
                <span className="material-symbols-outlined text-white">
                  cloud_queue
                </span>
                <div className="absolute -top-1 -right-1 size-3 bg-amber-500 rounded-full border-2 border-[#101922]"></div>
              </div>
              <span className="text-xs font-medium text-slate-400">
                EU-West
              </span>
            </div>
          </div>
          <div className="flex items-center gap-3 text-xs bg-black/20 p-3 rounded-lg border border-white/5">
            <span className="material-symbols-outlined text-emerald-500 text-[16px]">
              check_circle
            </span>
            <span className="text-slate-300">
              Mirroring active across 3 zones. Latency 24ms.
            </span>
          </div>
        </section>
        <section className="glass-card rounded-xl p-5 flex flex-col gap-4">
          <div className="flex items-center justify-between">
            <h3 className="text-lg font-bold">Sentinel Protocol</h3>
            <span className="material-symbols-outlined text-slate-400">
              encrypted
            </span>
          </div>
          <div className="space-y-3">
            <div className="flex items-center justify-between p-3 rounded-lg bg-white/5 border border-white/5">
              <div className="flex items-center gap-3">
                <div className="p-1.5 bg-primary/20 rounded text-primary">
                  <span className="material-symbols-outlined text-[20px]">
                    key
                  </span>
                </div>
                <div className="flex flex-col">
                  <span className="text-sm font-bold text-white">
                    E2E Encryption
                  </span>
                  <span className="text-xs text-slate-400">
                    AES-256 Enabled
                  </span>
                </div>
              </div>
              <div className="w-10 h-6 bg-primary rounded-full relative cursor-pointer">
                <div className="absolute right-1 top-1 size-4 bg-white rounded-full shadow-sm"></div>
              </div>
            </div>
            <div className="flex items-center justify-between p-3 rounded-lg bg-white/5 border border-white/5">
              <div className="flex items-center gap-3">
                <div className="p-1.5 bg-amber-500/20 rounded text-amber-500">
                  <span className="material-symbols-outlined text-[20px]">
                    fingerprint
                  </span>
                </div>
                <div className="flex flex-col">
                  <span className="text-sm font-bold text-white">
                    Biometric Lock
                  </span>
                  <span className="text-xs text-slate-400">
                    FaceID Required
                  </span>
                </div>
              </div>
              <div className="w-10 h-6 bg-primary rounded-full relative cursor-pointer">
                <div className="absolute right-1 top-1 size-4 bg-white rounded-full shadow-sm"></div>
              </div>
            </div>
          </div>
          <div className="mt-2">
            <div className="text-xs font-bold uppercase tracking-wider text-slate-500 mb-2 pl-1">
              Access Log
            </div>
            <div className="bg-black/40 rounded-lg p-3 font-mono text-xs border border-white/10 h-28 overflow-y-auto scrollbar-hide space-y-2">
              <div className="flex gap-2 text-emerald-400">
                <span className="opacity-50">10:42:15</span>
                <span>Login: Admin (FaceID) verified</span>
              </div>
              <div className="flex gap-2 text-slate-300">
                <span className="opacity-50">10:41:02</span>
                <span>System check: Integrity 100%</span>
              </div>
              <div className="flex gap-2 text-slate-300">
                <span className="opacity-50">09:15:22</span>
                <span>Sync: US-East -&gt; Core complete</span>
              </div>
              <div className="flex gap-2 text-amber-400">
                <span className="opacity-50">08:30:05</span>
                <span>Warn: Latency spike EU-West</span>
              </div>
              <div className="flex gap-2 text-slate-300">
                <span className="opacity-50">08:29:55</span>
                <span>Handshake: Secure node connection</span>
              </div>
            </div>
          </div>
        </section>
      </main>
      <div className="px-4">
        <button className="w-full bg-white/5 hover:bg-white/10 text-slate-400 border border-white/10 font-bold py-3 rounded-xl transition-colors text-sm flex items-center justify-center gap-2">
          <span className="material-symbols-outlined text-[18px]">history</span>
          View Audit History
        </button>
      </div>
    </div>
  );
}

export default InfrastructureControlScreen;
