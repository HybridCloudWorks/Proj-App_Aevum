import { useNavigate } from "react-router-dom";
import "./FamilyStoryScreen.css";

function FamilyStoryScreen() {
  const navigate = useNavigate();

  return (
    <div className="bg-background-light dark:bg-[#0F0F12] min-h-screen font-display text-white selection:bg-primary selection:text-white overflow-x-hidden">
      {/* Main Container */}
      <div className="relative mx-auto max-w-md min-h-screen flex flex-col pb-24 shadow-2xl bg-[#0F0F12]">
        {/* Header */}
        <header className="fixed top-0 left-0 right-0 z-50 flex items-center justify-between p-4 max-w-md mx-auto bg-gradient-to-b from-[#0F0F12]/90 to-transparent backdrop-blur-[2px]">
          <button
            aria-label="Go back"
            className="flex items-center justify-center w-10 h-10 rounded-full glass-btn text-white hover:bg-white/10"
            onClick={() => navigate(-1)}
          >
            <span className="material-symbols-outlined">
              arrow_back_ios_new
            </span>
          </button>
          <div className="text-sm font-semibold tracking-widest text-white/50 uppercase">
            Aevum
          </div>
          <button
            aria-label="History"
            className="flex items-center justify-center w-10 h-10 rounded-full glass-btn text-white hover:bg-white/10"
          >
            <span className="material-symbols-outlined">history</span>
          </button>
        </header>

        {/* Content Area */}
        <main className="flex-1 px-4 pt-20 flex flex-col gap-4">
          {/* Hero Story Card */}
          <div className="relative w-full rounded-2xl overflow-hidden glass-panel group min-h-[280px] flex flex-col justify-end p-5 shadow-lg shadow-black/20">
            {/* Background Image with Overlay */}
            <div className="absolute inset-0 z-0">
              <img
                alt="Vintage family portrait blurred"
                className="w-full h-full object-cover opacity-60 transition-transform duration-700 group-hover:scale-105"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuAFxmjBHW9zGTVF4RXoN3lE4v1KCAspwjBeoeQ_LK2k2deiOzBiJfaZQUkJGU4jn9vODG4q9-VI006-tdi4I_UDxm7T1UDQKzmzE5ruU71jZEa75lQ77JOyjIkIHshvCFqTBjOpz_LY7jwhnfW0ZRYAadAIssZlRiLBuB1jbK0wosHsJPYt-7Y41jk4Xx1Rro8fKre3oBpDsXf75DnaJ4cY8-yzXHVyXL0xEslI6bSVAtM70sNpwrFgMOPkH1oLlhNDon8SjbdJvrM"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-[#0F0F12] via-[#0F0F12]/60 to-transparent"></div>
              {/* Subtle primary glow */}
              <div className="absolute -bottom-20 -right-20 w-64 h-64 bg-primary/30 rounded-full blur-3xl"></div>
            </div>

            {/* Content */}
            <div className="relative z-10 flex flex-col gap-2">
              <div className="flex items-center gap-2 mb-1">
                <span className="px-2 py-0.5 rounded text-[10px] font-bold uppercase tracking-wider bg-primary/80 text-white border border-white/10 shadow-sm backdrop-blur-md">
                  AI Generated
                </span>
                <span className="text-xs text-white/60 font-medium flex items-center gap-1">
                  <span className="material-symbols-outlined text-[14px]">
                    calendar_today
                  </span>
                  Oct 24, 2023
                </span>
              </div>
              <h1 className="text-3xl font-bold leading-tight tracking-tight text-white drop-shadow-sm">
                The Journey of the{" "}
                <span className="text-primary">Miller Family</span>
              </h1>
              <p className="text-white/70 text-sm line-clamp-2">
                Tracing the lineage from the Highlands of Scotland to the
                bustling streets of New York.
              </p>
            </div>
          </div>

          {/* Bento Grid Layout */}
          <div className="grid grid-cols-2 gap-3 pb-4">
            {/* Tile 1: Chapter 1 Text (Span 2 columns) */}
            <div className="col-span-2 glass-panel p-5 rounded-2xl relative overflow-hidden">
              <div className="flex items-center gap-2 mb-3">
                <span className="material-symbols-outlined text-primary text-xl">
                  auto_stories
                </span>
                <h2 className="text-lg font-bold text-white">
                  Chapter 1: The Beginning
                </h2>
              </div>
              <p className="text-base text-gray-300 font-normal leading-relaxed">
                It began in the late 19th century when{" "}
                <span className="text-white font-medium">Arthur Miller</span>{" "}
                boarded a steamer ship from Glasgow, seeking new opportunities
                across the Atlantic. The sea was rough, and the journey lasted
                three arduous weeks.
              </p>
              <div className="absolute top-0 right-0 w-32 h-32 bg-white/5 rounded-full blur-3xl -mr-10 -mt-10 pointer-events-none"></div>
            </div>

            {/* Tile 2: Photo (Square) */}
            <div className="col-span-1 aspect-square rounded-2xl overflow-hidden glass-panel relative group">
              <img
                alt="Antique ship at dock"
                className="w-full h-full object-cover opacity-90 transition-transform duration-500 group-hover:scale-110"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuCg9EnIFkjKHqmwHrUb306rg_X6LD_q326QeK42Aqajkf2dgiBjExNzK7MLtrNZWSFJ9gDS89hluwJIpyCqfkrr_k8ar8zfjJwjV4XgdpyTXs55xoR_wP1H83oRc_jcAWYt-UHqBMFDSgaco8cIm9Subhj2dZ65z93Q4d7EkZ5ADIuFkCK3wk2MSwm5D6LD0MXvjbtblZNIW5JGwq6hQ6Tb-zoZEDeebtwUG6kfyzM8JzrSiTxbjvKQlg7N0yYQ89b1l0PjyFjUlWg"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent"></div>
              <div className="absolute bottom-3 left-3">
                <p className="text-white text-sm font-semibold">SS Caledonia</p>
                <p className="text-white/60 text-xs">Circa 1895</p>
              </div>
            </div>

            {/* Tile 3: Key Fact (Square) */}
            <div className="col-span-1 aspect-square rounded-2xl glass-panel p-4 flex flex-col justify-between relative overflow-hidden bg-primary/10 border-primary/20">
              <div className="absolute -right-4 -top-4 text-primary/10">
                <span className="material-symbols-outlined text-9xl">
                  location_on
                </span>
              </div>
              <div className="relative z-10 w-8 h-8 rounded-full bg-primary flex items-center justify-center text-white mb-2 shadow-lg shadow-primary/30">
                <span className="material-symbols-outlined text-sm">
                  anchor
                </span>
              </div>
              <div className="relative z-10">
                <p className="text-xs text-primary font-bold uppercase tracking-wide mb-1">
                  Arrival Port
                </p>
                <p className="text-lg font-bold text-white leading-tight">
                  Ellis Island, NY
                </p>
              </div>
            </div>

            {/* Tile 4: Narrative Continuation (Span 2) */}
            <div className="col-span-2 glass-panel p-5 rounded-2xl relative">
              <p className="text-base text-gray-300 font-normal leading-relaxed">
                Upon arrival, the family faced the harsh realities of immigrant
                life. However, Arthur's skill as a weaver proved invaluable. By
                1902, they had moved from the tenements to a modest home in
                Brooklyn.
              </p>
            </div>

            {/* Tile 5: Stats (Wide) */}
            <div className="col-span-2 rounded-2xl glass-panel p-4 flex items-center justify-between gap-4">
              <div className="flex-1 flex flex-col items-center justify-center border-r border-white/10">
                <span className="text-2xl font-bold text-white">142</span>
                <span className="text-xs text-white/50 uppercase tracking-wide">
                  Ancestors
                </span>
              </div>
              <div className="flex-1 flex flex-col items-center justify-center border-r border-white/10">
                <span className="text-2xl font-bold text-white">4</span>
                <span className="text-xs text-white/50 uppercase tracking-wide">
                  Generations
                </span>
              </div>
              <div className="flex-1 flex flex-col items-center justify-center">
                <span className="text-2xl font-bold text-white">1892</span>
                <span className="text-xs text-white/50 uppercase tracking-wide">
                  Earliest
                </span>
              </div>
            </div>

            {/* Tile 6: Map Visual */}
            <div className="col-span-2 h-40 rounded-2xl overflow-hidden glass-panel relative group">
              <img
                alt="Vintage map of New York"
                className="w-full h-full object-cover opacity-60 sepia-[.5]"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuAGwcBeGswcLPibjW4hrai2OVhLzVQU9WfvDi5eS1KWsy5OVPs3V3zqx_UtIEK_OUgW3v3Ic2-aJBsyGyhZQuOYS4TwqI2Yc2Miht3QjIqK6hPACkcrNS_2UoDiIotge4ogyPdiJ2ufM7sjD_ymgFuNQ90T-VC2fmqxQ2dNGAe3sVMMKNRDgnsd7Xxle3cqcF-RZiq6p9WcEvhjsjBHUHtfbfxBd-aXlEEEWFdfF5u4Axj3Eq3SHASkO8vDzqkVRJ0qkw3O5Ps2L20"
              />
              <div className="absolute inset-0 bg-black/40 flex items-center justify-center">
                <div className="bg-white/10 backdrop-blur-md border border-white/20 px-4 py-2 rounded-full flex items-center gap-2">
                  <span className="material-symbols-outlined text-primary text-sm">
                    map
                  </span>
                  <span className="text-sm font-medium text-white">
                    View Family Map
                  </span>
                </div>
              </div>
            </div>
          </div>
        </main>

        {/* Floating Action Bar */}
        <div className="fixed bottom-6 left-0 right-0 z-50 flex justify-center px-4 w-full max-w-md mx-auto pointer-events-none">
          <div className="flex items-center gap-3 w-full pointer-events-auto">
            {/* Generate Button */}
            <button className="flex-1 h-14 bg-primary hover:bg-primary/90 text-white rounded-xl shadow-lg shadow-primary/25 flex items-center justify-center gap-2 font-bold transition-all transform hover:-translate-y-1 active:scale-95">
              <span className="material-symbols-outlined">
                temp_preferences_custom
              </span>
              <span>Generate Story</span>
            </button>
            {/* Share Button */}
            <button
              aria-label="Share"
              className="w-14 h-14 glass-btn rounded-xl flex items-center justify-center text-white hover:bg-white/20 transition-all active:scale-95"
            >
              <span className="material-symbols-outlined">ios_share</span>
            </button>
          </div>
        </div>

        {/* Decorative Background Elements */}
        <div className="fixed top-0 left-0 w-full h-full pointer-events-none -z-10 overflow-hidden">
          <div className="absolute top-[-10%] left-[-10%] w-[50%] h-[50%] bg-primary/10 rounded-full blur-[100px]"></div>
          <div className="absolute bottom-[-10%] right-[-10%] w-[60%] h-[60%] bg-purple-900/10 rounded-full blur-[100px]"></div>
        </div>
      </div>
    </div>
  );
}

export default FamilyStoryScreen;
