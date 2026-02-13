import { useNavigate } from "react-router-dom";
import BottomNav from "@/components/BottomNav";
import { useAuth } from "@/contexts/AuthContext";
import "./SettingsScreen.css";

function SettingsScreen() {
  const navigate = useNavigate();
  const { user, signOut } = useAuth();

  // Placeholder check for "owner" - in real app this would be a role check
  const isOwner = true; // Hardcoded for demo

  return (
    <div className="bg-background-light dark:bg-background-dark font-display antialiased min-h-screen pb-20">
      <header className="sticky top-0 z-50 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-md border-b border-gray-200 dark:border-gray-800">
        <div className="flex items-center justify-between p-4">
          <h1 className="text-xl font-bold text-gray-900 dark:text-white">
            Settings
          </h1>
          <div className="w-8 h-8 rounded-full bg-gray-200 dark:bg-gray-700 flex items-center justify-center">
            <span className="material-symbols-outlined text-gray-500 dark:text-gray-400 text-sm">
              person
            </span>
          </div>
        </div>
      </header>

      <main className="px-4 py-6 space-y-6">
        {/* Profile Section */}
        <section className="flex items-center gap-4 mb-6">
          <div className="w-16 h-16 rounded-full bg-primary/20 flex items-center justify-center text-primary text-2xl font-bold border-2 border-primary">
            {user?.email?.charAt(0).toUpperCase() || "U"}
          </div>
          <div>
            <h2 className="text-lg font-bold text-gray-900 dark:text-white">
              {user?.email || "User"}
            </h2>
            <p className="text-sm text-gray-500 dark:text-gray-400">
              Standard Plan
            </p>
          </div>
        </section>

        {/* Owner Controls */}
        {isOwner && (
          <section>
            <h3 className="text-sm font-bold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-3 px-1">
              Owner Controls
            </h3>
            <div className="flex flex-col gap-3">
              <button
                onClick={() => navigate("/settings/privacy-rules")}
                className="settings-card flex items-center justify-between p-4 rounded-xl w-full text-left group"
              >
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-full bg-emerald-500/20 flex items-center justify-center text-emerald-400">
                    <span className="material-symbols-outlined">gavel</span>
                  </div>
                  <div>
                    <h4 className="font-bold text-gray-900 dark:text-white text-sm">
                      Family Governance
                    </h4>
                    <p className="text-xs text-gray-500 dark:text-gray-400">
                      Spousal & Admin Rules
                    </p>
                  </div>
                </div>
                <span className="material-symbols-outlined text-gray-400 group-hover:text-primary transition-colors">
                  chevron_right
                </span>
              </button>
              <button
                onClick={() => navigate("/settings/delegation")}
                className="settings-card flex items-center justify-between p-4 rounded-xl w-full text-left group"
              >
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-full bg-blue-500/20 flex items-center justify-center text-blue-400">
                    <span className="material-symbols-outlined">
                      shield_person
                    </span>
                  </div>
                  <div>
                    <h4 className="font-bold text-gray-900 dark:text-white text-sm">
                      Admin Delegation
                    </h4>
                    <p className="text-xs text-gray-500 dark:text-gray-400">
                      Manage edit permissions
                    </p>
                  </div>
                </div>
                <span className="material-symbols-outlined text-gray-400 group-hover:text-primary transition-colors">
                  chevron_right
                </span>
              </button>

              <button
                onClick={() => navigate("/settings/legacy-handover")}
                className="settings-card flex items-center justify-between p-4 rounded-xl w-full text-left group"
              >
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-full bg-purple-500/20 flex items-center justify-center text-purple-400">
                    <span className="material-symbols-outlined">
                      hourglass_empty
                    </span>
                  </div>
                  <div>
                    <h4 className="font-bold text-gray-900 dark:text-white text-sm">
                      Legacy Handover
                    </h4>
                    <p className="text-xs text-gray-500 dark:text-gray-400">
                      Protocol & Trustee setup
                    </p>
                  </div>
                </div>
                <span className="material-symbols-outlined text-gray-400 group-hover:text-primary transition-colors">
                  chevron_right
                </span>
              </button>

              <button
                onClick={() => navigate("/settings/infrastructure")}
                className="settings-card flex items-center justify-between p-4 rounded-xl w-full text-left group"
              >
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-full bg-cyan-500/20 flex items-center justify-center text-cyan-400">
                    <span className="material-symbols-outlined">dns</span>
                  </div>
                  <div>
                    <h4 className="font-bold text-gray-900 dark:text-white text-sm">
                      Infrastructure Controls
                    </h4>
                    <p className="text-xs text-gray-500 dark:text-gray-400">
                      Vault, Sync, AI Engine
                    </p>
                  </div>
                </div>
                <span className="material-symbols-outlined text-gray-400 group-hover:text-primary transition-colors">
                  chevron_right
                </span>
              </button>
            </div>
          </section>
        )}

        {/* General Settings */}
        <section>
          <h3 className="text-sm font-bold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-3 px-1">
            General
          </h3>
          <div className="flex flex-col gap-3">
            <button className="settings-card flex items-center justify-between p-4 rounded-xl w-full text-left group">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-full bg-gray-500/20 flex items-center justify-center text-gray-400">
                  <span className="material-symbols-outlined">
                    notifications
                  </span>
                </div>
                <div>
                  <h4 className="font-bold text-gray-900 dark:text-white text-sm">
                    Notifications
                  </h4>
                  <p className="text-xs text-gray-500 dark:text-gray-400">
                    Push, Email, SMS
                  </p>
                </div>
              </div>
              <span className="material-symbols-outlined text-gray-400 group-hover:text-primary transition-colors">
                chevron_right
              </span>
            </button>

            <button
              onClick={() => navigate("/settings/privacy-security")}
              className="settings-card flex items-center justify-between p-4 rounded-xl w-full text-left group"
            >
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-full bg-gray-500/20 flex items-center justify-center text-gray-400">
                  <span className="material-symbols-outlined">lock</span>
                </div>
                <div>
                  <h4 className="font-bold text-gray-900 dark:text-white text-sm">
                    Privacy & Security
                  </h4>
                  <p className="text-xs text-gray-500 dark:text-gray-400">
                    Password, 2FA
                  </p>
                </div>
              </div>
              <span className="material-symbols-outlined text-gray-400 group-hover:text-primary transition-colors">
                chevron_right
              </span>
            </button>
          </div>
        </section>

        <button
          onClick={signOut}
          className="w-full py-4 mt-8 rounded-xl bg-gray-100 dark:bg-gray-800 text-red-500 font-bold text-sm flex items-center justify-center gap-2 hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors"
        >
          <span className="material-symbols-outlined">logout</span>
          Sign Out
        </button>

        <div className="text-center text-xs text-gray-400 mt-4">
          Aevum v0.1.0 (Alpha)
        </div>
      </main>
      <BottomNav />
    </div>
  );
}

export default SettingsScreen;
