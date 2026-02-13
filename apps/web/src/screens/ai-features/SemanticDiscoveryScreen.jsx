import { useNavigate } from "react-router-dom";
import BottomNav from "@/components/BottomNav";
import "./SemanticDiscoveryScreen.css";

function SemanticDiscoveryScreen() {
  const navigate = useNavigate();

  return (
    <div className="bg-background-light dark:bg-background-dark text-slate-900 dark:text-white font-display antialiased selection:bg-primary selection:text-white min-h-screen relative overflow-hidden">
      <div className="ambient-glow"></div>
      <div className="ambient-glow-secondary"></div>
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
        <div className="flex flex-col items-center">
          <h2 className="text-white text-lg font-bold leading-tight tracking-[-0.015em] drop-shadow-md">
            Semantic Discovery
          </h2>
          <span className="text-[10px] text-accent font-medium tracking-widest uppercase opacity-80">
            AI Analysis Active
          </span>
        </div>
        <div className="flex w-12 items-center justify-end">
          <button className="glass-button flex h-10 w-10 items-center justify-center rounded-full text-white transition-transform active:scale-95">
            <span className="material-symbols-outlined text-[24px]">
              smart_toy
            </span>
          </button>
        </div>
      </header>
      <main className="relative z-10 flex flex-col gap-5 p-4 pb-32">
        <section className="@container">
          <div className="glass-card relative flex flex-col items-center p-6 rounded-2xl overflow-hidden border border-accent/20">
            <div className="absolute top-0 inset-x-0 h-[1px] bg-gradient-to-r from-transparent via-accent/50 to-transparent"></div>
            <div className="flex items-center gap-2 mb-3">
              <span className="flex h-2 w-2 rounded-full bg-success animate-pulse"></span>
              <span className="text-xs font-bold text-success uppercase tracking-wider">
                High Confidence Match
              </span>
            </div>
            <div className="relative w-full h-32 mb-4">
              <div className="absolute top-1/2 left-0 right-0 h-[1px] bg-white/10 -translate-y-1/2"></div>
              <div className="absolute top-1/2 left-[15%] -translate-y-1/2 -translate-x-1/2 flex flex-col items-center gap-2 z-10">
                <div className="w-16 h-16 rounded-full border-2 border-white/20 p-1 bg-background-dark/50 backdrop-blur-sm">
                  <div
                    className="w-full h-full rounded-full bg-cover bg-center"
                    style={{
                      backgroundImage:
                        'url("https://lh3.googleusercontent.com/aida-public/AB6AXuCcxrzPy7OIC6fd_Q2YDezWIUxp5TQ5fc26rSRExBWQAogSbHqAcIW5X7KuWlU7plAP0P5KH9OR86Z0I-qFYPQIkHsqp_-Xd-bKT6GS_SbQwkMF_v21eWMHQNg-ncKsK7-OX67k9A1pjiZdgepQFPOA7uaYgzbKptnvYNvioTH6t1YsrVLoDcrW92mP2MS1oDyzCDt64EufsU6g4OIatEOy63KXakhwlJMKB2X9LUQnMS2V07kb0vgKx7tJ26GmURB4xILcTyY3So8")',
                    }}
                  ></div>
                </div>
                <span className="text-[10px] text-slate-400 font-medium">
                  Grandfather
                </span>
              </div>
              <div className="absolute top-1/2 left-1/2 -translate-y-1/2 -translate-x-1/2 z-20">
                <div className="bg-success/20 backdrop-blur-md border border-success/30 text-success px-3 py-1 rounded-full text-xs font-bold flex items-center gap-1 shadow-[0_0_15px_rgba(34,197,94,0.3)]">
                  <span className="material-symbols-outlined text-[14px]">
                    link
                  </span>{" "}
                  94%
                </div>
              </div>
              <div className="absolute top-1/2 right-[15%] -translate-y-1/2 translate-x-1/2 flex flex-col items-center gap-2 z-10">
                <div className="w-16 h-16 rounded-full border-2 border-dashed border-success/50 p-1 bg-success/5 backdrop-blur-sm relative">
                  <div
                    className="w-full h-full rounded-full bg-cover bg-center opacity-80 mix-blend-luminosity"
                    style={{
                      backgroundImage:
                        'url("https://lh3.googleusercontent.com/aida-public/AB6AXuB5VBZhM5VzXhfu9SvegoT9Pv4b9Fa6pvmZbzfCN90nf3Z-qIcBALR5R2sTODFd3s4N5wkPzKF0dQH8OKfxmkjbyzQ0PUsw3Uk5XPy2tWBN1c2Jj0MexMFQnuquwYFIoj-6cY3407_XOdLvufiH7UzhsAyh66OZCvI_HRuUfR0RmeVYs8N1h7VIw_006yzmqL3kayWER4--oKCJJmhLGsF0f3JM7v6TtC7bF09hXSvzjO19yX8u2p-wcj0bsG7qw35DQpg3hinhxaE")',
                    }}
                  ></div>
                  <div className="absolute -top-1 -right-1 w-5 h-5 bg-success rounded-full flex items-center justify-center border border-black">
                    <span className="material-symbols-outlined text-[12px] text-black font-bold">
                      auto_awesome
                    </span>
                  </div>
                </div>
                <span className="text-[10px] text-success font-medium">
                  New Ancestor?
                </span>
              </div>
            </div>
            <h1 className="text-2xl font-bold text-white text-center mb-1">
              Eleanor Vance
            </h1>
            <p className="text-slate-400 text-sm text-center mb-0">
              Predicted Great-Grandmother (1892 - 1968)
            </p>
          </div>
        </section>
        <div className="grid grid-cols-2 gap-3">
          <div className="col-span-2">
            <h3 className="text-slate-400 text-xs font-bold uppercase tracking-wider mb-2 ml-1">
              AI Evidence Analysis
            </h3>
          </div>
          <div className="glass-card p-4 rounded-xl flex flex-col gap-3 hover:bg-white/5 transition-colors">
            <div className="w-8 h-8 rounded-lg bg-blue-500/20 flex items-center justify-center text-blue-400">
              <span className="material-symbols-outlined text-[20px]">
                description
              </span>
            </div>
            <div>
              <p className="text-slate-400 text-xs uppercase font-bold mb-1">
                Census Record
              </p>
              <p className="text-white text-sm font-medium leading-snug">
                Found matching "Eleanor V." in 1920 Census at same address.
              </p>
            </div>
            <div className="w-full bg-white/10 h-1 rounded-full mt-auto">
              <div
                className="bg-blue-500 h-1 rounded-full"
                style={{ width: "92%" }}
              ></div>
            </div>
          </div>
          <div className="glass-card p-4 rounded-xl flex flex-col gap-3 hover:bg-white/5 transition-colors">
            <div className="w-8 h-8 rounded-lg bg-purple-500/20 flex items-center justify-center text-purple-400">
              <span className="material-symbols-outlined text-[20px]">
                face
              </span>
            </div>
            <div>
              <p className="text-slate-400 text-xs uppercase font-bold mb-1">
                Facial Features
              </p>
              <p className="text-white text-sm font-medium leading-snug">
                Strong structural similarity to known son (John).
              </p>
            </div>
            <div className="w-full bg-white/10 h-1 rounded-full mt-auto">
              <div
                className="bg-purple-500 h-1 rounded-full"
                style={{ width: "88%" }}
              ></div>
            </div>
          </div>
          <div className="col-span-2 glass-card p-4 rounded-xl flex items-center gap-4">
            <div className="w-10 h-10 shrink-0 rounded-lg bg-orange-500/20 flex items-center justify-center text-orange-400">
              <span className="material-symbols-outlined text-[24px]">
                calendar_month
              </span>
            </div>
            <div className="flex-1">
              <div className="flex justify-between items-center mb-1">
                <p className="text-white text-sm font-bold">
                  Temporal Consistency
                </p>
                <span className="text-xs text-green-400 font-mono">PASS</span>
              </div>
              <p className="text-slate-400 text-xs leading-relaxed">
                Birth date aligns perfectly with known family timeline gaps in
                the Boston registry.
              </p>
            </div>
          </div>
        </div>
        <div className="col-span-2 mt-2">
          <div className="flex justify-between items-end mb-3 ml-1">
            <h3 className="text-slate-400 text-xs font-bold uppercase tracking-wider">
              Projected Tree Impact
            </h3>
            <button className="text-primary text-xs font-semibold hover:text-white transition-colors">
              View Full Tree
            </button>
          </div>
          <div className="glass-card p-4 rounded-xl relative overflow-hidden h-32 flex items-center justify-center">
            <div
              className="absolute inset-0"
              style={{
                backgroundImage:
                  "radial-gradient(rgba(255,255,255,0.1) 1px, transparent 1px)",
                backgroundSize: "20px 20px",
                opacity: 0.3,
              }}
            ></div>
            <div className="relative z-10 flex flex-col items-center gap-4 w-full">
              <div className="flex items-center justify-center">
                <div className="w-10 h-10 rounded-full border border-dashed border-success bg-success/10 flex items-center justify-center animate-pulse">
                  <span className="material-symbols-outlined text-success text-[18px]">
                    person
                  </span>
                </div>
              </div>
              <div className="w-1/2 h-4 border-t-2 border-l-2 border-r-2 border-dashed border-slate-600 rounded-t-lg"></div>
              <div className="flex gap-8">
                <div className="w-8 h-8 rounded-full bg-slate-700 border border-white/20"></div>
                <div className="w-8 h-8 rounded-full bg-slate-700 border border-white/20 ring-2 ring-primary ring-offset-2 ring-offset-[#101922]"></div>
                <div className="w-8 h-8 rounded-full bg-slate-700 border border-white/20"></div>
              </div>
            </div>
          </div>
        </div>
        <div className="sticky bottom-24 z-20 flex flex-col gap-3 mt-4">
          <button className="glass-highlight w-full h-14 rounded-2xl bg-success/20 hover:bg-success/30 border-success/30 text-white font-bold text-lg flex items-center justify-center gap-3 backdrop-blur-md shadow-lg shadow-success/10 transition-all active:scale-[0.98]">
            <span className="material-symbols-outlined">call_merge</span>
            Confirm & Merge Branch
          </button>
          <div className="flex gap-3">
            <button className="glass-button flex-1 h-12 rounded-xl text-slate-300 font-medium text-sm hover:bg-white/5 active:scale-[0.98] transition-all">
              Ignore
            </button>
            <button className="glass-button flex-1 h-12 rounded-xl text-slate-300 font-medium text-sm hover:bg-white/5 active:scale-[0.98] transition-all flex items-center justify-center gap-2">
              <span className="material-symbols-outlined text-[18px]">
                edit
              </span>
              Edit Details
            </button>
          </div>
        </div>
      </main>
      <BottomNav />
    </div>
  );
}

export default SemanticDiscoveryScreen;
