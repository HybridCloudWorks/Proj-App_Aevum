import { useNavigate } from "react-router-dom";
import { useInfrastructure } from "@/contexts/InfrastructureContext";
import "./VaultHealthScreen.css";

function VaultHealthScreen() {
  const navigate = useNavigate();
  const {
    offlineMode,
    setOfflineMode,
    highSpeedSync,
    setHighSpeedSync,
    vaultUsage,
    vaultCapacity,
    photosSynced,
    totalPhotos,
  } = useInfrastructure();

  return (
    <div className="bg-background-light dark:bg-background-dark text-slate-900 dark:text-white font-display antialiased selection:bg-primary selection:text-white min-h-screen relative flex flex-col overflow-x-hidden">
      <div className="ambient-glow"></div>
      <div className="ambient-glow-bottom"></div>
      <header className="sticky top-0 z-50 flex items-center justify-between p-4 pb-2 bg-transparent backdrop-blur-sm">
        <button
          className="text-white hover:bg-white/10 rounded-full p-2 transition-colors flex items-center justify-center"
          onClick={() => navigate(-1)}
        >
          <span className="material-symbols-outlined text-[24px]">
            arrow_back
          </span>
        </button>
        <h2 className="text-white text-lg font-bold leading-tight tracking-[-0.015em] flex-1 text-center drop-shadow-md">
          Vault Sync &amp; Health
        </h2>
        <div className="flex w-12 items-center justify-end">
          <button className="glass-button flex h-10 w-10 items-center justify-center rounded-full text-white transition-transform active:scale-95">
            <span className="material-symbols-outlined text-[24px]">
              settings
            </span>
          </button>
        </div>
      </header>
      <main className="relative z-10 flex flex-col gap-4 p-4 pb-28">
        <div className="grid grid-cols-2 gap-4">
          <div className="col-span-2">
            <div className="glass-card rounded-2xl p-6 relative overflow-hidden">
              <div className="flex flex-col @[480px]:flex-row items-center justify-between gap-6">
                <div className="relative h-32 w-32 shrink-0 flex items-center justify-center">
                  <div className="absolute inset-0 rounded-full glass-loader-bg border border-white/10"></div>
                  <div
                    className="absolute inset-0 rounded-full glass-loader-fill animate-spin-slow opacity-80"
                    style={{
                      maskImage: "radial-gradient(transparent 60%, black 61%)",
                      WebkitMaskImage:
                        "radial-gradient(transparent 60%, black 61%)",
                    }}
                  ></div>
                  <div className="flex flex-col items-center z-10">
                    <span className="text-2xl font-bold text-white">75%</span>
                    <span className="text-[10px] text-accent font-semibold tracking-wider uppercase">
                      Syncing
                    </span>
                  </div>
                  <div className="absolute inset-0 rounded-full bg-primary/20 blur-xl animate-pulse-slow -z-10"></div>
                </div>
                <div className="flex flex-1 flex-col gap-3 w-full">
                  <div>
                    <h3 className="text-white text-xl font-bold">
                      Cloud Vault Sync
                    </h3>
                    <p className="text-slate-400 text-xs mt-1">
                      Synchronizing 4.2GB of encrypted genealogy data.
                    </p>
                  </div>
                  <div className="space-y-2 mt-1">
                    <div className="flex justify-between text-xs">
                      <span className="text-slate-400">Photos</span>
                      <span className="text-white font-medium">
                        {photosSynced.toLocaleString()} /{" "}
                        {totalPhotos.toLocaleString()}
                      </span>
                    </div>
                    <div className="w-full bg-white/5 rounded-full h-1.5">
                      <div
                        className="bg-primary h-1.5 rounded-full"
                        style={{
                          width: `${(photosSynced / totalPhotos) * 100}%`,
                        }}
                      ></div>
                    </div>
                    <div className="flex justify-between text-xs pt-1">
                      <span className="text-slate-400">Documents</span>
                      <span className="text-white font-medium">420 / 420</span>
                    </div>
                    <div className="w-full bg-white/5 rounded-full h-1.5">
                      <div
                        className="bg-accent h-1.5 rounded-full"
                        style={{ width: "100%" }}
                      ></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div className="col-span-1">
            <div className="glass-card h-full rounded-2xl p-4 flex flex-col justify-between relative overflow-hidden group">
              <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-16 h-16 bg-accent/20 rounded-full blur-2xl group-hover:bg-accent/30 transition-all duration-500"></div>
              <div className="relative z-10 bg-white/5 w-10 h-10 rounded-xl flex items-center justify-center border border-white/10 mb-3">
                <span className="material-symbols-outlined text-accent animate-heartbeat">
                  shield_lock
                </span>
              </div>
              <div className="relative z-10">
                <h4 className="text-slate-200 text-sm font-semibold mb-1">
                  Local Encryption
                </h4>
                <p className="text-accent text-xs font-bold uppercase tracking-wide flex items-center gap-1">
                  <span className="w-1.5 h-1.5 rounded-full bg-accent"></span>{" "}
                  Active
                </p>
                <p className="text-slate-500 text-[10px] mt-2 leading-tight">
                  AES-256 enabled on device.
                </p>
              </div>
            </div>
          </div>
          <div className="col-span-1">
            <div className="glass-card h-full rounded-2xl p-4 flex flex-col justify-between">
              <div className="bg-white/5 w-10 h-10 rounded-xl flex items-center justify-center border border-white/10 mb-3">
                <span className="material-symbols-outlined text-primary">
                  hard_drive
                </span>
              </div>
              <div>
                <h4 className="text-slate-200 text-sm font-semibold mb-1">
                  Vault Storage
                </h4>
                <div className="flex items-baseline gap-1">
                  <span className="text-white text-lg font-bold">
                    {vaultUsage.toFixed(1)}
                  </span>
                  <span className="text-slate-400 text-xs">GB Used</span>
                </div>
                <div className="w-full bg-white/10 rounded-full h-1 mt-3">
                  <div
                    className="bg-gradient-to-r from-primary to-accent h-1 rounded-full"
                    style={{ width: `${(vaultUsage / vaultCapacity) * 100}%` }}
                  ></div>
                </div>
              </div>
            </div>
          </div>
          <div className="col-span-2">
            <div className="glass-card rounded-2xl p-5 relative overflow-hidden flex items-center gap-4">
              <div className="absolute right-0 top-0 bottom-0 w-1/3 bg-gradient-to-l from-primary/10 to-transparent pointer-events-none"></div>
              <div className="relative flex-shrink-0 w-12 h-12 flex items-center justify-center">
                <svg
                  className="animate-spin-slow w-full h-full text-white/20"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="1"
                  viewBox="0 0 24 24"
                >
                  <path d="M12 2v4M12 18v4M4.93 4.93l2.83 2.83M16.24 16.24l2.83 2.83M2 12h4M18 12h4M4.93 19.07l2.83-2.83M16.24 7.76l2.83-2.83"></path>
                </svg>
                <span className="material-symbols-outlined text-white absolute text-[20px]">
                  auto_fix_high
                </span>
              </div>
              <div className="flex-1 min-w-0">
                <div className="flex items-center justify-between mb-1">
                  <h4 className="text-white text-sm font-semibold truncate">
                    Background AI Tasks
                  </h4>
                  <span className="text-xs text-primary font-mono bg-primary/10 px-2 py-0.5 rounded border border-primary/20">
                    Running
                  </span>
                </div>
                <p className="text-slate-400 text-xs truncate">
                  Restoring 14 faded photos &amp; colorizing
                </p>
              </div>
            </div>
          </div>
          <div className="col-span-2 space-y-3 mt-2">
            <h3 className="text-xs font-bold text-slate-500 uppercase tracking-widest pl-2">
              Sync Preferences
            </h3>
            <div className="glass-card rounded-xl p-4 flex items-center justify-between">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-slate-400">
                  wifi_off
                </span>
                <div>
                  <p className="text-white text-sm font-medium">Offline Mode</p>
                  <p className="text-slate-500 text-xs">
                    Pause sync when not on Wi-Fi
                  </p>
                </div>
              </div>
              <label className="relative inline-flex items-center cursor-pointer">
                <input
                  type="checkbox"
                  checked={offlineMode}
                  onChange={() => setOfflineMode(!offlineMode)}
                  className="sr-only peer"
                />
                <div className="w-11 h-6 bg-slate-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary"></div>
              </label>
            </div>
            <div className="glass-card rounded-xl p-4 flex items-center justify-between">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-slate-400">
                  rocket_launch
                </span>
                <div>
                  <p className="text-white text-sm font-medium">
                    High-Speed Sync
                  </p>
                  <p className="text-slate-500 text-xs">
                    Use more battery for faster upload
                  </p>
                </div>
              </div>
              <label className="relative inline-flex items-center cursor-pointer">
                <input
                  type="checkbox"
                  checked={highSpeedSync}
                  onChange={() => setHighSpeedSync(!highSpeedSync)}
                  className="sr-only peer"
                />
                <div className="w-11 h-6 bg-slate-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary"></div>
              </label>
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}

export default VaultHealthScreen;
