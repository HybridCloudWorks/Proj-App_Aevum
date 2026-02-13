import { useNavigate } from "react-router-dom";
import React from "react";

function PrivacyRulesScreen() {
  const navigate = useNavigate();

  return (
    <div className="relative min-h-screen w-full flex flex-col items-center bg-[#101922] font-display text-white antialiased overflow-x-hidden selection:bg-primary/30">
      {/* Animated Mesh Background Base */}
      <div
        className="fixed inset-0 z-0 pointer-events-none"
        style={{
          backgroundColor: "#101922",
          backgroundImage: `
                radial-gradient(circle at 15% 50%, rgba(17, 115, 212, 0.25), transparent 40%),
                radial-gradient(circle at 85% 30%, rgba(139, 92, 246, 0.2), transparent 40%),
                radial-gradient(circle at 50% 80%, rgba(17, 115, 212, 0.15), transparent 50%)
            `,
          backgroundAttachment: "fixed",
          backgroundSize: "cover",
        }}
      ></div>

      {/* Header / Progress */}
      <div className="w-full flex flex-col items-center pt-8 pb-4 px-6 z-10">
        {/* Glass Pill Step Indicator */}
        <div className="glass-pill rounded-full px-4 py-2 flex items-center gap-3 mb-6 bg-black/30 backdrop-blur-md border border-white/10 shadow-[0_4px_30px_rgba(0,0,0,0.1)]">
          <span className="text-xs font-semibold tracking-wider text-white/70 uppercase">
            Step 3 of 5
          </span>
          <div className="h-3 w-[1px] bg-white/10"></div>
          <div className="flex gap-1.5">
            <div className="h-1.5 w-1.5 rounded-full bg-white/30"></div>
            <div className="h-1.5 w-1.5 rounded-full bg-white/30"></div>
            <div className="h-1.5 w-4 rounded-full bg-primary shadow-[0_0_8px_rgba(17,115,212,0.6)]"></div>
            <div className="h-1.5 w-1.5 rounded-full bg-white/30"></div>
            <div className="h-1.5 w-1.5 rounded-full bg-white/30"></div>
          </div>
        </div>

        {/* Title */}
        <h1 className="text-3xl md:text-4xl font-extrabold text-center tracking-tight leading-tight bg-gradient-to-br from-white to-white/70 bg-clip-text text-transparent drop-shadow-sm">
          Your Tree,
          <br />
          Your Rules
        </h1>
        <p className="mt-2 text-white/60 text-center text-sm font-medium max-w-xs">
          Set boundaries to keep your family history secure and accurate.
        </p>
      </div>

      {/* Main Content: Bento Grid */}
      <div className="flex-1 w-full max-w-md px-5 flex flex-col gap-4 z-10 pb-28">
        {/* Card 1: Spousal Approval (Large Feature) */}
        <div className="glass-card rounded-2xl p-6 relative overflow-hidden group bg-white/[0.03] backdrop-blur-xl border border-white/10 shadow-lg">
          {/* Decorative background glow */}
          <div className="absolute -top-10 -right-10 w-32 h-32 bg-primary/20 rounded-full blur-3xl group-hover:bg-primary/30 transition-colors duration-500 pointer-events-none"></div>

          <div className="flex flex-col gap-4 relative z-10">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-white/10 to-white/5 border border-white/10 flex items-center justify-center shadow-inner">
              <span className="material-symbols-outlined text-[#60a5fa] text-[28px]">
                diversity_3
              </span>
            </div>
            <div>
              <h3 className="text-xl font-bold text-white mb-2">
                Spousal Approval
              </h3>
              <p className="text-sm text-white/70 leading-relaxed">
                Adding a spouse isn't automatic. To link profiles, we send a
                request.{" "}
                <span className="text-white font-semibold">
                  Both parties must tap 'Accept'
                </span>{" "}
                to connect.
              </p>
            </div>
          </div>

          {/* Visual representation of connection */}
          <div className="mt-6 flex items-center justify-between px-2">
            <div className="flex flex-col items-center gap-1">
              <div className="w-10 h-10 rounded-full bg-white/10 border border-white/20 flex items-center justify-center">
                <span className="material-symbols-outlined text-white/60 text-sm">
                  person
                </span>
              </div>
              <span className="text-[10px] text-white/40 uppercase tracking-widest font-bold">
                You
              </span>
            </div>

            <div className="flex-1 h-[1px] bg-white/10 mx-3 relative">
              <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-[#101922]/50 p-1 rounded-full border border-primary/50">
                <span className="material-symbols-outlined text-primary text-xs block">
                  lock
                </span>
              </div>
            </div>

            <div className="flex flex-col items-center gap-1">
              <div className="w-10 h-10 rounded-full bg-white/5 border border-white/10 flex items-center justify-center border-dashed">
                <span className="material-symbols-outlined text-white/40 text-sm">
                  favorite
                </span>
              </div>
              <span className="text-[10px] text-white/40 uppercase tracking-widest font-bold">
                Spouse
              </span>
            </div>
          </div>
        </div>

        {/* Card 2: Roles Comparison (Grid) */}
        <div className="grid grid-cols-2 gap-4">
          {/* Owner Role */}
          <div className="glass-card rounded-2xl p-5 flex flex-col gap-3 relative overflow-hidden bg-white/[0.03] backdrop-blur-xl border border-white/10">
            <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-amber-400 to-amber-600"></div>
            <div className="flex items-center justify-between">
              <span className="text-xs font-bold text-amber-400 uppercase tracking-wider">
                Owner
              </span>
              <span className="material-symbols-outlined text-amber-400 text-lg">
                crown
              </span>
            </div>
            <div className="flex flex-col gap-2 mt-1">
              <p className="text-white font-bold text-lg leading-tight">
                Full
                <br />
                Control
              </p>
              <ul className="text-[11px] text-white/60 space-y-1.5">
                <li className="flex items-start gap-1.5">
                  <span className="material-symbols-outlined text-green-400 text-[14px]">
                    check
                  </span>
                  Delete Tree
                </li>
                <li className="flex items-start gap-1.5">
                  <span className="material-symbols-outlined text-green-400 text-[14px]">
                    check
                  </span>
                  Manage Admins
                </li>
              </ul>
            </div>
          </div>

          {/* Admin Role */}
          <div className="glass-card rounded-2xl p-5 flex flex-col gap-3 relative overflow-hidden bg-white/[0.03] backdrop-blur-xl border border-white/10">
            <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-blue-400 to-indigo-500"></div>
            <div className="flex items-center justify-between">
              <span className="text-xs font-bold text-blue-400 uppercase tracking-wider">
                Admin
              </span>
              <span className="material-symbols-outlined text-blue-400 text-lg">
                shield_person
              </span>
            </div>
            <div className="flex flex-col gap-2 mt-1">
              <p className="text-white font-bold text-lg leading-tight">
                Help
                <br />
                Build
              </p>
              <ul className="text-[11px] text-white/60 space-y-1.5">
                <li className="flex items-start gap-1.5">
                  <span className="material-symbols-outlined text-green-400 text-[14px]">
                    check
                  </span>
                  Edit Profiles
                </li>
                <li className="flex items-start gap-1.5">
                  <span className="material-symbols-outlined text-green-400 text-[14px]">
                    check
                  </span>
                  Invite Family
                </li>
              </ul>
            </div>
          </div>
        </div>

        {/* Card 3: Privacy Context */}
        <div className="glass-card rounded-2xl p-4 flex items-center gap-4 bg-white/[0.03] backdrop-blur-xl border border-white/10">
          <div className="w-10 h-10 rounded-full bg-emerald-500/10 flex items-center justify-center shrink-0">
            <span className="material-symbols-outlined text-emerald-400">
              security
            </span>
          </div>
          <div>
            <h4 className="text-white text-sm font-bold">
              Living People are Private
            </h4>
            <p className="text-xs text-white/50 mt-0.5">
              Only deceased profiles are publicly searchable by default.
            </p>
          </div>
        </div>
      </div>

      {/* Fixed Bottom Action Area */}
      <div className="fixed bottom-0 left-0 w-full p-6 z-50 bg-gradient-to-t from-[#101922] via-[#101922]/90 to-transparent pt-12 pointer-events-none">
        <div className="w-full max-w-md mx-auto pointer-events-auto">
          <button
            onClick={() => navigate("/settings/privacy-security")}
            className="w-full glass-button h-14 rounded-2xl flex items-center justify-center gap-2 group transition-all duration-300 hover:scale-[1.02] active:scale-[0.98] bg-primary/60 backdrop-blur-xl border border-white/20 shadow-[0_0_20px_rgba(17,115,212,0.4)]"
          >
            <span className="text-white text-lg font-bold tracking-wide">
              Got it, let's grow
            </span>
            <span className="material-symbols-outlined text-white transition-transform group-hover:translate-x-1">
              arrow_forward
            </span>
          </button>
        </div>
      </div>
    </div>
  );
}

export default PrivacyRulesScreen;
