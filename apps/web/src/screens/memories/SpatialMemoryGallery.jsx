import { useState } from "react";
import { useNavigate } from "react-router-dom";

const SpatialMemoryGallery = () => {
  const navigate = useNavigate();
  const [restorationLevel, setRestorationLevel] = useState(75);

  return (
    <div className="relative min-h-screen w-full flex flex-col items-center justify-center overflow-hidden font-display text-white antialiased bg-black/40">
      {/* Background with Vignette */}
      <div
        className="fixed inset-0 z-0 bg-cover bg-center bg-fixed"
        style={{
          backgroundImage:
            "url(https://lh3.googleusercontent.com/aida-public/AB6AXuAMAQhqMdKqwr9BF9W6q0-sjbW_8a4XY5le4vFKx9ZMeQAC9dONiMya5kEBT5KX1JwO4kq4EFqvFIWDOHBNP6pAEmKBPEIoEnIG0jRr_DQNDJ_dovshvrMAx4UGyVrHGSWBw-nYEBY95u16jHe2M6dMkzLTFC-y2S8WnF_dotVL9X2pwT3xwylTVOhKJy2HQhybn8_PdqOdxAP4I-in0Q_SSC6GtLcSYetRUi7LCMPS4T8av1QzhqW_5U9GJhblLrOhnklaIMbPCnQ)",
        }}
      >
        <div className="absolute inset-0 backdrop-blur-[40px] bg-black/20"></div>
      </div>

      {/* Floating Particles */}
      <div className="absolute top-1/4 left-1/4 w-32 h-32 rounded-full bg-radial-gradient from-white/80 to-transparent opacity-30 animate-pulse duration-[4000ms] pointer-events-none"></div>
      <div className="absolute bottom-1/3 right-1/4 w-20 h-20 rounded-full bg-radial-gradient from-white/80 to-transparent opacity-30 animate-pulse duration-[6000ms] pointer-events-none"></div>

      {/* Header */}
      <header className="absolute top-8 w-full px-6 z-50 flex justify-between items-center max-w-6xl">
        <div className="bg-white/10 backdrop-blur-2xl border border-white/30 shadow-lg px-5 py-2.5 rounded-full flex items-center gap-4">
          <button
            onClick={() => navigate(-1)}
            className="flex items-center justify-center w-8 h-8 rounded-full bg-white/10 hover:bg-white/20 transition-colors"
          >
            <span className="material-symbols-outlined text-[20px]">
              arrow_back
            </span>
          </button>
          <div className="h-6 w-px bg-white/20"></div>
          <div className="flex items-center gap-2">
            <span className="material-symbols-outlined text-primary">
              photo_library
            </span>
            <span className="font-bold tracking-wide text-sm">
              Spatial Gallery
            </span>
          </div>
        </div>

        <div className="bg-white/10 backdrop-blur-2xl border border-white/30 shadow-lg px-4 py-2 rounded-full flex items-center gap-3">
          <span className="material-symbols-outlined text-yellow-400 text-sm">
            auto_fix_high
          </span>
          <span className="text-xs font-medium tracking-wide">
            AI Restoration Active
          </span>
          <div className="w-2 h-2 rounded-full bg-green-500 animate-pulse"></div>
        </div>

        <div className="bg-white/10 backdrop-blur-2xl border border-white/30 shadow-lg p-2 rounded-full flex gap-2">
          <button className="p-2 hover:bg-white/10 rounded-full transition-colors">
            <span className="material-symbols-outlined text-[20px]">
              ios_share
            </span>
          </button>
          <button className="p-2 hover:bg-white/10 rounded-full transition-colors">
            <span className="material-symbols-outlined text-[20px]">
              more_horiz
            </span>
          </button>
        </div>
      </header>

      {/* Main Content: 3D Photo Frame */}
      <main className="relative w-full max-w-5xl h-full flex items-center justify-center z-10 perspective-2000 py-20">
        <div className="relative w-[800px] aspect-[4/3] bg-black/80 rounded-xl shadow-photo-depth group transform transition-transform duration-700 hover:rotate-x-0 rotate-x-6 preserve-3d">
          <img
            alt="Historical Family Gathering"
            className="w-full h-full object-cover rounded-xl opacity-90 mix-blend-normal brightness-110 contrast-110"
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuAMAQhqMdKqwr9BF9W6q0-sjbW_8a4XY5le4vFKx9ZMeQAC9dONiMya5kEBT5KX1JwO4kq4EFqvFIWDOHBNP6pAEmKBPEIoEnIG0jRr_DQNDJ_dovshvrMAx4UGyVrHGSWBw-nYEBY95u16jHe2M6dMkzLTFC-y2S8WnF_dotVL9X2pwT3xwylTVOhKJy2HQhybn8_PdqOdxAP4I-in0Q_SSC6GtLcSYetRUi7LCMPS4T8av1QzhqW_5U9GJhblLrOhnklaIMbPCnQ"
          />
          <div className="absolute inset-0 rounded-xl bg-gradient-to-t from-black/60 via-transparent to-black/20 pointer-events-none"></div>

          {/* AI Face Ring 1 (Eleanor) */}
          <div className="absolute top-[35%] left-[32%] w-16 h-16 group/face">
            <div className="absolute inset-0 rounded-full border-2 border-white/60 shadow-[0_0_15px_rgba(59,130,246,0.6),inset_0_0_10px_rgba(59,130,246,0.3)] cursor-pointer transition-all duration-300 hover:border-primary hover:shadow-[0_0_25px_rgba(59,130,246,0.8),inset_0_0_15px_rgba(59,130,246,0.5)] hover:scale-105 animate-[pulse-ring_3s_infinite]"></div>

            {/* Info Card Popover */}
            <div className="absolute -top-32 left-1/2 -translate-x-1/2 w-48 bg-white/10 backdrop-blur-xl border border-white/30 p-3 rounded-2xl z-50 opacity-0 group-hover/face:opacity-100 transform translate-y-2 group-hover/face:translate-y-0 transition-all duration-300 pointer-events-none group-hover/face:pointer-events-auto shadow-glass">
              <div className="flex items-center gap-2 mb-2">
                <div className="w-8 h-8 rounded-full overflow-hidden border border-white/30">
                  <img
                    className="w-full h-full object-cover"
                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuD0--YOXNDbLbWIddsCjq5vq9U1l6kLpHgVYUGdgffUsPBKcPc_aCMhSeNfy8Txgrb46V-GH-I_uihEXadY6fCjnjj4hoYwYkehbILFq-fHqO0yb9l-7m4tYTP9zUF0ISUJW8a-uwSTZDGQXib33FVotcpxhlWGwkY6JnbeRnjdI31P7sdF_kCguTYg7khsciRRZ0XLEmMAfr9tWmz54_yirPAAz5to9Z74r_RBmpIqKfRjSn8a5J-vgGGDcqqc0RrmahhLm8U7YR8"
                    alt="Eleanor"
                  />
                </div>
                <div>
                  <p className="text-sm font-bold leading-none">Eleanor</p>
                  <p className="text-[10px] text-gray-300">Grandmother</p>
                </div>
              </div>
              <div className="h-px bg-white/10 w-full mb-2"></div>
              <p className="text-[10px] text-gray-200">
                Identified with 98% confidence. Born 1934.
              </p>
            </div>
          </div>

          {/* AI Face Ring 2 (Arthur) */}
          <div className="absolute top-[32%] right-[38%] w-14 h-14 group/face">
            <div className="absolute inset-0 rounded-full border-2 border-white/60 shadow-[0_0_15px_rgba(168,85,247,0.6)] border-accent/50 cursor-pointer transition-all duration-300 hover:scale-105 animate-[pulse-ring_3s_infinite]"></div>

            {/* Info Card Popover */}
            <div className="absolute -top-32 left-1/2 -translate-x-1/2 w-48 bg-white/10 backdrop-blur-xl border border-white/30 p-3 rounded-2xl z-50 opacity-0 group-hover/face:opacity-100 transform translate-y-2 group-hover/face:translate-y-0 transition-all duration-300 pointer-events-none group-hover/face:pointer-events-auto shadow-glass">
              <div className="flex items-center gap-2 mb-2">
                <div className="w-8 h-8 rounded-full overflow-hidden border border-white/30">
                  <img
                    className="w-full h-full object-cover"
                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCDhLUFv5szvoRAVSbahWGywuRzLAKS4-XIM6otu1mt-r5W18nVWh3on-JbibTabUFGEIazSECismV9zfEyOmhl0n24Q5O7mKRpiqDqlGm6Ra5uo5jaGZjHAPSSuEuAIb8xgsQGpZIMMLRUC4KG7qDawkAs5h1aoi_NreIXlez8ZzJNQp1VMdgqDiRmbR6nVtcd5G9Q6n4WqK6g2ysTdSmIeCPEYqjBMMIByIk6I-igkeg-Ldkn-INnX79EPFGupTI4zCjqsE5yYIA"
                    alt="Arthur"
                  />
                </div>
                <div>
                  <p className="text-sm font-bold leading-none">Arthur</p>
                  <p className="text-[10px] text-gray-300">Grandfather</p>
                </div>
              </div>
              <div className="h-px bg-white/10 w-full mb-2"></div>
              <p className="text-[10px] text-gray-200">
                1929 - 1998. Wearing his service uniform.
              </p>
            </div>
          </div>

          {/* AI Face Ring 3 (Sarah) */}
          <div className="absolute bottom-[25%] left-[45%] w-12 h-12 group/face">
            <div className="absolute inset-0 rounded-full border-2 border-white/60 shadow-[0_0_15px_rgba(74,222,128,0.6)] border-green-400/50 cursor-pointer transition-all duration-300 hover:scale-105 animate-[pulse-ring_3s_infinite]"></div>

            {/* Info Card Popover */}
            <div className="absolute -bottom-32 left-1/2 -translate-x-1/2 w-48 bg-white/10 backdrop-blur-xl border border-white/30 p-3 rounded-2xl z-50 opacity-0 group-hover/face:opacity-100 transform translate-y-2 group-hover/face:translate-y-0 transition-all duration-300 pointer-events-none group-hover/face:pointer-events-auto shadow-glass">
              <div className="flex items-center gap-2 mb-2">
                <div className="w-8 h-8 rounded-full overflow-hidden border border-white/30">
                  <img
                    className="w-full h-full object-cover"
                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCMDbX7JieH4uSusSVXrUvvvaCAAPI4aD_oC_4HH3TYYaaG-MWB-lkJC0i5fqeWETP4Fpla1f0aiWNz0Qnnpheta8n14tyv8LTu_zGgEUtSplutOcD--os7vc6G8QwVoCNuCagef6G18FisqHgJhoiPOtcinMJvc9vmGZqdyPJiGMJ7LJMMqzfRpWsDer5q7bNtrqJ4zO_D0ikEjEncu0Cl4u0LdUdL4L7GVthH5d2s2rxrFgNIplVxTR-nKiZhkmaIl9sa1qYHCLE"
                    alt="Sarah"
                  />
                </div>
                <div>
                  <p className="text-sm font-bold leading-none">Sarah</p>
                  <p className="text-[10px] text-gray-300">Mother (Age 4)</p>
                </div>
              </div>
              <div className="h-px bg-white/10 w-full mb-2"></div>
              <button className="w-full py-1 rounded bg-white/10 hover:bg-white/20 text-[10px] flex items-center justify-center gap-1 transition-colors">
                <span className="material-symbols-outlined text-[12px]">
                  arrow_forward
                </span>{" "}
                View Childhood
              </button>
            </div>
          </div>

          {/* Photo Metadata */}
          <div className="absolute bottom-6 left-6 flex items-end gap-4 z-20">
            <div className="text-left">
              <h1 className="text-3xl font-display font-bold text-white drop-shadow-md">
                Summer Garden Party
              </h1>
              <p className="text-base text-gray-200 drop-shadow-sm flex items-center gap-1">
                <span className="material-symbols-outlined text-sm">
                  location_on
                </span>
                Sussex, England • July 15, 1962
              </p>
            </div>
          </div>

          {/* EXIF Data Badge */}
          <div className="absolute top-4 right-4 bg-white/10 backdrop-blur-md px-3 py-1 rounded-lg border border-white/20">
            <span className="text-xs font-mono text-gray-300">
              ISO 400 • f/2.8
            </span>
          </div>
        </div>
      </main>

      {/* Bottom Controls: Restoration Slider */}
      <div className="absolute bottom-12 left-1/2 -translate-x-1/2 w-full max-w-2xl px-8 z-50">
        <div className="bg-white/10 backdrop-blur-2xl border border-white/30 p-6 rounded-[2rem] flex flex-col gap-4 shadow-glass">
          <div className="flex justify-between items-center text-xs font-medium text-gray-400 px-1">
            <span className="text-white">Original (1962)</span>
            <span>Restoration Progress</span>
            <span className="text-primary">Enhanced (2024 AI)</span>
          </div>
          <div className="relative w-full h-8 flex items-center">
            {/* Custom Track */}
            <div className="absolute w-full h-1 bg-gray-600 rounded-full overflow-hidden">
              <div
                className="h-full bg-gradient-to-r from-gray-400 to-primary rounded-full transition-all duration-100"
                style={{ width: `${restorationLevel}%` }}
              ></div>
            </div>
            <input
              aria-label="Restoration Slider"
              className="relative z-10 w-full opacity-0 cursor-pointer h-full"
              type="range"
              min="0"
              max="100"
              value={restorationLevel}
              onChange={(e) => setRestorationLevel(e.target.value)}
            />
            {/* Custom Thumb (Visual Only - follows standard input via JS if we wanted, but CSS handles standard thumb too. 
                 Since Tailwind forms plugin is active, simple range input might be styled. 
                 Let's stick to simple input but with the visual track behind it. 
                 For a truly custom thumb we need more CSS or a library slider. 
                 I'll add the thumb style from the HTML snippet into a <style> block or inline styles) 
             */}
            <div
              className="absolute h-6 w-6 rounded-full bg-white border-2 border-primary/50 shadow-[0_0_10px_rgba(0,0,0,0.3)] pointer-events-none transition-all duration-100"
              style={{ left: `calc(${restorationLevel}% - 12px)` }}
            ></div>
          </div>

          <div className="flex justify-between items-center pt-2 border-t border-white/10 mt-1">
            <button className="flex items-center gap-2 text-xs text-gray-300 hover:text-white transition-colors">
              <span className="material-symbols-outlined text-lg">history</span>
              <span>1950s Era</span>
            </button>
            <div className="flex gap-1">
              <div className="w-1.5 h-1.5 rounded-full bg-white/20"></div>
              <div className="w-1.5 h-1.5 rounded-full bg-white/20"></div>
              <div className="w-6 h-1.5 rounded-full bg-white"></div>
              <div className="w-1.5 h-1.5 rounded-full bg-white/20"></div>
              <div className="w-1.5 h-1.5 rounded-full bg-white/20"></div>
            </div>
            <button className="flex items-center gap-2 text-xs text-gray-300 hover:text-white transition-colors">
              <span>1970s Era</span>
              <span className="material-symbols-outlined text-lg">
                arrow_forward
              </span>
            </button>
          </div>
        </div>
      </div>

      {/* Right Sidebar: Related Memories */}
      <aside className="absolute right-8 top-1/2 -translate-y-1/2 hidden lg:block w-72">
        <div className="bg-white/10 backdrop-blur-2xl border border-white/30 rounded-[2rem] p-5 flex flex-col gap-4 shadow-glass">
          <h3 className="text-sm font-bold uppercase tracking-wider text-gray-400">
            Related Memories
          </h3>

          <div className="group relative aspect-video rounded-lg overflow-hidden cursor-pointer border border-transparent hover:border-white/40 transition-all">
            <img
              className="w-full h-full object-cover opacity-70 group-hover:opacity-100 transition-opacity"
              src="https://lh3.googleusercontent.com/aida-public/AB6AXuBE_HpWIEztdgAPmQ24PPpDGgInaG2eGfLCYR0uzMZQHZp7cTtIfM-aTBo6lgG_-cqqedozeRBy7xOkVTdPA0hjGxmb4SQjT8f3QpW1s19VQegUqUG4Jya1EQELZ73cdZkDOzTFcWSWkPpB7nkjFcDHziIpEaWrCpsSUKug2uJPb9IIL14s2UdIDaWVah4FJJqUAVq5ZG3XKJHUXDcxYuGxF0qKZP6HgmrGbyJ0vBl0xJTMaq2ErB34vyWeYrvymT9Xg1EdaYPLJAM"
              alt="James Graduation"
            />
            <div className="absolute bottom-0 left-0 w-full p-2 bg-gradient-to-t from-black/80 to-transparent">
              <p className="text-xs font-bold">James's Graduation</p>
              <p className="text-[10px] text-gray-300">1965</p>
            </div>
          </div>

          <div className="group relative aspect-video rounded-lg overflow-hidden cursor-pointer border border-transparent hover:border-white/40 transition-all">
            <img
              className="w-full h-full object-cover opacity-70 group-hover:opacity-100 transition-opacity"
              src="https://lh3.googleusercontent.com/aida-public/AB6AXuDhl4SNeg9ZC9UWBbLI1ptM64bI-SW6FQw4tsJoMuZdChIXSIN7ll-oIXag-zciUa7w7KeM6lfGx0qXt85YQUheatD5I9-bFjpSOva_EseJBhW7LiVeGA7EvfFOSY1lL8cO9rNv3lc0HfzuNIqmo4QbsMedN2lYYPM5LFpFE8QaZ97TU5NgJFXSTWLjQGwwm3cG9lyau80rtSf9AH49ZMwUKmv-m48Lr3jcXREDHXmEqYfWgfqCT5nR2Bjz1yfygaixlp9X4Lx9_c4"
              alt="First Car"
            />
            <div className="absolute bottom-0 left-0 w-full p-2 bg-gradient-to-t from-black/80 to-transparent">
              <p className="text-xs font-bold">First Car</p>
              <p className="text-[10px] text-gray-300">1968</p>
            </div>
          </div>

          <button className="w-full py-3 mt-2 rounded-xl bg-white/5 hover:bg-white/10 border border-white/10 font-bold text-xs transition-all flex items-center justify-center gap-2">
            <span className="material-symbols-outlined text-sm">grid_view</span>
            View All from 1960s
          </button>
        </div>
      </aside>

      {/* CSS for custom depth effect and pulse ring if needed, though most things are Tailwind now. 
          The 'preserve-3d' and keyframes need custom CSS or config. */}
      <style>
        {`
          .preserve-3d { transform-style: preserve-3d; }
          .perspective-2000 { perspective: 2000px; }
          .rotate-x-6 { transform: rotateX(6deg); }
          .rotate-x-0 { transform: rotateX(0deg); }
          .shadow-photo-depth { box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5), 0 0 100px rgba(255, 255, 255, 0.1); }
          .shadow-glass { box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37); }
          
          /* Custom Keyframe for Pulse Ring */
          @keyframes pulse-ring {
            0% { box-shadow: 0 0 0 0 rgba(255, 255, 255, 0.4); }
            70% { box-shadow: 0 0 0 10px rgba(255, 255, 255, 0); }
            100% { box-shadow: 0 0 0 0 rgba(255, 255, 255, 0); }
          }
        `}
      </style>
    </div>
  );
};

export default SpatialMemoryGallery;
