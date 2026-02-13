import { useNavigate } from "react-router-dom";
import BottomNav from "@/components/BottomNav";
import "./MessengerHubScreen.css";

function MessengerHubScreen() {
  const navigate = useNavigate();

  return (
    <div className="font-display bg-background-dark text-white overflow-hidden h-screen w-full relative mesh-gradient">
      <header className="pt-12 px-6 pb-4 flex justify-between items-center z-20 relative">
        <div>
          <h1 className="text-2xl font-bold tracking-tight text-white">
            Family Messenger
          </h1>
          <p className="text-sm text-gray-300 font-medium">
            Connect with your lineage
          </p>
        </div>
        <div className="glass-panel p-2 rounded-full relative">
          <span className="absolute top-1 right-2 w-2 h-2 bg-danger rounded-full z-10 border border-[#101922]"></span>
          <span className="material-symbols-outlined text-gray-200">
            notifications
          </span>
        </div>
      </header>
      <main className="flex-1 overflow-y-auto px-0 pb-24 scrollbar-hide z-10 relative h-[calc(100vh-160px)]">
        <section className="mb-6 px-6">
          <div className="flex justify-between items-center mb-3">
            <h3 className="text-sm font-bold text-gray-200 uppercase tracking-wider">
              Family Branches
            </h3>
            <button className="text-xs text-primary font-semibold hover:text-white transition-colors">
              View All
            </button>
          </div>
          <div className="flex overflow-x-auto gap-3 pb-4 scrollbar-hide snap-x snap-mandatory">
            <div
              className="snap-start shrink-0 w-36 h-44 glass-panel-active rounded-2xl p-4 flex flex-col justify-between relative cursor-pointer group"
              onClick={() => navigate("/branch/ricci")}
            >
              <div className="flex justify-between items-start">
                <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-indigo-500 to-primary flex items-center justify-center text-white font-bold text-lg shadow-lg">
                  R
                </div>
                <div className="flex flex-col items-end gap-1">
                  <span className="w-2 h-2 rounded-full bg-success shadow-[0_0_8px_#22c55e]"></span>
                  <span
                    className="material-symbols-outlined text-[16px] text-tier-full"
                    title="Full Access"
                  >
                    verified_user
                  </span>
                </div>
              </div>
              <div className="mt-2">
                <div className="inline-flex items-center px-1.5 py-0.5 rounded text-[9px] font-bold uppercase tracking-wide bg-emerald-500/20 text-emerald-300 border border-emerald-500/30 mb-1">
                  Full Access
                </div>
                <h4 className="font-bold text-base leading-tight text-white">
                  Ricci
                  <br />
                  Branch
                </h4>
                <p className="text-[10px] text-gray-300 mt-1 font-medium">
                  12 Active Members
                </p>
              </div>
            </div>
            <div className="snap-start shrink-0 w-36 h-44 glass-panel rounded-2xl p-4 flex flex-col justify-between relative cursor-pointer hover:bg-white/5 transition-colors">
              <div className="flex justify-between items-start">
                <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center text-white font-bold text-lg shadow-lg">
                  S
                </div>
                <div className="flex flex-col items-end gap-1">
                  <span
                    className="material-symbols-outlined text-[16px] text-tier-limited"
                    title="Limited Access"
                  >
                    gpp_maybe
                  </span>
                </div>
              </div>
              <div className="mt-2">
                <div className="inline-flex items-center px-1.5 py-0.5 rounded text-[9px] font-bold uppercase tracking-wide bg-amber-500/20 text-amber-300 border border-amber-500/30 mb-1">
                  Limited
                </div>
                <h4 className="font-bold text-base leading-tight text-gray-100">
                  Smith
                  <br />
                  Branch
                </h4>
                <p className="text-[10px] text-gray-400 mt-1 font-medium">
                  5 Active Members
                </p>
              </div>
            </div>
            <div className="snap-start shrink-0 w-36 h-44 glass-panel rounded-2xl p-4 flex flex-col justify-between relative cursor-pointer hover:bg-white/5 transition-colors">
              <div className="flex justify-between items-start">
                <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-orange-500 to-amber-600 flex items-center justify-center text-white font-bold text-lg shadow-lg">
                  C
                </div>
                <div className="flex flex-col items-end gap-1">
                  <span
                    className="material-symbols-outlined text-[16px] text-tier-limited"
                    title="Limited Access"
                  >
                    gpp_maybe
                  </span>
                </div>
              </div>
              <div className="mt-2">
                <div className="inline-flex items-center px-1.5 py-0.5 rounded text-[9px] font-bold uppercase tracking-wide bg-amber-500/20 text-amber-300 border border-amber-500/30 mb-1">
                  Limited
                </div>
                <h4 className="font-bold text-base leading-tight text-gray-100">
                  Chen
                  <br />
                  Branch
                </h4>
                <p className="text-[10px] text-gray-400 mt-1 font-medium">
                  8 Active Members
                </p>
              </div>
            </div>
            <div className="snap-start shrink-0 w-36 h-44 glass-panel-light rounded-2xl p-4 flex flex-col items-center justify-center text-center gap-2 relative border-dashed border-gray-500">
              <div className="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center">
                <span className="material-symbols-outlined text-gray-300">
                  add
                </span>
              </div>
              <p className="text-xs text-gray-300 font-medium">
                Join New
                <br />
                Branch
              </p>
            </div>
          </div>
        </section>
        <section className="mb-20 px-6">
          <h3 className="text-sm font-bold text-gray-200 uppercase tracking-wider mb-3">
            Recent Chats
          </h3>
          <div className="flex flex-col gap-3">
            <div
              className="glass-panel glow-new-message rounded-2xl p-4 cursor-pointer relative overflow-hidden group"
              onClick={() => navigate("/messages/chat/elena-ricci")}
            >
              <div className="absolute top-0 right-0 p-2 z-20">
                <span className="text-[10px] font-bold text-white bg-accent px-2 py-0.5 rounded-full shadow-lg shadow-accent/20">
                  NEW
                </span>
              </div>
              <div className="flex items-center gap-4 relative z-10">
                <div className="relative">
                  <div className="w-12 h-12 rounded-full bg-gradient-to-br from-indigo-600 to-purple-700 p-[2px]">
                    <img
                      alt="Elena Ricci"
                      className="w-full h-full rounded-full object-cover border-2 border-[#101922]"
                      src="https://lh3.googleusercontent.com/aida-public/AB6AXuCvrfWGXR_NSzBzI-JasKOidA7kNnec1xEo-F4tEKONh3BnnTTr9SujMk86VlGSW4a0huOIl6C2-R1sS-MsjiTawJGTP61ugi0m18NTYSVhw1RJ9WNIJ5KkZ9reDqFDL3lPIx5tKg3TLO33-8ZkodDYfpah3gEaa5hVhIdnFEgox0Tsbk7Ueci3-w1ulBfXeGCvrzfXdA3U2ehwlnXybAw7RQA8mrOAQPZeMGma_1gywJx1ghseyqQpyiletZuSh3Q4hQ5LA5j3Gjk"
                    />
                  </div>
                  <span className="absolute bottom-0 right-0 w-3 h-3 bg-success border-2 border-[#101922] rounded-full"></span>
                </div>
                <div className="flex-1 min-w-0 pr-8">
                  <div className="flex justify-between items-baseline mb-1">
                    <div className="flex items-center gap-2">
                      <h4 className="font-bold text-base text-white truncate">
                        Elena Ricci
                      </h4>
                      <span className="badge-direct text-[9px] px-1.5 py-0.5 rounded font-bold uppercase tracking-wider">
                        Direct Family
                      </span>
                    </div>
                    <span className="text-[10px] text-accent font-semibold">
                      2m ago
                    </span>
                  </div>
                  <p className="text-sm text-gray-100 font-medium truncate">
                    Found the old photo albums in the attic!
                  </p>
                </div>
              </div>
            </div>
            <div className="glass-panel rounded-2xl p-4 cursor-pointer relative hover:bg-white/5 transition-colors">
              <div className="flex items-center gap-4">
                <div className="relative">
                  <div className="w-12 h-12 rounded-full bg-gradient-to-br from-blue-500 to-cyan-500 flex items-center justify-center border border-white/10">
                    <span className="material-symbols-outlined text-white">
                      diversity_3
                    </span>
                  </div>
                </div>
                <div className="flex-1 min-w-0">
                  <div className="flex justify-between items-baseline mb-1">
                    <div className="flex items-center gap-2">
                      <h4 className="font-bold text-base text-white truncate">
                        Ricci Family Global
                      </h4>
                      <span className="badge-direct text-[9px] px-1.5 py-0.5 rounded font-bold uppercase tracking-wider">
                        Direct Family
                      </span>
                    </div>
                    <span className="text-[10px] text-gray-400">1h ago</span>
                  </div>
                  <p className="text-sm text-gray-300 truncate">
                    <span className="text-gray-400 font-medium">Marco:</span>{" "}
                    Who's bringing the wine for the reunion?
                  </p>
                </div>
              </div>
            </div>
            <div className="glass-panel rounded-2xl p-4 cursor-pointer relative hover:bg-white/5 transition-colors">
              <div className="flex items-center gap-4">
                <div className="relative">
                  <div className="w-12 h-12 rounded-full bg-gradient-to-br from-orange-400 to-red-500 p-[2px]">
                    <div className="w-full h-full rounded-full bg-gray-800 flex items-center justify-center border border-white/10">
                      <span className="text-sm font-bold text-white">MR</span>
                    </div>
                  </div>
                </div>
                <div className="flex-1 min-w-0">
                  <div className="flex justify-between items-baseline mb-1">
                    <div className="flex items-center gap-2">
                      <h4 className="font-bold text-base text-white truncate">
                        Marco Ricci
                      </h4>
                      <span className="badge-direct text-[9px] px-1.5 py-0.5 rounded font-bold uppercase tracking-wider">
                        Direct Family
                      </span>
                    </div>
                    <span className="text-[10px] text-gray-400">3h ago</span>
                  </div>
                  <p className="text-sm text-gray-300 truncate">
                    Did you see the update to the family tree?
                  </p>
                </div>
              </div>
            </div>
            <div
              className="glass-panel rounded-2xl p-4 cursor-pointer relative hover:bg-white/5 transition-colors opacity-90"
              onClick={() => navigate("/messages/access/sarah-smith")}
            >
              <div className="flex items-center gap-4">
                <div className="relative">
                  <div className="w-12 h-12 rounded-full bg-gradient-to-br from-gray-600 to-gray-700 p-[2px]">
                    <img
                      alt="Sarah Smith"
                      className="w-full h-full rounded-full object-cover border-2 border-[#101922] grayscale"
                      src="https://lh3.googleusercontent.com/aida-public/AB6AXuCcPMHZe7pihuDC5a1Ab23u52UektHv1tziZdoknIH6xx0WN3z71zNmLVdb1d_tRYkuxnnGDZpOwQp2juuCCakBuRSWjSGuLqPoF7Prb-Hm3AbibIn1J39HzeYV9NOJ8bMG4oShj8sgbjU3m5xCUe_RURkKEkxgqLG7NSqmtBEql701G8VrT9PjHRA8cTOxE4mqWflN0bOs3SsQwt0-hc6AyYTnFsHdUGEjO1HDl6fK613ZVMwJCUAb8sF6jzfwHqFp_cTPg_zr90w"
                    />
                  </div>
                </div>
                <div className="flex-1 min-w-0">
                  <div className="flex justify-between items-baseline mb-1">
                    <div className="flex items-center gap-2">
                      <h4 className="font-bold text-base text-gray-200 truncate">
                        Sarah Smith
                      </h4>
                      <span className="badge-extended text-[9px] px-1.5 py-0.5 rounded font-bold uppercase tracking-wider">
                        Extended
                      </span>
                    </div>
                    <span className="text-[10px] text-gray-400">Yesterday</span>
                  </div>
                  <p className="text-sm text-gray-400 truncate">
                    Sent a request to view the archives.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </section>
      </main>
      <div className="fixed bottom-24 right-6 z-30">
        <button
          className="bg-primary hover:bg-blue-600 text-white rounded-full p-4 floating-button flex items-center gap-2 transition-all hover:scale-105 active:scale-95 border border-white/10"
          onClick={() => navigate("/messages/access/sarah-smith")}
        >
          <span className="material-symbols-outlined">lock_open_right</span>
          <span className="text-sm font-bold pr-1">Request Access</span>
        </button>
      </div>
      <BottomNav />
    </div>
  );
}

export default MessengerHubScreen;
