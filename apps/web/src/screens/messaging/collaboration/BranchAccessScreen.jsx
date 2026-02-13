import { useNavigate } from "react-router-dom";
import BottomNav from "@/components/BottomNav";
import "./BranchAccessScreen.css";

function BranchAccessScreen() {
  const navigate = useNavigate();

  return (
    <div className="font-display bg-background-dark text-white overflow-hidden h-screen w-full relative mesh-gradient">
      <header className="pt-12 px-6 pb-4 flex justify-between items-center z-20 relative">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Branch Access</h1>
          <p className="text-sm text-gray-400">
            Messenger Permission & Approval
          </p>
        </div>
        <div className="glass-panel p-2 rounded-full relative">
          <div className="absolute top-0 right-0 w-2.5 h-2.5 bg-danger rounded-full border-2 border-[#151e29]"></div>
          <span className="material-symbols-outlined text-gray-300">
            notifications
          </span>
        </div>
      </header>
      <main className="flex-1 overflow-y-auto px-6 pb-24 scrollbar-hide z-10 relative h-[calc(100vh-160px)]">
        <div className="glass-panel rounded-2xl p-5 mb-6 relative overflow-hidden border-l-4 border-l-accent">
          <div className="flex items-center gap-4 mb-4">
            <div className="relative">
              <div className="w-16 h-16 rounded-full bg-gradient-to-br from-indigo-500 to-purple-600 p-[2px] shadow-lg shadow-indigo-500/20">
                <img
                  alt="Profile"
                  className="w-full h-full rounded-full object-cover"
                  src="https://lh3.googleusercontent.com/aida-public/AB6AXuCSeNl96rnAGvnl8VULDvCxCHk6wq4X2kDe18_FiLcwrtEv7Rc8GDMCMGx1sRuAuWwZhTxiB6EV86kG-mfdhPkgz4bORr1QMMRQC2vWKtkt67Y9aCngw0PZqyHALGjG2TqqHi1WEM4Pk-RrLGnxlZXEsHj1BesJM-E0S2jmf0T0hTimgSBB2OIqlthGj_ynoljnT87pTyDZw_j-osKfwusJc9AhGNoe6r_2YdJ4YXahMAfR84LLuPuKNFsxKXPq8F9ggLkhArCZ4A8"
                />
              </div>
              <div className="absolute -bottom-1 -right-1 bg-gray-900 rounded-full p-1 border border-gray-700">
                <span className="material-symbols-outlined text-sm text-accent">
                  mail
                </span>
              </div>
            </div>
            <div>
              <h2 className="text-xl font-bold text-white">Lucas Vance</h2>
              <div className="flex items-center gap-1.5 mt-1">
                <span className="px-2 py-0.5 rounded-md bg-indigo-500/20 text-indigo-300 text-[10px] font-bold uppercase tracking-wide border border-indigo-500/20">
                  Step-Sibling
                </span>
                <span className="w-1 h-1 rounded-full bg-gray-500"></span>
                <span className="text-xs text-gray-400">Requesting DM</span>
              </div>
            </div>
          </div>
          <div className="bg-gray-900/40 rounded-xl p-3 mb-4 backdrop-blur-sm border border-white/5">
            <p className="text-sm text-gray-300 italic">
              "Hey! I found some old photos of dad from the 90s. I'd love to
              share them directly with you. Can I get access to chat?"
            </p>
          </div>
          <div className="grid grid-cols-2 gap-2 mb-2">
            <div className="bg-white/5 rounded-lg p-2 flex items-center gap-2 border border-white/5">
              <span className="material-symbols-outlined text-success text-sm">
                verified_user
              </span>
              <div>
                <p className="text-[10px] text-gray-400 uppercase font-bold">
                  Status
                </p>
                <p className="text-xs font-semibold text-white">
                  Spouse-Approved
                </p>
              </div>
            </div>
            <div className="bg-white/5 rounded-lg p-2 flex items-center gap-2 border border-white/5">
              <span className="material-symbols-outlined text-accent text-sm">
                family_history
              </span>
              <div>
                <p className="text-[10px] text-gray-400 uppercase font-bold">
                  Branch
                </p>
                <p className="text-xs font-semibold text-white">Vance-Ricci</p>
              </div>
            </div>
          </div>
        </div>
        <section className="mb-6">
          <h3 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-3 ml-1 flex items-center gap-2">
            <span className="material-symbols-outlined text-sm">security</span>
            Branch Validation
          </h3>
          <div className="glass-panel rounded-2xl p-4 mb-3">
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-full bg-gradient-to-br from-emerald-500 to-teal-600 p-[1px]">
                  <img
                    className="w-full h-full rounded-full bg-gray-900 object-cover"
                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuDK30FOq7chXsj5agOuhHJiN3vjzrRk3E-rCIwuFdNJ5I0s99irQUcuGC48GqQcZWW9FcPJ7aydBv0uUFCFG5xtUQXJn00SFdkfXzHS6WCnx-LGEKfP9JBufroXLD1aCYUA64iMhm1lTSXXbTRC_AmHTNXNwNUEEndNFQ2MY9d5ceE7mEjSbHWE6b6pADKPvbDbcAriPa0p1hyyG1wDGTtwDPQEZFw5VdIEYJa7zSF64A8jMYog4d_4GoXshKVBQQ6tT792mJlON4U"
                  />
                </div>
                <div>
                  <p className="text-sm font-bold text-white">Sarah Ricci</p>
                  <p className="text-[10px] text-emerald-400 font-medium">
                    Mother • Verified
                  </p>
                </div>
              </div>
              <span className="material-symbols-outlined text-success">
                check_circle
              </span>
            </div>
            <div className="ml-5 border-l-2 border-dashed border-gray-700 pl-8 pb-4 relative h-6">
              <div className="absolute left-[-5px] top-[50%] w-2 h-2 rounded-full bg-gray-700"></div>
            </div>
            <div className="glass-panel-locked rounded-xl p-3 flex items-center justify-between opacity-70">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-full bg-gray-700 flex items-center justify-center border border-gray-600">
                  <span className="material-symbols-outlined text-gray-400 text-lg">
                    lock
                  </span>
                </div>
                <div>
                  <p className="text-sm font-bold text-gray-400">
                    Unknown Parent
                  </p>
                  <p className="text-[10px] text-gray-500 font-medium">
                    Out-of-wedlock Branch
                  </p>
                </div>
              </div>
              <div className="bg-gray-800/80 px-2 py-1 rounded text-[10px] text-gray-400 border border-gray-700 font-mono">
                HIDDEN
              </div>
            </div>
          </div>
          <div className="glass-panel rounded-2xl p-4 flex items-center gap-4 border-l-2 border-l-gold/50">
            <div className="w-10 h-10 rounded-xl bg-gold/10 flex items-center justify-center shrink-0 border border-gold/20">
              <span className="material-symbols-outlined text-gold">
                admin_panel_settings
              </span>
            </div>
            <div className="flex-1 min-w-0">
              <h4 className="font-bold text-sm text-white truncate">
                Strict Approval
              </h4>
              <p className="text-[10px] text-gray-400 mt-0.5">
                Required for incomplete lineage
              </p>
            </div>
            <div className="flex items-center">
              <label className="relative inline-flex items-center cursor-pointer">
                <input
                  type="checkbox"
                  value=""
                  className="sr-only peer"
                  defaultChecked
                />
                <div className="w-11 h-6 bg-gray-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-gold"></div>
              </label>
            </div>
          </div>
        </section>
        <section className="mb-24">
          <div className="grid grid-cols-1 gap-3">
            <button
              className="w-full bg-primary hover:bg-blue-600 text-white font-bold py-4 px-6 rounded-2xl flex items-center justify-center gap-3 transition-all glow-button group"
              onClick={() => navigate("/messages/collab/lucas-vance")}
            >
              <span className="material-symbols-outlined group-hover:scale-110 transition-transform">
                chat_bubble
              </span>
              Authorize Direct Message
            </button>
            <div className="grid grid-cols-2 gap-3">
              <button className="glass-panel-light hover:bg-white/10 text-gray-200 font-medium py-3 px-4 rounded-xl flex items-center justify-center gap-2 transition-all border border-white/10">
                <span className="material-symbols-outlined text-sm">
                  group_add
                </span>
                <span className="text-xs">Add to Branch Chat</span>
              </button>
              <button className="glass-panel-danger hover:bg-red-900/30 text-red-200 font-medium py-3 px-4 rounded-xl flex items-center justify-center gap-2 transition-all">
                <span className="material-symbols-outlined text-sm">block</span>
                <span className="text-xs">Restrict Access</span>
              </button>
            </div>
          </div>
          <p className="text-center text-[10px] text-gray-500 mt-4">
            <span className="material-symbols-outlined text-[10px] align-middle mr-1">
              encrypted
            </span>
            End-to-end encrypted approval chain
          </p>
        </section>
      </main>
      <BottomNav />
    </div>
  );
}

export default BranchAccessScreen;
