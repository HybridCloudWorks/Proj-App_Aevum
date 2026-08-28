import { useNavigate } from "react-router-dom";
import "./AdminScreen.css";

/**
 * Private Beta admin landing page.
 *
 * Operational values are intentionally not synthesized. Real build, crash,
 * deployment, tester, and feedback telemetry must come from authenticated
 * operational integrations before it is displayed here.
 */
function AdminScreen() {
  const navigate = useNavigate();

  const capabilities = [
    {
      title: "Build & Deployment",
      detail: "Not connected to a deployment-status provider yet.",
      icon: "build_circle",
    },
    {
      title: "Crash & Performance",
      detail: "Not connected to Crashlytics/Performance telemetry yet.",
      icon: "monitor_heart",
    },
    {
      title: "Beta Participation",
      detail: "No authoritative tester analytics source is connected yet.",
      icon: "group",
    },
    {
      title: "Release Operations",
      detail: "Rollback and hotfix actions are disabled until audited deployment automation is connected.",
      icon: "shield_lock",
    },
  ];

  return (
    <div className="admin-screen-container bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-white antialiased min-h-screen flex flex-col">
      <div className="ambient-glow" />
      <header className="sticky top-0 z-50 flex items-center justify-between p-5 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-xl border-b border-white/5">
        <div className="flex items-center gap-3">
          <div className="flex items-center justify-center size-10 rounded-xl bg-gradient-to-br from-primary/20 to-accent/20 text-primary border border-white/5">
            <span className="material-symbols-outlined text-[24px]">admin_panel_settings</span>
          </div>
          <div>
            <h1 className="text-lg font-bold leading-tight tracking-tight">
              Admin Operations
            </h1>
            <span className="text-xs font-medium text-amber-300">
              Private Beta • telemetry integrations pending
            </span>
          </div>
        </div>
        <button
          className="flex items-center justify-center size-9 rounded-full hover:bg-white/5 transition-colors text-slate-400 hover:text-white"
          onClick={() => navigate(-1)}
          aria-label="Go back"
        >
          <span className="material-symbols-outlined text-[20px]">arrow_back</span>
        </button>
      </header>

      <main className="flex-1 p-5 w-full max-w-2xl mx-auto relative z-10 pb-24">
        <section className="glass-card p-5 rounded-2xl mb-4 border border-amber-400/20">
          <div className="flex gap-3 items-start">
            <span className="material-symbols-outlined text-amber-300">info</span>
            <div>
              <h2 className="font-bold mb-1">No synthetic production data</h2>
              <p className="text-sm text-slate-400">
                This page intentionally does not display guessed build IDs,
                test counts, crash rates, user counts, deployment status, or
                App Store state. Those values will appear only after an
                authenticated telemetry source is connected.
              </p>
            </div>
          </div>
        </section>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
          {capabilities.map((capability) => (
            <section key={capability.title} className="glass-card p-4 rounded-2xl">
              <div className="flex items-center gap-2 mb-3 text-slate-300">
                <span className="material-symbols-outlined text-[20px]">
                  {capability.icon}
                </span>
                <h2 className="text-sm font-bold">{capability.title}</h2>
              </div>
              <p className="text-xs text-slate-400 leading-relaxed">
                {capability.detail}
              </p>
              <div className="mt-4 inline-flex px-2 py-1 rounded bg-white/5 text-[10px] uppercase tracking-wider text-slate-400">
                Not connected
              </div>
            </section>
          ))}
        </div>
      </main>
    </div>
  );
}

export default AdminScreen;
