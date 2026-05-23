import { useNavigate } from "react-router-dom";
import { useInfrastructure } from "@/contexts/InfrastructureContext";
import "./CloudRedundancyScreen.css";

function CloudRedundancyScreen() {
  const navigate = useNavigate();
  const { zeroKnowledge, setZeroKnowledge, recoveryKey, regenerateKey } =
    useInfrastructure();

  return (
    <div className="bg-background-light dark:bg-background-dark text-slate-900 dark:text-white font-display antialiased selection:bg-primary selection:text-white min-h-screen relative flex flex-col overflow-x-hidden">
      <div className="ambient-glow"></div>
      <div className="ambient-glow-secondary"></div>
      <div className="ambient-glow-bottom"></div>
      <header className="sticky top-0 z-50 flex items-center justify-between p-4 pb-2 bg-[#101922]/80 backdrop-blur-md border-b border-white/5">
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
            Cloud Redundancy
          </h2>
          <span className="text-[10px] text-accent font-medium tracking-widest uppercase opacity-80">
            Security Level: Maximum
          </span>
        </div>
        <div className="flex w-12 items-center justify-end">
          <button className="glass-button flex h-10 w-10 items-center justify-center rounded-full text-white transition-transform active:scale-95">
            <span className="material-symbols-outlined text-[24px]">
              shield
            </span>
          </button>
        </div>
      </header>
      <main className="relative z-10 flex flex-col gap-5 p-4 pb-32">
        <section className="w-full">
          <div className="glass-card p-5 rounded-2xl flex flex-col gap-3">
            <div className="flex justify-between items-center mb-1">
              <div className="flex items-center gap-2">
                <span className="relative flex h-2.5 w-2.5">
                  <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-500 opacity-75"></span>
                  <span className="relative inline-flex rounded-full h-2.5 w-2.5 bg-green-500"></span>
                </span>
                <h3 className="text-sm font-bold text-white uppercase tracking-wide">
                  Global Sync Active
                </h3>
              </div>
              <span className="text-xs text-slate-400 font-mono">
                Synced 2s ago
              </span>
            </div>
            <div className="relative w-full h-12 bg-black/20 rounded-lg overflow-hidden flex items-center px-4 border border-white/5">
              <div className="absolute inset-0 bg-gradient-to-r from-primary/10 via-accent/10 to-primary/10 animate-[shimmer_2s_infinite]"></div>
              <div className="flex justify-between w-full relative z-10 text-xs font-medium text-slate-300">
                <span>Locally Encrypted</span>
                <span className="material-symbols-outlined text-[16px] text-accent">
                  sync_alt
                </span>
                <span>Cloud Mirroring</span>
              </div>
              <div className="absolute bottom-0 left-0 h-1 bg-accent shadow-[0_0_10px_rgba(0,224,255,0.5)] w-full"></div>
            </div>
          </div>
        </section>

        <div className="grid grid-cols-2 gap-3">
          <div className="glass-card p-4 rounded-2xl flex flex-col gap-4 relative overflow-hidden group">
            <div className="absolute top-0 right-0 p-3 opacity-50 group-hover:opacity-100 transition-opacity">
              <span className="material-symbols-outlined text-[20px] text-white">
                cloud_queue
              </span>
            </div>
            <div className="w-10 h-10 rounded-xl bg-white flex items-center justify-center shadow-lg">
              <img
                alt="Google Cloud"
                className="w-6 h-6"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuC4t7nj6pUKmKcMNeCgFkR9nLPbYD3cvKVliAyMBnKMDpdq_546o_fDUkOFRZR2vvVIBUJJoympjsBxSwM2ZGdEOWcCbKJPcZn__oFWx8lWsqOV8iY-kF16ijhlR0K00h0AzkHqDsvRPvjfdSQ8itllA2YApf2fTRpGXP85-ObBJMuPHMPPX0klSzC7ewEHQTmvYcbr0AW6KlAHOyD9NaUpvP-1N4Mg7OgygCQcNDmUohehJxVzbtPpFLoBeZpvlZShcZsMCM-H3Xs"
              />
            </div>
            <div>
              <p className="text-slate-400 text-[10px] uppercase font-bold mb-1 tracking-wider">
                Primary Storage
              </p>
              <p className="text-white text-lg font-bold leading-tight">
                Google Cloud
              </p>
              <p className="text-slate-400 text-xs mt-1">
                us-east1 • 42.8 GB Used
              </p>
            </div>
            <div className="mt-auto pt-2">
              <div className="w-full bg-white/10 h-1.5 rounded-full overflow-hidden">
                <div
                  className="bg-blue-500 h-full rounded-full"
                  style={{ width: "45%" }}
                ></div>
              </div>
            </div>
          </div>

          <div className="glass-card p-4 rounded-2xl flex flex-col gap-4 relative overflow-hidden group border-l-4 border-l-accent/50">
            <div className="absolute top-0 right-0 p-3 opacity-50 group-hover:opacity-100 transition-opacity">
              <span className="material-symbols-outlined text-[20px] text-white">
                dns
              </span>
            </div>
            <div className="w-10 h-10 rounded-xl bg-[#232F3E] flex items-center justify-center shadow-lg border border-white/10">
              <span className="text-white font-bold text-xs">AWS</span>
            </div>
            <div>
              <p className="text-accent text-[10px] uppercase font-bold mb-1 tracking-wider">
                Redundant Mirror
              </p>
              <p className="text-white text-lg font-bold leading-tight">
                AWS S3 Glacier
              </p>
              <p className="text-slate-400 text-xs mt-1">eu-west • Immutable</p>
            </div>
            <div className="mt-auto pt-2 flex items-center gap-2">
              <span className="material-symbols-outlined text-[14px] text-green-500">
                check_circle
              </span>
              <span className="text-[10px] text-green-500 font-medium">
                Verified 100%
              </span>
            </div>
          </div>
        </div>

        <section className="glass-card p-5 rounded-2xl flex items-center justify-between">
          <div className="flex items-center gap-4">
            <div className="w-12 h-12 rounded-full bg-primary/20 flex items-center justify-center text-primary border border-primary/20">
              <span className="material-symbols-outlined text-[24px]">
                lock
              </span>
            </div>
            <div className="flex flex-col">
              <h3 className="text-white font-bold text-sm">Zero-Knowledge</h3>
              <p className="text-slate-400 text-xs leading-snug max-w-[180px]">
                Only you hold the keys. Aevum cannot access your data.
              </p>
            </div>
          </div>
          <div className="relative inline-block w-12 mr-2 align-middle select-none transition duration-200 ease-in">
            <input
              type="checkbox"
              name="toggle"
              id="toggle"
              checked={zeroKnowledge}
              onChange={() => setZeroKnowledge(!zeroKnowledge)}
              className="toggle-checkbox absolute block w-6 h-6 rounded-full bg-white border-4 appearance-none cursor-pointer transition-all duration-300 left-0 peer-checked:left-6 border-slate-400 peer-checked:border-primary"
            />
            <label
              htmlFor="toggle"
              className={`toggle-label block overflow-hidden h-6 rounded-full cursor-pointer transition-colors duration-300 ${zeroKnowledge ? "bg-primary/50" : "bg-slate-700"}`}
            ></label>
          </div>
        </section>

        <section className="glass-card p-5 rounded-2xl flex flex-col gap-4">
          <div className="flex justify-between items-start">
            <div>
              <h3 className="text-white font-bold text-sm">
                Master Recovery Key
              </h3>
              <p className="text-slate-400 text-xs mt-1">
                Required to restore redundant backups.
              </p>
            </div>
            <button
              onClick={regenerateKey}
              className="text-accent text-xs font-bold hover:text-white transition-colors flex items-center gap-1"
            >
              <span className="material-symbols-outlined text-[14px]">
                {recoveryKey ? "refresh" : "add"}
              </span>{" "}
              {recoveryKey ? "Regenerate" : "Generate"}
            </button>
          </div>
          <div className="bg-black/30 border border-white/10 rounded-xl p-4 flex items-center justify-between group cursor-pointer active:bg-black/40 transition-colors">
            <div
              className={`flex gap-2 font-mono text-sm text-slate-300 tracking-wider ${!recoveryKey ? "opacity-30" : ""}`}
            >
              {(recoveryKey || "XXXX-XXXX-XXXX-XXXX")
                .split("-")
                .map((part, index) => (
                  <div key={index} className="flex">
                    <span>{part}</span>
                    {index < 3 && (
                      <span className="text-slate-600 mx-1">-</span>
                    )}
                  </div>
                ))}
            </div>
            <span
              className={`material-symbols-outlined transition-colors text-[20px] ${recoveryKey ? "text-slate-500 group-hover:text-white" : "text-slate-700 cursor-not-allowed"}`}
              onClick={() =>
                recoveryKey && navigator.clipboard.writeText(recoveryKey)
              }
            >
              content_copy
            </span>
          </div>
          <div className="flex gap-2 mt-1">
            <div className="h-1 flex-1 rounded-full bg-green-500"></div>
            <div className="h-1 flex-1 rounded-full bg-green-500"></div>
            <div className="h-1 flex-1 rounded-full bg-green-500"></div>
            <div className="h-1 flex-1 rounded-full bg-green-500"></div>
            <p className="text-[10px] text-slate-400 ml-2">Strong Entropy</p>
          </div>
        </section>

        <div className="sticky bottom-24 z-20 mt-2">
          <button className="glass-highlight w-full h-14 rounded-2xl bg-primary/20 hover:bg-primary/30 border-primary/30 text-white font-bold text-lg flex items-center justify-center gap-3 backdrop-blur-md shadow-lg shadow-primary/10 transition-all active:scale-[0.98]">
            <span className="material-symbols-outlined">cloud_upload</span>
            Force Backup Now
          </button>
        </div>
      </main>
    </div>
  );
}

export default CloudRedundancyScreen;
