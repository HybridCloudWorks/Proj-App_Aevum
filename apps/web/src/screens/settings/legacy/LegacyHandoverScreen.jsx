import { useNavigate } from "react-router-dom";
import "./LegacyHandoverScreen.css";

function LegacyHandoverScreen() {
  const navigate = useNavigate();

  return (
    <div
      className="font-display antialiased flex flex-col items-center justify-start overflow-y-auto overflow-x-hidden pb-10 min-h-screen text-white bg-cover bg-center bg-fixed"
      style={{
        backgroundImage:
          "url('https://lh3.googleusercontent.com/aida-public/AB6AXuAMAQhqMdKqwr9BF9W6q0-sjbW_8a4XY5le4vFKx9ZMeQAC9dONiMya5kEBT5KX1JwO4kq4EFqvFIWDOHBNP6pAEmKBPEIoEnIG0jRr_DQNDJ_dovshvrMAx4UGyVrHGSWBw-nYEBY95u16jHe2M6dMkzLTFC-y2S8WnF_dotVL9X2pwT3xwylTVOhKJy2HQhybn8_PdqOdxAP4I-in0Q_SSC6GtLcSYetRUi7LCMPS4T8av1QzhqW_5U9GJhblLrOhnklaIMbPCnQ')",
      }}
    >
      <div className="fixed inset-0 bg-black/40 z-0"></div>
      <header className="sticky top-0 z-50 w-full px-5 pt-12 pb-4 bg-gradient-to-b from-black/60 to-transparent backdrop-blur-sm">
        <div className="flex items-center justify-between">
          <button
            className="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center backdrop-blur-md border border-white/10"
            onClick={() => navigate(-1)}
          >
            <span className="material-symbols-outlined text-white">
              arrow_back
            </span>
          </button>
          <h1 className="text-lg font-bold tracking-wide">Legacy Handover</h1>
          <button className="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center backdrop-blur-md border border-white/10 text-primary">
            <span className="material-symbols-outlined">save</span>
          </button>
        </div>
      </header>
      <main className="relative z-10 w-full max-w-md px-5 flex flex-col gap-6 mt-2">
        <div className="spatial-glass rounded-3xl p-6 relative overflow-hidden group">
          <div className="absolute -right-10 -top-10 w-32 h-32 bg-primary/20 blur-3xl rounded-full pointer-events-none"></div>
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-full bg-green-500/20 border border-green-500/50 flex items-center justify-center">
                <span className="material-symbols-outlined text-green-400">
                  shield_lock
                </span>
              </div>
              <div>
                <h2 className="font-bold text-lg">Protocol Active</h2>
                <p className="text-xs text-green-300">Vault Encrypted</p>
              </div>
            </div>
            <input defaultChecked className="ios-toggle" type="checkbox" />
          </div>
          <p className="text-sm text-gray-300 leading-relaxed">
            The Legacy Handover protocol monitors your activity. If triggered,
            your designated trustees will receive access to the vault.
          </p>
        </div>
        <section className="space-y-3">
          <div className="flex items-center justify-between px-1">
            <h3 className="text-sm font-bold text-gray-300 uppercase tracking-wider">
              Inactivity Trigger
            </h3>
            <span className="text-xs text-primary font-medium">
              Auto-detect
            </span>
          </div>
          <div className="spatial-glass rounded-3xl p-6">
            <div className="flex justify-between items-center mb-6">
              <span className="text-gray-400 text-sm">Wait period</span>
              <span className="text-2xl font-bold">6 Months</span>
            </div>
            <input
              className="w-full h-2 bg-white/10 rounded-lg appearance-none cursor-pointer slider-thumb accent-primary mb-6"
              max="12"
              min="1"
              type="range"
              defaultValue="6"
            />
            <div className="flex justify-between text-xs text-gray-500 font-medium px-1">
              <span>1 Month</span>
              <span>1 Year</span>
            </div>
            <div className="mt-6 pt-6 border-t border-white/10 flex items-start gap-3">
              <span className="material-symbols-outlined text-gray-400 text-lg mt-0.5">
                info
              </span>
              <p className="text-xs text-gray-400 leading-relaxed">
                We will attempt to contact you via email, SMS, and push
                notification 3 times before initiating the handover sequence.
              </p>
            </div>
          </div>
        </section>
        <section className="space-y-3">
          <div className="flex items-center justify-between px-1">
            <h3 className="text-sm font-bold text-gray-300 uppercase tracking-wider">
              Designated Trustees
            </h3>
            <button className="text-xs text-primary font-medium flex items-center gap-1 hover:text-primary/80 transition-colors">
              <span className="material-symbols-outlined text-sm">add</span> Add
              New
            </button>
          </div>
          <div className="grid grid-cols-1 gap-3">
            <div className="bento-card rounded-2xl p-4 flex items-center justify-between">
              <div className="flex items-center gap-4">
                <div className="w-12 h-12 rounded-full overflow-hidden border-2 border-white/10">
                  <img
                    alt="Trustee"
                    className="w-full h-full object-cover"
                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCMDbX7JieH4uSusSVXrUvvvaCAAPI4aD_oC_4HH3TYYaaG-MWB-lkJC0i5fqeWETP4Fpla1f0aiWNz0Qnnpheta8n14tyv8LTu_zGgEUtSplutOcD--os7vc6G8QwVoCNuCagef6G18FisqHgJhoiPOtcinMJvc9vmGZqdyPJiGMJ7LJMMqzfRpWsDer5q7bNtrqJ4zO_D0ikEjEncu0Cl4u0LdUdL4L7GVthH5d2s2rxrFgNIplVxTR-nKiZhkmaIl9sa1qYHCLE"
                  />
                </div>
                <div>
                  <h4 className="font-bold text-sm">Sarah Sterling</h4>
                  <div className="flex items-center gap-1 text-xs text-green-400 mt-0.5">
                    <span className="material-symbols-outlined text-[10px] fill-1">
                      verified_user
                    </span>
                    <span>Verified Trustee</span>
                  </div>
                </div>
              </div>
              <button className="w-8 h-8 rounded-full bg-white/5 hover:bg-white/10 flex items-center justify-center">
                <span className="material-symbols-outlined text-gray-400 text-sm">
                  more_horiz
                </span>
              </button>
            </div>
            <div className="bento-card rounded-2xl p-4 flex items-center justify-between">
              <div className="flex items-center gap-4">
                <div className="w-12 h-12 rounded-full overflow-hidden border-2 border-white/10 relative">
                  <img
                    alt="Trustee"
                    className="w-full h-full object-cover opacity-60 grayscale"
                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuBE_HpWIEztdgAPmQ24PPpDGgInaG2eGfLCYR0uzMZQHZp7cTtIfM-aTBo6lgG_-cqqedozeRBy7xOkVTdPA0hjGxmb4SQjT8f3QpW1s19VQegUqUG4Jya1EQELZ73cdZkDOzTFcWSWkPpB7nkjFcDHziIpEaWrCpsSUKug2uJPb9IIL14s2UdIDaWVah4FJJqUAVq5ZG3XKJHUXDcxYuGxF0qKZP6HgmrGbyJ0vBl0xJTMaq2ErB34vyWeYrvymT9Xg1EdaYPLJAM"
                  />
                  <div className="absolute inset-0 flex items-center justify-center bg-black/30">
                    <span className="material-symbols-outlined text-white text-sm">
                      hourglass_empty
                    </span>
                  </div>
                </div>
                <div>
                  <h4 className="font-bold text-sm text-gray-300">
                    James Sterling
                  </h4>
                  <div className="flex items-center gap-1 text-xs text-yellow-500 mt-0.5">
                    <span>Pending Acceptance</span>
                  </div>
                </div>
              </div>
              <button className="w-8 h-8 rounded-full bg-white/5 hover:bg-white/10 flex items-center justify-center">
                <span className="material-symbols-outlined text-gray-400 text-sm">
                  refresh
                </span>
              </button>
            </div>
          </div>
        </section>
        <section className="space-y-3">
          <div className="flex items-center justify-between px-1">
            <h3 className="text-sm font-bold text-gray-300 uppercase tracking-wider">
              Final Instructions
            </h3>
            <span className="text-xs text-gray-400">
              Last edited: 2 days ago
            </span>
          </div>
          <div className="spatial-glass rounded-3xl p-1 relative group cursor-pointer hover:bg-white/5 transition-colors">
            <div className="absolute top-4 right-4 z-10">
              <span className="material-symbols-outlined text-gray-400 text-lg">
                edit_note
              </span>
            </div>
            <div className="bg-black/20 rounded-[20px] p-5 backdrop-blur-sm">
              <div className="flex items-center gap-3 mb-3 border-b border-white/5 pb-3">
                <span className="material-symbols-outlined text-accent">
                  mail
                </span>
                <span className="font-display font-medium text-sm text-accent">
                  My Digital Letter
                </span>
              </div>
              <p className="text-gray-400 text-sm italic font-serif leading-relaxed line-clamp-3 opacity-80">
                "To my dearest family, if you are reading this, it means the
                time has come for you to take stewardship of our history. The
                vault key contained within represents generations of..."
              </p>
              <div className="mt-3 flex items-center gap-2">
                <div className="h-1 w-full bg-white/10 rounded-full overflow-hidden">
                  <div className="h-full w-3/4 bg-accent/50 rounded-full"></div>
                </div>
                <span className="text-[10px] text-gray-500 whitespace-nowrap">
                  Voice Note Attached
                </span>
              </div>
            </div>
          </div>
        </section>
        <div className="mt-4 pt-4 border-t border-white/10 flex flex-col gap-4 items-center text-center">
          <p className="text-xs text-gray-500">
            Changes to the Legacy Handover protocol require biometric
            confirmation.
          </p>
          <button className="w-full py-4 rounded-2xl bg-gradient-to-r from-primary to-blue-600 font-bold text-white shadow-lg shadow-blue-900/50 flex items-center justify-center gap-2 hover:scale-[1.02] transition-transform active:scale-[0.98]">
            <span className="material-symbols-outlined">fingerprint</span>
            <span>Confirm & Save Settings</span>
          </button>
        </div>
      </main>
    </div>
  );
}

export default LegacyHandoverScreen;
