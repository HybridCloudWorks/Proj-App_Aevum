import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

function RestrictedProfileScreen() {
  const navigate = useNavigate();
  const [requestStatus, setRequestStatus] = useState("idle"); // idle, pending, approved

  const handleRequestDisclosure = () => {
    // Mocking the approval request flow
    setRequestStatus("pending");
    setTimeout(() => {
      // In a real app, this would wait for backend/spousal approval
      alert(
        "Request sent to Family Council (Spouse & Admin). Identity will remain hidden until approved.",
      );
    }, 800);
  };

  return (
    <div className="bg-background-light dark:bg-background-dark text-slate-900 dark:text-white font-display min-h-screen flex justify-center selection:bg-primary/30">
      <div className="relative w-full max-w-md bg-background-light dark:bg-[#0f151b] flex flex-col min-h-screen shadow-2xl overflow-hidden">
        {/* Ambient Background Glows */}
        <div className="absolute top-[-10%] left-[-20%] w-[80%] h-[40%] bg-primary/20 rounded-full blur-[100px] pointer-events-none"></div>
        <div className="absolute bottom-[10%] right-[-10%] w-[60%] h-[40%] bg-purple-500/10 rounded-full blur-[80px] pointer-events-none"></div>

        {/* Header */}
        <div className="sticky top-0 z-50 flex items-center justify-between p-4 bg-[#0f151b]/80 backdrop-blur-md border-b border-white/5">
          <button
            onClick={() => navigate(-1)}
            className="flex items-center justify-center w-10 h-10 rounded-full hover:bg-white/10 transition-colors text-white"
          >
            <span
              className="material-symbols-outlined"
              style={{ fontSize: "24px" }}
            >
              arrow_back
            </span>
          </button>
          <h2 className="text-white text-base font-bold tracking-tight uppercase opacity-80">
            Lineage Profile
          </h2>
          <button className="flex items-center justify-center w-10 h-10 rounded-full hover:bg-white/10 transition-colors text-white">
            <span
              className="material-symbols-outlined"
              style={{ fontSize: "24px" }}
            >
              more_vert
            </span>
          </button>
        </div>

        {/* Scrollable Content */}
        <div className="flex-1 overflow-y-auto pb-24 custom-scrollbar">
          {/* Child Hero Section (Bento Grid Item 1) */}
          <div className="p-4 pt-6">
            <div className="glass-panel rounded-2xl p-6 relative overflow-hidden group border border-white/10 bg-white/5 backdrop-blur-md">
              <div className="absolute inset-0 bg-gradient-to-br from-primary/10 via-transparent to-transparent opacity-50"></div>
              <div className="relative flex flex-col items-center gap-4">
                <div className="relative">
                  <div className="w-32 h-32 rounded-full p-1 bg-gradient-to-br from-white/20 to-transparent">
                    <img
                      className="w-full h-full rounded-full object-cover border-4 border-[#0f151b]"
                      alt="Portrait of a young boy smiling against a blurred background"
                      src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=200&h=200"
                    />
                  </div>
                  <div className="absolute bottom-0 right-0 bg-emerald-500/90 backdrop-blur-sm text-white text-[10px] font-bold px-2 py-0.5 rounded-full border border-[#0f151b] shadow-lg">
                    VERIFIED
                  </div>
                </div>
                <div className="text-center space-y-1">
                  <h1 className="text-3xl font-bold text-white tracking-tight">
                    Leo Mercer
                  </h1>
                  <div className="flex items-center justify-center gap-2 text-slate-400 text-sm font-medium">
                    <span className="material-symbols-outlined text-base">
                      calendar_today
                    </span>
                    <span>Born Oct 12, 2018</span>
                  </div>
                  <div className="inline-flex mt-2 px-3 py-1 rounded-lg bg-white/5 border border-white/5 text-xs text-slate-400">
                    Generation Alpha • Node #8421
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* Parents Section Title */}
          <div className="px-6 pb-2 pt-2 flex items-center justify-between">
            <h3 className="text-white text-lg font-bold tracking-tight">
              Direct Lineage
            </h3>
            <span className="text-xs font-semibold text-slate-500 uppercase tracking-widest">
              Gen 02
            </span>
          </div>

          {/* Parent Cards Container */}
          <div className="px-4 space-y-4">
            {/* Visible Parent (Bento Card) */}
            <div className="glass-panel glass-card-active rounded-2xl p-4 flex gap-4 items-center bg-white/[0.02] border border-white/10">
              <div className="relative shrink-0">
                <div className="w-20 h-24 rounded-xl bg-slate-800 overflow-hidden shadow-lg border border-white/10">
                  <img
                    className="w-full h-full object-cover"
                    alt="Portrait of a woman smiling outdoors with natural lighting"
                    src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&q=80&w=200&h=240"
                  />
                </div>
              </div>
              <div className="flex-1 min-w-0">
                <div className="flex items-center justify-between mb-1">
                  <h4 className="text-white text-lg font-bold truncate">
                    Sarah Mercer
                  </h4>
                  <span
                    className="material-symbols-outlined text-emerald-400 text-lg"
                    title="Verified Parent"
                  >
                    verified
                  </span>
                </div>
                <p className="text-slate-400 text-xs font-medium uppercase tracking-wider mb-2">
                  Biological Mother
                </p>
                <p className="text-slate-300 text-sm line-clamp-2 leading-relaxed opacity-80">
                  Sarah is an avid historian and the primary curator of the
                  Mercer family archives.
                </p>
              </div>
              <button className="shrink-0 w-8 h-8 flex items-center justify-center rounded-full bg-white/5 hover:bg-white/10 text-white transition-colors">
                <span className="material-symbols-outlined text-xl">
                  chevron_right
                </span>
              </button>
            </div>

            {/* Geometric Connector Line */}
            <div className="flex justify-center -my-2 relative z-0">
              <div className="h-8 w-px bg-gradient-to-b from-white/10 to-white/5"></div>
            </div>

            {/* Restricted Parent (Bento Card) */}
            <div className="rounded-2xl p-0 overflow-hidden relative group border border-dashed border-white/15 bg-black/40 backdrop-blur-sm">
              {/* Warning Stripes Pattern */}
              <div
                className="absolute inset-0 opacity-10 pointer-events-none"
                style={{
                  backgroundImage: `repeating-linear-gradient(45deg, #000 0, #000 10px, #333 10px, #333 20px)`,
                }}
              ></div>

              <div className="p-5 flex flex-col gap-4 relative z-10">
                {/* Header of locked card */}
                <div className="flex items-start justify-between">
                  <div className="flex gap-4 items-center">
                    <div className="w-16 h-16 rounded-xl bg-gradient-to-b from-slate-700 to-slate-800 flex items-center justify-center border border-white/10 shadow-inner">
                      <span className="material-symbols-outlined text-slate-500 text-3xl">
                        person_off
                      </span>
                    </div>
                    <div className="flex flex-col">
                      <h4 className="text-slate-200 text-lg font-bold flex items-center gap-2">
                        Identity Restricted
                        <span className="material-symbols-outlined text-amber-500 text-sm">
                          lock
                        </span>
                      </h4>
                      <p className="text-slate-500 text-sm font-medium">
                        Private Lineage • Access Locked
                      </p>
                    </div>
                  </div>
                </div>

                {/* Info Badge */}
                <div className="bg-amber-500/10 border border-amber-500/20 rounded-lg p-3 flex gap-3 items-start">
                  <span className="material-symbols-outlined text-amber-500 text-lg mt-0.5 shrink-0">
                    warning
                  </span>
                  <div className="flex-1">
                    <p className="text-amber-200/90 text-xs font-medium leading-relaxed">
                      This profile is currently sealed under the "Out-of-Wedlock
                      Privacy Protocol". Direct access is restricted to the Tree
                      Owner.
                    </p>
                  </div>
                </div>

                {/* Action Area */}
                <div className="mt-2 pt-4 border-t border-white/5 flex flex-col gap-3">
                  {requestStatus === "idle" ? (
                    <button
                      onClick={handleRequestDisclosure}
                      className="w-full relative overflow-hidden rounded-xl h-12 bg-primary hover:bg-blue-600 transition-all flex items-center justify-center gap-2 group/btn shadow-[0_0_15px_rgba(17,115,212,0.3)] hover:shadow-[0_0_20px_rgba(17,115,212,0.5)]"
                    >
                      <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent translate-x-[-100%] group-hover/btn:translate-x-[100%] transition-transform duration-700"></div>
                      <span className="material-symbols-outlined text-white text-[20px]">
                        vpn_key
                      </span>
                      <span className="text-white text-sm font-bold tracking-wide">
                        Request Identity Disclosure
                      </span>
                    </button>
                  ) : (
                    <button
                      disabled
                      className="w-full rounded-xl h-12 bg-slate-700/50 text-slate-400 cursor-not-allowed flex items-center justify-center gap-2 font-medium"
                    >
                      <span className="material-symbols-outlined text-[20px] animate-pulse">
                        hourglass_top
                      </span>
                      Awaiting Spousal Approval...
                    </button>
                  )}
                  <p className="text-center text-[10px] text-slate-500 font-medium uppercase tracking-wider">
                    Approval required by Family Council
                  </p>
                </div>
              </div>
            </div>
          </div>

          <div className="h-8"></div>
        </div>

        {/* Floating Quick Actions (Bottom Bar) */}
        <div className="absolute bottom-6 left-1/2 transform -translate-x-1/2 bg-[#1c2633]/90 backdrop-blur-xl border border-white/10 rounded-full px-6 py-3 shadow-2xl flex items-center gap-6 z-40">
          <button className="flex flex-col items-center gap-1 text-primary group">
            <span className="material-symbols-outlined text-2xl group-hover:scale-110 transition-transform">
              account_tree
            </span>
            <span className="text-[10px] font-bold">Tree</span>
          </button>
          <div className="w-px h-8 bg-white/10"></div>
          <button className="flex flex-col items-center gap-1 text-slate-400 hover:text-white transition-colors group">
            <span className="material-symbols-outlined text-2xl group-hover:scale-110 transition-transform">
              timeline
            </span>
            <span className="text-[10px] font-medium">Timeline</span>
          </button>
          <div className="w-px h-8 bg-white/10"></div>
          <button className="flex flex-col items-center gap-1 text-slate-400 hover:text-white transition-colors group">
            <span className="material-symbols-outlined text-2xl group-hover:scale-110 transition-transform">
              share
            </span>
            <span className="text-[10px] font-medium">Share</span>
          </button>
        </div>
      </div>
    </div>
  );
}

export default RestrictedProfileScreen;
