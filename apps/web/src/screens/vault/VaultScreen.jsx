// import { useNavigate } from "react-router-dom";
import "./VaultScreen.css";

function VaultScreen() {
  // const navigate = useNavigate();

  return (
    <div className="font-display bg-background-dark text-white overflow-hidden h-screen w-full relative mesh-gradient">
      {/* Header */}
      <header className="pt-12 px-6 pb-4 flex justify-between items-center z-20 relative">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Records Vault</h1>
          <p className="text-sm text-gray-400">Secure storage & archives</p>
        </div>
        <div className="glass-panel p-2 rounded-full relative">
          <span className="material-symbols-outlined text-gray-300">
            shield_lock
          </span>
        </div>
      </header>

      {/* Main Content */}
      <main className="flex-1 overflow-y-auto px-6 pb-24 scrollbar-hide z-10 relative h-[calc(100vh-160px)]">
        {/* Search Bar */}
        <div className="glass-panel rounded-xl flex items-center p-3 mb-6">
          <span className="material-symbols-outlined text-gray-400 mr-2">
            search
          </span>
          <input
            className="bg-transparent border-none outline-none text-sm text-white placeholder-gray-500 w-full focus:ring-0 p-0"
            placeholder="Search documents..."
            type="text"
          />
          <span className="material-symbols-outlined text-gray-400">tune</span>
        </div>

        {/* Vital Records Section */}
        <section className="mb-6">
          <div className="flex justify-between items-center mb-3">
            <h3 className="text-sm font-bold text-gray-300 uppercase tracking-wider">
              Vital Records
            </h3>
            <span className="text-xs text-primary font-medium cursor-pointer">
              View All
            </span>
          </div>
          <div className="grid grid-cols-2 gap-3">
            <div className="glass-panel p-3 rounded-2xl relative group overflow-hidden">
              <div className="h-20 bg-gradient-to-br from-blue-900/30 to-blue-600/10 rounded-lg mb-3 flex items-center justify-center relative overflow-hidden">
                <span className="material-symbols-outlined text-3xl text-blue-400 z-10">
                  verified
                </span>
                <div className="absolute inset-0 bg-white/5 blur-preview opacity-50"></div>
              </div>
              <h4 className="font-bold text-sm truncate">Birth Certificate</h4>
              <p className="text-[10px] text-gray-400 mt-1">
                Elena Ricci • 1992
              </p>
              <div className="absolute top-3 right-3 w-2 h-2 bg-success rounded-full"></div>
            </div>
            <div className="glass-panel p-3 rounded-2xl relative group overflow-hidden">
              <div className="h-20 bg-gradient-to-br from-gray-800 to-gray-700/50 rounded-lg mb-3 flex items-center justify-center relative overflow-hidden">
                <span className="material-symbols-outlined text-3xl text-gray-400 z-10">
                  description
                </span>
                <div className="absolute inset-0 bg-white/5 blur-preview opacity-50"></div>
              </div>
              <h4 className="font-bold text-sm truncate">Death Certificate</h4>
              <p className="text-[10px] text-gray-400 mt-1">
                Giovanni Ricci • 1945
              </p>
            </div>
          </div>
        </section>

        {/* Digital Vault Section */}
        <section className="mb-6">
          <div className="flex justify-between items-center mb-3">
            <h3 className="text-sm font-bold text-gray-300 uppercase tracking-wider">
              Digital Vault
            </h3>
            <div className="flex items-center gap-1">
              <span className="material-symbols-outlined text-[14px] text-gold">
                lock
              </span>
              <span className="text-[10px] text-gold font-bold">Encrypted</span>
            </div>
          </div>
          <div className="glass-panel rounded-2xl p-4 mb-3">
            <div className="flex items-center gap-4">
              <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-purple-500/20 to-indigo-500/20 flex items-center justify-center shrink-0 border border-purple-500/10">
                <span className="material-symbols-outlined text-purple-400">
                  admin_panel_settings
                </span>
              </div>
              <div className="flex-1 min-w-0">
                <h4 className="font-bold text-base text-white truncate">
                  Secure Identification
                </h4>
                <p className="text-xs text-gray-400 mt-0.5 truncate">
                  Passports, Driver's Licenses, IDs
                </p>
              </div>
              <span className="material-symbols-outlined text-gray-500">
                chevron_right
              </span>
            </div>
          </div>
          <div className="glass-panel rounded-2xl p-4">
            <div className="flex items-center gap-4">
              <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-emerald-500/20 to-teal-500/20 flex items-center justify-center shrink-0 border border-emerald-500/10">
                <span className="material-symbols-outlined text-emerald-400">
                  key
                </span>
              </div>
              <div className="flex-1 min-w-0">
                <h4 className="font-bold text-base text-white truncate">
                  Legacy Passwords
                </h4>
                <p className="text-xs text-gray-400 mt-0.5 truncate">
                  Digital Assets & Estate Access
                </p>
              </div>
              <span className="material-symbols-outlined text-gray-500">
                chevron_right
              </span>
            </div>
          </div>
        </section>

        {/* Historical Archives Section */}
        <section className="mb-20">
          <h3 className="text-sm font-bold text-gray-300 uppercase tracking-wider mb-3">
            Historical Archives
          </h3>
          <div className="grid grid-cols-1 gap-3">
            <div className="glass-panel rounded-2xl p-0 overflow-hidden relative">
              <div className="absolute inset-0 bg-gradient-to-r from-black/80 via-black/40 to-transparent z-10 pointer-events-none"></div>
              <img
                alt="Census Record"
                className="w-full h-24 object-cover opacity-60 grayscale mix-blend-overlay"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuDyFb_aap00-1Bxx_9bvAK3wLkoRKF7u-vqIgigZSv3n2BaP4nAFMMPvRG5d7e-GikDsfEL8SPnNAXoslikw7Ke7OR9-zTSuNk6QA3uvW-lMO4Wb4WACNKq9uauUDbkR2OrH58MOAOdTKqU1lf0vHl_W-TIojjAIDlyZlW-_toxNya2mhals7ECMyDUY-CrG4wl_NNdBldrH_a5s-g8MY0do5bW0PZTl9n4vngdqI5WbbwqSfYEzrsk6CGagk04BfDQoEKp6RF7tWI"
              />
              <div className="absolute inset-0 z-20 p-4 flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-full bg-orange-500/20 backdrop-blur-md flex items-center justify-center text-orange-400">
                    <span className="material-symbols-outlined text-lg">
                      history_edu
                    </span>
                  </div>
                  <div>
                    <h4 className="font-bold text-white text-sm">
                      1920 Census Record
                    </h4>
                    <p className="text-xs text-gray-300">
                      Family Household • New York
                    </p>
                  </div>
                </div>
                <span className="material-symbols-outlined text-white/50">
                  arrow_forward
                </span>
              </div>
            </div>
            <div className="glass-panel rounded-2xl p-0 overflow-hidden relative">
              <div className="absolute inset-0 bg-gradient-to-r from-black/80 via-black/40 to-transparent z-10 pointer-events-none"></div>
              <div className="w-full h-24 bg-blue-900/20"></div>
              <div className="absolute inset-0 z-20 p-4 flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-full bg-cyan-500/20 backdrop-blur-md flex items-center justify-center text-cyan-400">
                    <span className="material-symbols-outlined text-lg">
                      sailing
                    </span>
                  </div>
                  <div>
                    <h4 className="font-bold text-white text-sm">
                      Immigration Manifest
                    </h4>
                    <p className="text-xs text-gray-300">Ellis Island • 1904</p>
                  </div>
                </div>
                <span className="material-symbols-outlined text-white/50">
                  arrow_forward
                </span>
              </div>
            </div>
          </div>
        </section>
      </main>

      {/* Floating Action Button */}
      <div className="fixed bottom-24 right-6 z-40">
        <button className="bg-primary hover:bg-blue-600 text-white rounded-full p-4 flex items-center gap-2 glow-button transition-all transform hover:scale-105 active:scale-95">
          <span className="material-symbols-outlined">document_scanner</span>
          <span className="font-bold text-sm pr-1">Scan Document</span>
        </button>
      </div>
    </div>
  );
}

export default VaultScreen;
