import { useNavigate } from "react-router-dom";
import "./AdminScreen.css";

/**
 * Admin Screen
 *
 * Converted from Stitch: aevum_admin_infrastructure_1/code.html
 * System administration and deployment dashboard.
 * This screen provides a high-level overview of the Aevum deployment and infrastructure.
 * Based on Stitch screen: aevum_admin_infrastructure_1 (Aevum Deployment Center)
 */
function AdminScreen() {
  const navigate = useNavigate();

  return (
    <div className="admin-screen-container bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-white antialiased selection:bg-primary selection:text-white min-h-screen flex flex-col">
      <div className="ambient-glow"></div>
      <header className="sticky top-0 z-50 flex items-center justify-between p-5 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-xl border-b border-white/5">
        <div className="flex items-center gap-3">
          <div className="flex items-center justify-center size-10 rounded-xl bg-gradient-to-br from-primary/20 to-accent/20 text-primary border border-white/5">
            <span className="material-symbols-outlined text-[24px]">
              rocket_launch
            </span>
          </div>
          <div>
            <h1 className="text-lg font-bold leading-tight tracking-tight">
              Deployment
            </h1>
            <div className="flex items-center gap-1.5">
              <span className="status-dot bg-success status-pulse"></span>
              <span className="text-xs font-medium text-slate-500 dark:text-slate-400">
                Live: Alpha v0.9.2
              </span>
            </div>
          </div>
        </div>
        <button
          className="flex items-center justify-center size-9 rounded-full hover:bg-white/5 transition-colors text-slate-400 hover:text-white"
          onClick={() => navigate(-1)}
        >
          <span className="material-symbols-outlined text-[20px]">
            arrow_back
          </span>
        </button>
      </header>

      <main className="flex-1 p-5 flex flex-col gap-4 w-full max-w-md mx-auto relative z-10 pb-24">
        <div className="grid grid-cols-2 gap-3">
          <div className="glass-card p-4 rounded-2xl col-span-2 relative overflow-hidden group">
            <div className="absolute top-0 right-0 p-4 opacity-50">
              <span className="material-symbols-outlined text-4xl text-primary/20 group-hover:scale-110 transition-transform duration-500">
                build_circle
              </span>
            </div>
            <div className="flex justify-between items-start mb-2 relative z-10">
              <span className="text-xs font-bold text-slate-400 uppercase tracking-wider">
                Current Build
              </span>
              <span className="glass-tag px-2 py-0.5 rounded text-[10px] text-success font-mono border-success/30 bg-success/10">
                PASSING
              </span>
            </div>
            <h3 className="text-2xl font-bold mb-1 font-mono tracking-tight">
              build-8924x
            </h3>
            <div className="text-xs text-slate-400 mb-4 font-mono">
              Commit: <span className="text-white">7f2a9c</span> • Master Branch
            </div>
            <div className="space-y-3">
              <div className="flex justify-between text-xs text-slate-300">
                <span>Unit Tests</span>
                <span className="text-success">142/142</span>
              </div>
              <div className="progress-bar-bg h-1.5 w-full">
                <div
                  className="progress-bar-fill bg-success"
                  style={{ width: "100%" }}
                ></div>
              </div>
              <div className="flex justify-between text-xs text-slate-300">
                <span>Integration</span>
                <span>Running...</span>
              </div>
              <div className="progress-bar-bg h-1.5 w-full">
                <div
                  className="progress-bar-fill animate-pulse"
                  style={{ width: "65%" }}
                ></div>
              </div>
            </div>
          </div>

          <div className="glass-card p-4 rounded-2xl flex flex-col justify-between glass-card-hover transition-all">
            <div className="flex items-center gap-2 mb-2 text-slate-400">
              <span className="material-symbols-outlined text-[18px]">
                ios_share
              </span>
              <span className="text-xs font-bold uppercase tracking-wider">
                App Store
              </span>
            </div>
            <div className="flex-1 flex flex-col justify-end">
              <div className="text-2xl font-bold mb-0.5">Syncing</div>
              <div className="text-[10px] text-slate-400">
                Processing binary...
              </div>
              <div className="mt-2 flex items-center gap-1 text-[10px] text-primary">
                <span className="material-symbols-outlined text-[12px] animate-spin">
                  sync
                </span>
                <span>Estimated 4m</span>
              </div>
            </div>
          </div>

          <div className="glass-card p-4 rounded-2xl flex flex-col justify-between glass-card-hover transition-all">
            <div className="flex items-center gap-2 mb-2 text-slate-400">
              <span className="material-symbols-outlined text-[18px]">
                group_add
              </span>
              <span className="text-xs font-bold uppercase tracking-wider">
                Testers
              </span>
            </div>
            <div className="flex-1 flex flex-col justify-end">
              <div className="flex items-baseline gap-1">
                <span className="text-2xl font-bold">128</span>
                <span className="text-xs text-success font-medium">+12%</span>
              </div>
              <div className="text-[10px] text-slate-400">
                Active Alpha Users
              </div>
              <div className="mt-2 flex -space-x-2">
                <div className="w-5 h-5 rounded-full bg-slate-700 border border-slate-800"></div>
                <div className="w-5 h-5 rounded-full bg-slate-600 border border-slate-800"></div>
                <div className="w-5 h-5 rounded-full bg-slate-500 border border-slate-800"></div>
              </div>
            </div>
          </div>

          <div className="glass-card p-4 rounded-2xl col-span-2">
            <div className="flex justify-between items-center mb-4">
              <div className="flex items-center gap-2 text-slate-400">
                <span className="material-symbols-outlined text-[18px]">
                  bug_report
                </span>
                <span className="text-xs font-bold uppercase tracking-wider">
                  Crash Analytics
                </span>
              </div>
              <span className="text-[10px] text-slate-500">Last 24h</span>
            </div>
            <div className="flex items-end gap-1 h-16 mb-2 px-1">
              <div className="flex-1 bg-white/5 hover:bg-primary/50 transition-colors rounded-t-sm h-[20%]"></div>
              <div className="flex-1 bg-white/5 hover:bg-primary/50 transition-colors rounded-t-sm h-[40%]"></div>
              <div className="flex-1 bg-white/5 hover:bg-primary/50 transition-colors rounded-t-sm h-[10%]"></div>
              <div className="flex-1 bg-white/5 hover:bg-primary/50 transition-colors rounded-t-sm h-[30%]"></div>
              <div className="flex-1 bg-white/5 hover:bg-primary/50 transition-colors rounded-t-sm h-[80%] relative group">
                <div className="absolute -top-6 left-1/2 -translate-x-1/2 bg-slate-800 text-white text-[9px] px-1.5 py-0.5 rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap">
                  Peak: 12ms
                </div>
              </div>
              <div className="flex-1 bg-white/5 hover:bg-primary/50 transition-colors rounded-t-sm h-[25%]"></div>
              <div className="flex-1 bg-white/5 hover:bg-primary/50 transition-colors rounded-t-sm h-[15%]"></div>
              <div className="flex-1 bg-white/5 hover:bg-primary/50 transition-colors rounded-t-sm h-[5%]"></div>
            </div>
            <div className="flex justify-between text-xs items-center">
              <span className="text-success font-medium flex items-center gap-1">
                <span className="material-symbols-outlined text-[14px]">
                  trending_down
                </span>
                99.8% Stability
              </span>
              <span className="text-slate-500">0 Critical</span>
            </div>
          </div>

          <div className="glass-card p-4 rounded-2xl col-span-2">
            <div className="flex justify-between items-center mb-3">
              <div className="flex items-center gap-2 text-slate-400">
                <span className="material-symbols-outlined text-[18px]">
                  forum
                </span>
                <span className="text-xs font-bold uppercase tracking-wider">
                  Alpha Feedback
                </span>
              </div>
              <button className="text-[10px] text-primary hover:text-primary/80">
                View All
              </button>
            </div>
            <div className="space-y-3">
              <div className="flex gap-3 items-start p-2 rounded-lg hover:bg-white/5 transition-colors cursor-pointer">
                <div className="w-8 h-8 rounded-full bg-gradient-to-tr from-orange-400 to-pink-500 flex items-center justify-center text-[10px] font-bold text-white shrink-0">
                  JD
                </div>
                <div className="flex-1 min-w-0">
                  <div className="flex justify-between mb-0.5">
                    <span className="text-sm font-medium truncate">
                      UI Glitch in Family Tree
                    </span>
                    <span className="text-[10px] text-slate-500 shrink-0">
                      2m ago
                    </span>
                  </div>
                  <p className="text-xs text-slate-400 line-clamp-1">
                    The connecting lines disappear when zooming out rapidly...
                  </p>
                </div>
              </div>
              <div className="flex gap-3 items-start p-2 rounded-lg hover:bg-white/5 transition-colors cursor-pointer">
                <div className="w-8 h-8 rounded-full bg-gradient-to-tr from-blue-400 to-cyan-500 flex items-center justify-center text-[10px] font-bold text-white shrink-0">
                  AS
                </div>
                <div className="flex-1 min-w-0">
                  <div className="flex justify-between mb-0.5">
                    <span className="text-sm font-medium truncate">
                      Photo Upload Failed
                    </span>
                    <span className="text-[10px] text-slate-500 shrink-0">
                      1h ago
                    </span>
                  </div>
                  <p className="text-xs text-slate-400 line-clamp-1">
                    Getting a 504 error when uploading HEIC files specifically.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>

      <div className="fixed bottom-0 left-0 right-0 p-5 bg-gradient-to-t from-background-dark via-background-dark/95 to-transparent z-20 max-w-md mx-auto">
        <div className="flex gap-3">
          <button className="flex-1 bg-white/5 hover:bg-white/10 text-slate-300 font-medium py-3.5 rounded-xl border border-white/10 transition-all flex items-center justify-center gap-2">
            <span className="material-symbols-outlined text-[20px]">
              history
            </span>
            <span className="text-sm">Rollback</span>
          </button>
          <button className="flex-[2] bg-danger hover:bg-danger/90 text-white font-bold py-3.5 rounded-xl transition-all shadow-[0_0_20px_rgba(239,68,68,0.3)] flex items-center justify-center gap-2 group">
            <span className="material-symbols-outlined text-[20px] group-hover:rotate-180 transition-transform duration-500">
              emergency
            </span>
            <span className="text-sm">Deploy Hotfix</span>
          </button>
        </div>
        <p className="text-center mt-3 text-[10px] text-slate-500 font-mono">
          Production environment: eu-central-1
        </p>
      </div>
    </div>
  );
}

export default AdminScreen;
