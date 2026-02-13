import { useNavigate } from "react-router-dom";
import BottomNav from "@/components/BottomNav";
import "./ApprovalHubScreen.css";

function ApprovalHubScreen() {
  const navigate = useNavigate();

  return (
    <div className="font-display bg-background-dark text-white overflow-hidden h-screen w-full relative mesh-gradient">
      <header className="pt-12 px-6 pb-4 flex justify-between items-center z-20 relative">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Approval Hub</h1>
          <p className="text-sm text-gray-400">Review pending updates</p>
        </div>
        <div className="glass-panel p-2 rounded-full relative">
          <span className="absolute top-2 right-2 w-2.5 h-2.5 bg-danger rounded-full border-2 border-[#101922] animate-pulse"></span>
          <span className="material-symbols-outlined text-gray-300">
            notifications
          </span>
        </div>
      </header>

      <main className="flex-1 overflow-y-auto px-6 pb-32 scrollbar-hide z-10 relative h-[calc(100vh-160px)]">
        {/* Stats Grid */}
        <div className="grid grid-cols-2 gap-3 mb-6">
          <div className="glass-panel p-4 rounded-2xl flex flex-col justify-between h-32 hover:bg-white/5 transition-colors cursor-pointer">
            <div className="w-10 h-10 rounded-full bg-blue-500/20 flex items-center justify-center text-blue-400 mb-2">
              <span className="material-symbols-outlined">person_add</span>
            </div>
            <div>
              <span className="text-2xl font-bold block">12</span>
              <span className="text-xs text-gray-400 font-medium uppercase tracking-wide">
                Member Requests
              </span>
            </div>
          </div>
          <div className="glass-panel p-4 rounded-2xl flex flex-col justify-between h-32 hover:bg-white/5 transition-colors cursor-pointer">
            <div className="w-10 h-10 rounded-full bg-purple-500/20 flex items-center justify-center text-purple-400 mb-2">
              <span className="material-symbols-outlined">smart_toy</span>
            </div>
            <div>
              <span className="text-2xl font-bold block">86</span>
              <span className="text-xs text-gray-400 font-medium uppercase tracking-wide">
                AI Suggestions
              </span>
            </div>
          </div>
        </div>

        {/* New Member Requests */}
        <section className="mb-6">
          <div className="flex justify-between items-center mb-3">
            <h3 className="text-sm font-bold text-gray-300 uppercase tracking-wider">
              New Member Requests
            </h3>
            <span className="text-xs text-primary font-medium cursor-pointer hover:text-blue-300 transition-colors">
              View All (3)
            </span>
          </div>
          <div className="glass-panel p-4 rounded-2xl mb-3">
            <div className="flex items-start gap-4 mb-4">
              <div className="relative">
                <img
                  alt="User Profile"
                  className="w-12 h-12 rounded-full object-cover ring-2 ring-white/10"
                  src="https://lh3.googleusercontent.com/aida-public/AB6AXuARbdC-_YtWtO3zX5uZJvatpys5wwbvW8zJM5x2liNna2UeAHA9ksDZfAsf6xf6nzzX6HgJmT50IImVuzUdD_o4KNzaXlhVITntxpEvE-u10Ins4YcdQZXJH3xSCBM4iQqH-T3AOXcSu7QD7p2-GjpFZZtaQuNEWVMghBbFmgz2vHIc-xf8zqjU_A3iDChEPjr_LXXkav8WmwaPm2B1dhCUzDo5mRJQbScRjLVoP4eG7nRH-R50EtqUn42DTEZVAccQXg93U22yP9A"
                />
                <div className="absolute -bottom-1 -right-1 bg-green-500 rounded-full p-0.5 border border-[#101922]">
                  <span className="material-symbols-outlined text-[10px] text-white block">
                    check
                  </span>
                </div>
              </div>
              <div className="flex-1">
                <h4 className="font-bold text-base">Marcus Ricci</h4>
                <p className="text-xs text-gray-400 mt-0.5">
                  Invited by Elena Ricci • Relation: Cousin
                </p>
                <div className="mt-2 flex items-center gap-1.5 text-xs text-gray-500 bg-white/5 w-fit px-2 py-1 rounded-md">
                  <span className="material-symbols-outlined text-[14px]">
                    mail
                  </span>
                  marcus.r@example.com
                </div>
              </div>
            </div>
            <div className="grid grid-cols-2 gap-3">
              <button className="py-2.5 rounded-xl bg-white/5 hover:bg-white/10 text-sm font-medium text-gray-300 transition-colors active:scale-[0.98]">
                Decline
              </button>
              <button className="py-2.5 rounded-xl bg-primary hover:bg-blue-600 text-sm font-medium text-white shadow-lg shadow-blue-500/20 transition-colors active:scale-[0.98]">
                Approve Access
              </button>
            </div>
          </div>
        </section>

        {/* AI Tag Confirmations */}
        <section className="mb-6">
          <div className="flex justify-between items-center mb-3">
            <h3 className="text-sm font-bold text-gray-300 uppercase tracking-wider">
              AI Tag Confirmations
            </h3>
            <div className="bg-purple-500/20 text-purple-300 text-[10px] px-2 py-0.5 rounded-full font-bold border border-purple-500/20">
              BETA
            </div>
          </div>
          <div className="glass-panel rounded-2xl overflow-hidden">
            <div className="relative h-48 w-full bg-black/40">
              <img
                alt="Vintage Photo"
                className="w-full h-full object-cover opacity-80"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuDyFb_aap00-1Bxx_9bvAK3wLkoRKF7u-vqIgigZSv3n2BaP4nAFMMPvRG5d7e-GikDsfEL8SPnNAXoslikw7Ke7OR9-zTSuNk6QA3uvW-lMO4Wb4WACNKq9uauUDbkR2OrH58MOAOdTKqU1lf0vHl_W-TIojjAIDlyZlW-_toxNya2mhals7ECMyDUY-CrG4wl_NNdBldrH_a5s-g8MY0do5bW0PZTl9n4vngdqI5WbbwqSfYEzrsk6CGagk04BfDQoEKp6RF7tWI"
              />
              <div className="absolute top-[20%] left-[35%] w-[30%] h-[40%] border-2 border-primary rounded-lg shadow-[0_0_15px_rgba(17,115,212,0.5)] bg-primary/10 flex items-start justify-end p-1 animate-pulse">
                <span className="bg-primary text-white text-[10px] font-bold px-1 rounded shadow-sm">
                  98% Match
                </span>
              </div>
              <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/90 to-transparent p-4">
                <p className="text-xs text-white/70">
                  Found in album "Summer 1924"
                </p>
              </div>
            </div>
            <div className="p-4">
              <div className="flex justify-between items-start mb-4">
                <div>
                  <p className="text-sm text-gray-400">Is this person</p>
                  <h4 className="font-bold text-lg text-white">
                    Isabella Moretti?
                  </h4>
                </div>
                <span className="material-symbols-outlined text-purple-400">
                  auto_awesome
                </span>
              </div>
              <div className="grid grid-cols-2 gap-3">
                <button className="flex items-center justify-center gap-2 py-2.5 rounded-xl bg-white/5 hover:bg-white/10 text-sm font-medium text-danger transition-colors border border-white/5 active:scale-[0.98]">
                  <span className="material-symbols-outlined text-lg">
                    close
                  </span>
                  No
                </button>
                <button className="flex items-center justify-center gap-2 py-2.5 rounded-xl bg-white/5 hover:bg-white/10 text-sm font-medium text-success transition-colors border border-success/30 bg-success/10 active:scale-[0.98]">
                  <span className="material-symbols-outlined text-lg">
                    check
                  </span>
                  Confirm
                </button>
              </div>
            </div>
          </div>
        </section>

        {/* Tree Data Suggestions */}
        <section className="mb-6">
          <h3 className="text-sm font-bold text-gray-300 uppercase tracking-wider mb-3">
            Tree Data Suggestions
          </h3>
          <div className="glass-panel p-4 rounded-2xl relative overflow-hidden group">
            <div className="absolute top-0 right-0 p-3 opacity-10 group-hover:opacity-20 transition-opacity">
              <span className="material-symbols-outlined text-6xl text-white">
                history_edu
              </span>
            </div>
            <div className="flex gap-3 mb-4 relative z-10">
              <div className="w-10 h-10 rounded-lg bg-orange-500/20 flex items-center justify-center text-orange-400 shrink-0">
                <span className="material-symbols-outlined">lightbulb</span>
              </div>
              <div>
                <h4 className="font-bold text-sm text-white">
                  Potential Birth Date Found
                </h4>
                <p className="text-xs text-gray-400 mt-1 leading-relaxed">
                  Census records from 1910 suggest{" "}
                  <span className="text-white font-medium">Giovanni Ricci</span>{" "}
                  was born on{" "}
                  <span className="text-white font-medium">Oct 14, 1892</span>,
                  not 1893.
                </p>
              </div>
            </div>
            <div className="flex items-center justify-between gap-3 pt-3 border-t border-white/5">
              <button className="text-xs text-gray-400 hover:text-white font-medium px-2">
                Dismiss
              </button>
              <button className="px-4 py-2 bg-white text-black text-xs font-bold rounded-lg shadow-lg hover:bg-gray-100 transition-colors active:scale-95">
                Update Record
              </button>
            </div>
          </div>
        </section>
      </main>
      <BottomNav />
    </div>
  );
}

export default ApprovalHubScreen;
