import { useNavigate } from "react-router-dom";
import "./LegacyPlanningScreen.css";

function LegacyPlanningScreen() {
  const navigate = useNavigate();

  return (
    <div className="font-display bg-background-dark text-white overflow-hidden h-screen w-full relative mesh-gradient">
      {/* Header */}
      <header className="pt-12 px-6 pb-4 flex justify-between items-center z-20 relative">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Legacy Planning</h1>
          <p className="text-sm text-gray-400">
            Configure your digital afterlife
          </p>
        </div>
        <div className="glass-panel p-2 rounded-full relative">
          <span className="material-symbols-outlined text-gray-300">
            lock_person
          </span>
        </div>
      </header>

      {/* Main Content */}
      <main className="flex-1 overflow-y-auto px-6 pb-24 scrollbar-hide z-10 relative h-[calc(100vh-160px)]">
        {/* Legacy Readiness Card */}
        <div className="glass-panel rounded-2xl p-5 mb-6 relative overflow-hidden">
          <div className="flex justify-between items-end mb-2 relative z-10">
            <div>
              <span className="text-xs text-primary font-bold uppercase tracking-wider">
                Legacy Readiness
              </span>
              <h2 className="text-3xl font-bold mt-1">82%</h2>
            </div>
            <span className="text-xs text-gray-400 mb-1">Almost Complete</span>
          </div>
          <div className="w-full bg-gray-700/50 rounded-full h-2 relative z-10">
            <div
              className="bg-gradient-to-r from-primary to-accent h-2 rounded-full"
              style={{ width: "82%" }}
            ></div>
          </div>
          <div className="absolute -right-6 -top-6 w-32 h-32 bg-primary/20 blur-3xl rounded-full"></div>
        </div>

        {/* Designated Trustees Section */}
        <section className="mb-6">
          <div className="flex justify-between items-center mb-3">
            <h3 className="text-sm font-bold text-gray-300 uppercase tracking-wider">
              Designated Trustees
            </h3>
            <button className="w-8 h-8 rounded-full glass-panel-light flex items-center justify-center hover:bg-white/10 transition-colors">
              <span className="material-symbols-outlined text-sm">add</span>
            </button>
          </div>
          <div className="grid grid-cols-2 gap-3">
            <div className="glass-panel p-4 rounded-2xl relative group hover:bg-white/5 transition-colors cursor-pointer">
              <div className="flex items-start justify-between mb-3">
                <div className="w-10 h-10 rounded-full bg-gradient-to-br from-indigo-500 to-purple-600 p-[2px]">
                  <div className="w-full h-full rounded-full bg-gray-800 flex items-center justify-center">
                    <span className="text-xs font-bold">ER</span>
                  </div>
                </div>
                <span className="w-2 h-2 rounded-full bg-success shadow-[0_0_8px_#22c55e]"></span>
              </div>
              <h4 className="font-bold text-sm truncate">Elena Ricci</h4>
              <p className="text-[10px] text-gray-400 mt-0.5">
                Primary Trustee
              </p>
              <div className="mt-3 flex items-center gap-1 text-[10px] text-emerald-400 bg-emerald-500/10 px-2 py-1 rounded-md w-fit">
                <span className="material-symbols-outlined text-[10px]">
                  check_circle
                </span>
                Verified
              </div>
            </div>
            <div className="glass-panel p-4 rounded-2xl relative group hover:bg-white/5 transition-colors cursor-pointer">
              <div className="flex items-start justify-between mb-3">
                <div className="w-10 h-10 rounded-full bg-gradient-to-br from-orange-400 to-red-500 p-[2px]">
                  <div className="w-full h-full rounded-full bg-gray-800 flex items-center justify-center">
                    <span className="text-xs font-bold">MR</span>
                  </div>
                </div>
                <span className="w-2 h-2 rounded-full bg-gray-600"></span>
              </div>
              <h4 className="font-bold text-sm truncate">Marco Ricci</h4>
              <p className="text-[10px] text-gray-400 mt-0.5">
                Secondary Trustee
              </p>
              <div className="mt-3 flex items-center gap-1 text-[10px] text-gray-400 bg-white/5 px-2 py-1 rounded-md w-fit">
                <span className="material-symbols-outlined text-[10px]">
                  hourglass_empty
                </span>
                Pending
              </div>
            </div>
          </div>
        </section>

        {/* Inheritance Rules Section */}
        <section className="mb-6">
          <h3 className="text-sm font-bold text-gray-300 uppercase tracking-wider mb-3">
            Inheritance Rules
          </h3>
          <div className="glass-panel rounded-2xl p-4 mb-3">
            <div className="flex items-center gap-4">
              <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-rose-500/20 to-pink-500/20 flex items-center justify-center shrink-0 border border-rose-500/10">
                <span className="material-symbols-outlined text-rose-400">
                  timer_off
                </span>
              </div>
              <div className="flex-1 min-w-0">
                <h4 className="font-bold text-base text-white truncate">
                  Inactivity Timer
                </h4>
                <p className="text-xs text-gray-400 mt-0.5 truncate">
                  Trigger after 12 months silence
                </p>
              </div>
              <div className="flex items-center">
                <label className="relative inline-flex items-center cursor-pointer">
                  <input
                    class="sr-only peer"
                    type="checkbox"
                    value=""
                    defaultChecked
                  />
                  <div className="w-9 h-5 bg-gray-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-4 after:w-4 after:transition-all peer-checked:bg-primary"></div>
                </label>
              </div>
            </div>
          </div>
          <div className="glass-panel rounded-2xl p-4">
            <div className="flex items-center gap-4">
              <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-cyan-500/20 to-blue-500/20 flex items-center justify-center shrink-0 border border-cyan-500/10">
                <span className="material-symbols-outlined text-cyan-400">
                  verified_user
                </span>
              </div>
              <div className="flex-1 min-w-0">
                <h4 className="font-bold text-base text-white truncate">
                  Consensus Protocol
                </h4>
                <p className="text-xs text-gray-400 mt-0.5 truncate">
                  Requires 2/3 trustee approval
                </p>
              </div>
              <span className="material-symbols-outlined text-gray-500">
                chevron_right
              </span>
            </div>
          </div>
        </section>

        {/* Final Message Section */}
        <section className="mb-20">
          <h3 className="text-sm font-bold text-gray-300 uppercase tracking-wider mb-3">
            Final Message
          </h3>
          <div className="glass-panel rounded-2xl p-1 overflow-hidden relative">
            <div className="bg-black/40 rounded-xl overflow-hidden relative h-32 flex items-center justify-center group cursor-pointer">
              <div className="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent opacity-80 z-10"></div>
              <div className="w-12 h-12 rounded-full bg-white/10 backdrop-blur-md flex items-center justify-center z-20 group-hover:scale-110 transition-transform border border-white/20">
                <span className="material-symbols-outlined text-white">
                  play_arrow
                </span>
              </div>
              <div className="absolute bottom-3 left-3 z-20">
                <h4 className="text-sm font-bold text-white">My Last Words</h4>
                <p className="text-[10px] text-gray-300">
                  Recorded Oct 24, 2023 • 04:21
                </p>
              </div>
              <div className="absolute bottom-0 left-0 right-0 h-16 flex items-end justify-center gap-[2px] opacity-30 z-0 px-4 pb-2">
                <div className="w-1 bg-white h-4 rounded-t-sm"></div>
                <div className="w-1 bg-white h-8 rounded-t-sm"></div>
                <div className="w-1 bg-white h-6 rounded-t-sm"></div>
                <div className="w-1 bg-white h-10 rounded-t-sm"></div>
                <div className="w-1 bg-white h-5 rounded-t-sm"></div>
                <div className="w-1 bg-white h-12 rounded-t-sm"></div>
                <div className="w-1 bg-white h-8 rounded-t-sm"></div>
                <div className="w-1 bg-white h-4 rounded-t-sm"></div>
              </div>
            </div>
            <div className="p-3 flex gap-2">
              <button className="flex-1 bg-white/5 hover:bg-white/10 p-2 rounded-lg flex items-center justify-center gap-2 transition-colors text-xs font-medium text-gray-300">
                <span className="material-symbols-outlined text-sm">mic</span>{" "}
                Re-record
              </button>
              <button className="flex-1 bg-white/5 hover:bg-white/10 p-2 rounded-lg flex items-center justify-center gap-2 transition-colors text-xs font-medium text-gray-300">
                <span className="material-symbols-outlined text-sm">
                  videocam
                </span>{" "}
                Add Video
              </button>
            </div>
          </div>
        </section>
      </main>
    </div>
  );
}

export default LegacyPlanningScreen;
