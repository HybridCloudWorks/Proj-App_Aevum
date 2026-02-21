import { useState } from "react";
import { useNavigate } from "react-router-dom";

function PrivacySecurityScreen() {
  const navigate = useNavigate();
  const [biometricEnabled, setBiometricEnabled] = useState(true);
  const [visibility, setVisibility] = useState("immediate");
  const [alertDna, setAlertDna] = useState(true);
  const [alertTree, setAlertTree] = useState(false);

  return (
    <div className="font-display bg-background-dark text-white antialiased overflow-hidden relative selection:bg-primary/30 min-h-screen">
      {/* Abstract Background Pattern */}
      <div className="fixed inset-0 z-0 pointer-events-none">
        <div className="absolute inset-0 bg-gradient-to-br from-[#0f172a] to-[#1e1b4b]"></div>
        {/* Decorative Orbs */}
        <div className="absolute top-[-10%] left-[-10%] w-[500px] h-[500px] bg-primary/20 rounded-full blur-[120px] mix-blend-screen opacity-40"></div>
        <div className="absolute bottom-[-10%] right-[-10%] w-[400px] h-[400px] bg-purple-600/20 rounded-full blur-[100px] mix-blend-screen opacity-30"></div>
      </div>

      <div className="relative z-10 flex h-screen w-full flex-col max-w-md mx-auto shadow-2xl overflow-hidden glass-panel rounded-none sm:rounded-2xl sm:my-4 sm:h-[calc(100vh-2rem)] border-none sm:border-solid sm:border-white/10 bg-[#111928]/60 backdrop-blur-xl">
        {/* Header */}
        <header className="flex items-center px-4 py-5 pt-12 sm:pt-5 justify-between sticky top-0 z-20 backdrop-blur-md bg-[#111418]/30 border-b border-white/5">
          <button
            onClick={() => navigate(-1)}
            className="text-white/80 hover:text-white flex size-10 items-center justify-center rounded-full hover:bg-white/10 transition-colors"
          >
            <span className="material-symbols-outlined text-[24px]">
              arrow_back_ios_new
            </span>
          </button>
          <h1 className="text-white text-lg font-bold tracking-tight">
            Privacy & Security
          </h1>
          <button className="text-primary font-semibold text-base hover:text-primary/80 transition-colors">
            Save
          </button>
        </header>

        {/* Main Content (Scrollable) */}
        <main className="flex-1 overflow-y-auto p-4 space-y-6 scroll-smooth pb-10 custom-scrollbar">
          {/* Bento Grid - Top Section */}
          <div className="grid grid-cols-2 gap-3">
            {/* Biometric Vault Card */}
            <div className="col-span-1 glass-card p-4 rounded-2xl flex flex-col justify-between h-[160px] relative overflow-hidden group bg-white/5 border border-white/5 hover:bg-white/10 transition-all">
              <div className="absolute right-[-20px] top-[-20px] w-24 h-24 bg-primary/10 rounded-full blur-2xl group-hover:bg-primary/20 transition-all"></div>
              <div className="flex justify-between items-start">
                <div className="p-2 bg-white/5 rounded-xl text-primary w-fit">
                  <span className="material-symbols-outlined text-[28px]">
                    face
                  </span>
                </div>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input
                    type="checkbox"
                    checked={biometricEnabled}
                    onChange={() => setBiometricEnabled(!biometricEnabled)}
                    className="sr-only peer"
                  />
                  <div className="w-9 h-5 bg-slate-600/50 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-4 after:w-4 after:transition-all peer-checked:bg-primary"></div>
                </label>
              </div>
              <div>
                <h3 className="text-white text-sm font-bold leading-tight mb-1">
                  Biometric Vault
                </h3>
                <p className="text-white/50 text-xs">Secure with FaceID</p>
              </div>
            </div>

            {/* 2FA Card */}
            <div className="col-span-1 glass-card p-4 rounded-2xl flex flex-col justify-between h-[160px] relative overflow-hidden group bg-white/5 border border-white/5 hover:bg-white/10 transition-all">
              <div className="absolute right-[-20px] bottom-[-20px] w-24 h-24 bg-green-500/10 rounded-full blur-2xl group-hover:bg-green-500/20 transition-all"></div>
              <div className="flex justify-between items-start">
                <div className="p-2 bg-white/5 rounded-xl text-emerald-400 w-fit">
                  <span className="material-symbols-outlined text-[28px]">
                    phonelink_lock
                  </span>
                </div>
                <span className="text-xs font-medium px-2 py-0.5 rounded-full bg-emerald-500/20 text-emerald-300 border border-emerald-500/20">
                  Active
                </span>
              </div>
              <div>
                <h3 className="text-white text-sm font-bold leading-tight mb-1">
                  2-Step Verification
                </h3>
                <p className="text-white/50 text-xs">Added security layer</p>
              </div>
            </div>

            {/* Data Export Card (Full Width) */}
            <div className="col-span-2 glass-card p-5 rounded-2xl flex items-center justify-between gap-4 bg-white/5 border border-white/5">
              <div className="flex items-center gap-4">
                <div className="flex items-center justify-center size-12 rounded-full bg-white/5 shrink-0 text-sky-400">
                  <span className="material-symbols-outlined text-[24px]">
                    folder_zip
                  </span>
                </div>
                <div className="flex flex-col">
                  <p className="text-white text-base font-bold leading-tight">
                    Genealogy Archive
                  </p>
                  <p className="text-white/50 text-sm font-normal">
                    Export GEDCOM data
                  </p>
                </div>
              </div>
              <button className="flex shrink-0 cursor-pointer items-center justify-center rounded-lg h-9 px-4 bg-primary hover:bg-primary/90 transition-colors text-white text-sm font-medium leading-normal shadow-lg shadow-primary/20">
                <span>Export</span>
              </button>
            </div>
          </div>

          {/* Personal Visibility Section */}
          <div className="space-y-3">
            <div className="flex items-center gap-2 px-1">
              <span className="material-symbols-outlined text-white/70 text-[20px]">
                visibility
              </span>
              <h3 className="text-white text-base font-bold tracking-tight">
                Personal Visibility
              </h3>
            </div>
            <div className="glass-card rounded-2xl overflow-hidden divide-y divide-white/5 bg-white/5 border border-white/5">
              {/* Option 1 */}
              <label className="group flex items-center justify-between p-4 cursor-pointer hover:bg-white/[0.02] transition-colors">
                <div className="flex items-center gap-4">
                  <div className="p-2 rounded-lg bg-indigo-500/20 text-indigo-300">
                    <span className="material-symbols-outlined text-[20px]">
                      diversity_1
                    </span>
                  </div>
                  <div className="flex flex-col">
                    <p className="text-white text-sm font-semibold">
                      Immediate Family
                    </p>
                    <p className="text-white/50 text-xs">
                      Parents, Siblings, Children
                    </p>
                  </div>
                </div>
                <div className="flex items-center gap-3">
                  <span className="text-xs text-indigo-300 font-medium hidden sm:block">
                    Full Access
                  </span>
                  <div className="relative flex items-center">
                    <input
                      type="radio"
                      name="visibility"
                      checked={visibility === "immediate"}
                      onChange={() => setVisibility("immediate")}
                      className="peer h-5 w-5 cursor-pointer appearance-none rounded-full border-2 border-white/20 bg-transparent transition-all checked:border-primary checked:bg-primary hover:border-white/40"
                    />
                    <div className="pointer-events-none absolute left-1/2 top-1/2 h-2.5 w-2.5 -translate-x-1/2 -translate-y-1/2 rounded-full bg-white opacity-0 transition-opacity peer-checked:opacity-100"></div>
                  </div>
                </div>
              </label>

              {/* Option 2 */}
              <label className="group flex items-center justify-between p-4 cursor-pointer hover:bg-white/[0.02] transition-colors">
                <div className="flex items-center gap-4">
                  <div className="p-2 rounded-lg bg-orange-500/20 text-orange-300">
                    <span className="material-symbols-outlined text-[20px]">
                      diversity_3
                    </span>
                  </div>
                  <div className="flex flex-col">
                    <p className="text-white text-sm font-semibold">
                      Extended Family
                    </p>
                    <p className="text-white/50 text-xs">
                      Cousins, Aunts, Uncles
                    </p>
                  </div>
                </div>
                <div className="flex items-center gap-3">
                  <span className="text-xs text-orange-300 font-medium hidden sm:block">
                    Limited
                  </span>
                  <div className="relative flex items-center">
                    <input
                      type="radio"
                      name="visibility"
                      checked={visibility === "extended"}
                      onChange={() => setVisibility("extended")}
                      className="peer h-5 w-5 cursor-pointer appearance-none rounded-full border-2 border-white/20 bg-transparent transition-all checked:border-primary checked:bg-primary hover:border-white/40"
                    />
                    <div className="pointer-events-none absolute left-1/2 top-1/2 h-2.5 w-2.5 -translate-x-1/2 -translate-y-1/2 rounded-full bg-white opacity-0 transition-opacity peer-checked:opacity-100"></div>
                  </div>
                </div>
              </label>

              {/* Option 3 */}
              <label className="group flex items-center justify-between p-4 cursor-pointer hover:bg-white/[0.02] transition-colors">
                <div className="flex items-center gap-4">
                  <div className="p-2 rounded-lg bg-red-500/20 text-red-300">
                    <span className="material-symbols-outlined text-[20px]">
                      public_off
                    </span>
                  </div>
                  <div className="flex flex-col">
                    <p className="text-white text-sm font-semibold">Public</p>
                    <p className="text-white/50 text-xs">
                      Strangers, Search Engines
                    </p>
                  </div>
                </div>
                <div className="flex items-center gap-3">
                  <span className="text-xs text-red-300 font-medium hidden sm:block">
                    Hidden
                  </span>
                  <div className="relative flex items-center">
                    <input
                      type="radio"
                      name="visibility"
                      checked={visibility === "public"}
                      onChange={() => setVisibility("public")}
                      className="peer h-5 w-5 cursor-pointer appearance-none rounded-full border-2 border-white/20 bg-transparent transition-all checked:border-primary checked:bg-primary hover:border-white/40"
                    />
                    <div className="pointer-events-none absolute left-1/2 top-1/2 h-2.5 w-2.5 -translate-x-1/2 -translate-y-1/2 rounded-full bg-white opacity-0 transition-opacity peer-checked:opacity-100"></div>
                  </div>
                </div>
              </label>
            </div>
          </div>

          {/* Notifications Section */}
          <div className="space-y-3">
            <div className="flex items-center gap-2 px-1">
              <span className="material-symbols-outlined text-white/70 text-[20px]">
                notifications
              </span>
              <h3 className="text-white text-base font-bold tracking-tight">
                Alert Preferences
              </h3>
            </div>
            <div className="glass-card rounded-2xl p-5 space-y-5 bg-white/5 border border-white/5">
              <div className="flex items-center justify-between">
                <div className="flex flex-col">
                  <p className="text-white text-sm font-semibold">
                    DNA Matches
                  </p>
                  <p className="text-white/50 text-xs">
                    New genetic relatives found
                  </p>
                </div>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input
                    type="checkbox"
                    checked={alertDna}
                    onChange={() => setAlertDna(!alertDna)}
                    className="sr-only peer"
                  />
                  <div className="w-11 h-6 bg-slate-700/50 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary"></div>
                </label>
              </div>
              <div className="w-full h-px bg-gradient-to-r from-transparent via-white/10 to-transparent"></div>
              <div className="flex items-center justify-between">
                <div className="flex flex-col">
                  <p className="text-white text-sm font-semibold">
                    Tree Updates
                  </p>
                  <p className="text-white/50 text-xs">
                    Changes by family members
                  </p>
                </div>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input
                    type="checkbox"
                    checked={alertTree}
                    onChange={() => setAlertTree(!alertTree)}
                    className="sr-only peer"
                  />
                  <div className="w-11 h-6 bg-slate-700/50 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary"></div>
                </label>
              </div>
            </div>
          </div>

          {/* Admin Actions - Temporary Link for Demo */}
          <div className="pt-2">
            <button
              onClick={() => navigate("/settings/restricted-profile/demo")}
              className="w-full py-3 rounded-xl bg-amber-500/10 border border-amber-500/20 text-amber-500 text-sm font-bold hover:bg-amber-500/20 transition-colors flex items-center justify-center gap-2"
            >
              <span className="material-symbols-outlined">warning</span>
              Review Restricted Profiles
            </button>
          </div>

          {/* Delete Account Zone */}
          <div className="pt-4 pb-2 flex justify-center">
            <button className="text-red-400/80 hover:text-red-400 text-sm font-medium transition-colors flex items-center gap-2 px-4 py-2 rounded-lg hover:bg-red-400/10">
              <span className="material-symbols-outlined text-[18px]">
                delete
              </span>
              Delete Account & Data
            </button>
          </div>
        </main>

        {/* Bottom Tab Bar (Contextual Mockup) */}
        <nav className="h-16 glass-panel border-t border-white/5 grid grid-cols-4 items-center justify-items-center bg-[#111928]/80 backdrop-blur-md">
          <button className="flex flex-col items-center gap-1 text-white/40 hover:text-white transition-colors">
            <span className="material-symbols-outlined text-[24px]">
              account_tree
            </span>
            <span className="text-[10px] font-medium">Tree</span>
          </button>
          <button className="flex flex-col items-center gap-1 text-white/40 hover:text-white transition-colors">
            <span className="material-symbols-outlined text-[24px]">
              search
            </span>
            <span className="text-[10px] font-medium">Search</span>
          </button>
          <button className="flex flex-col items-center gap-1 text-white/40 hover:text-white transition-colors">
            <span className="material-symbols-outlined text-[24px]">mail</span>
            <span className="text-[10px] font-medium">Inbox</span>
          </button>
          <button className="flex flex-col items-center gap-1 text-primary">
            <span className="material-symbols-outlined text-[24px] fill-current">
              person
            </span>
            <span className="text-[10px] font-medium">Profile</span>
          </button>
        </nav>
      </div>
    </div>
  );
}

export default PrivacySecurityScreen;
