// import { useState } from "react";
import { useNavigate } from "react-router-dom";

const SpatialHeritageTree = () => {
  const navigate = useNavigate();

  return (
    <div className="relative min-h-screen w-full flex flex-col items-center justify-center overflow-hidden font-display text-white antialiased">
      {/* Background Image & Overlay */}
      <div
        className="fixed inset-0 z-0 bg-cover bg-center bg-fixed"
        style={{
          backgroundImage:
            "url(https://lh3.googleusercontent.com/aida-public/AB6AXuAMAQhqMdKqwr9BF9W6q0-sjbW_8a4XY5le4vFKx9ZMeQAC9dONiMya5kEBT5KX1JwO4kq4EFqvFIWDOHBNP6pAEmKBPEIoEnIG0jRr_DQNDJ_dovshvrMAx4UGyVrHGSWBw-nYEBY95u16jHe2M6dMkzLTFC-y2S8WnF_dotVL9X2pwT3xwylTVOhKJy2HQhybn8_PdqOdxAP4I-in0Q_SSC6GtLcSYetRUi7LCMPS4T8av1QzhqW_5U9GJhblLrOhnklaIMbPCnQ)",
        }}
      >
        {/* Vignette */}
        <div className="absolute inset-0 bg-radial-gradient from-transparent via-transparent to-black/60 z-10 pointer-events-none"></div>
        {/* Blur */}
        <div className="absolute inset-0 backdrop-blur-[8px] z-0"></div>
      </div>

      {/* Header */}
      <header className="absolute top-8 w-full px-6 z-50 flex justify-between items-center max-w-5xl">
        <div className="bg-white/10 backdrop-blur-2xl border border-white/30 shadow-lg px-5 py-2.5 rounded-full flex items-center gap-4">
          <button
            onClick={() => navigate(-1)}
            className="flex items-center justify-center size-8 rounded-full bg-white/10 hover:bg-white/20 transition-colors"
          >
            <span className="material-symbols-outlined text-[20px]">
              arrow_back_ios_new
            </span>
          </button>
          <div className="h-6 w-px bg-white/20"></div>
          <div className="flex items-center gap-2">
            <span className="material-symbols-outlined text-primary">
              schema
            </span>
            <span className="font-bold tracking-wide text-sm">
              Aevum Spatial
            </span>
          </div>
        </div>

        <div className="bg-white/10 backdrop-blur-2xl border border-white/30 shadow-lg px-3 py-1.5 rounded-full flex items-center gap-4">
          <div className="flex -space-x-2">
            <div className="w-8 h-8 rounded-full border-2 border-white/20 bg-gray-500 overflow-hidden relative">
              <img
                alt="User"
                className="object-cover w-full h-full opacity-80"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuDKCc9h28kroPDbi3yood8DU_rRb3ppXuSOqZrG8teW6ch6R_8vfapd7N4QfLJHofpxTdRMHy5tKVxPnOvBKTJD9wb9Ck3TYscqNAGqTQh97zS8OCN56oVTx9HHSNs5eB4_Raud0eo912AHG48lT2xqpe9UkgqZL3rN6EdjfcyUJZQo4zI59IWMDGpaccvlMcPx9V3YD-nr2YKbqln8AAnukHWMmw0FJehG8ytrhsqdtDxsy2gFG3STyjTYUnTTGrXKVVTaGkAnO38"
              />
            </div>
          </div>
          <span className="text-xs font-medium pr-2">The Sterling Lineage</span>
        </div>

        <div className="bg-white/10 backdrop-blur-2xl border border-white/30 shadow-lg p-2 rounded-full flex gap-2">
          <button className="p-2 hover:bg-white/10 rounded-full transition-colors">
            <span className="material-symbols-outlined text-[20px]">
              search
            </span>
          </button>
          <button className="p-2 hover:bg-white/10 rounded-full transition-colors">
            <span className="material-symbols-outlined text-[20px]">
              filter_list
            </span>
          </button>
        </div>
      </header>

      {/* Main Content: Spatial Tree */}
      <main className="relative w-full max-w-5xl h-full flex items-center justify-center z-10 perspective-1000 py-32">
        <div className="relative w-full h-[600px] flex items-center justify-center transform-style-3d rotate-y-12 animate-float">
          {/* SVG Connections */}
          <svg className="absolute inset-0 w-full h-full pointer-events-none z-0 overflow-visible">
            <defs>
              <linearGradient
                id="gradientLine"
                x1="0%"
                x2="100%"
                y1="0%"
                y2="0%"
              >
                <stop offset="0%" stopColor="rgba(59, 130, 246, 0.2)"></stop>
                <stop offset="50%" stopColor="rgba(59, 130, 246, 0.8)"></stop>
                <stop offset="100%" stopColor="rgba(59, 130, 246, 0.2)"></stop>
              </linearGradient>
            </defs>
            {/* Bezier Curves connecting nodes */}
            {/* Hardcoded paths tailored to the specific absolute positions below */}
            <path
              className="opacity-60"
              d="M512 150 C 512 200, 350 200, 350 280"
              fill="none"
              stroke="url(#gradientLine)"
              strokeWidth="2"
            ></path>
            <path
              className="opacity-60"
              d="M512 150 C 512 200, 674 200, 674 280"
              fill="none"
              stroke="url(#gradientLine)"
              strokeWidth="2"
            ></path>
            <path
              className="opacity-80"
              d="M350 340 C 350 400, 512 400, 512 450"
              fill="none"
              stroke="url(#gradientLine)"
              strokeWidth="2"
            ></path>
            <path
              className="opacity-80"
              d="M674 340 C 674 400, 512 400, 512 450"
              fill="none"
              stroke="url(#gradientLine)"
              strokeWidth="2"
            ></path>
          </svg>

          {/* Node: Eleanor (Top Left) */}
          <div className="absolute top-[10%] left-[30%] flex flex-col items-center gap-3 transform hover:scale-105 transition duration-300 group">
            <div className="relative w-20 h-20 rounded-full flex items-center justify-center overflow-hidden cursor-pointer node-sphere">
              <img
                alt="Grandmother"
                className="w-full h-full object-cover opacity-90 mix-blend-overlay"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuD0--YOXNDbLbWIddsCjq5vq9U1l6kLpHgVYUGdgffUsPBKcPc_aCMhSeNfy8Txgrb46V-GH-I_uihEXadY6fCjnjj4hoYwYkehbILFq-fHqO0yb9l-7m4tYTP9zUF0ISUJW8a-uwSTZDGQXib33FVotcpxhlWGwkY6JnbeRnjdI31P7sdF_kCguTYg7khsciRRZ0XLEmMAfr9tWmz54_yirPAAz5to9Z74r_RBmpIqKfRjSn8a5J-vgGGDcqqc0RrmahhLm8U7YR8"
              />
              <div className="absolute inset-0 bg-blue-500/20"></div>
            </div>
            <div className="bg-white/10 backdrop-blur-md border border-white/20 px-3 py-1 rounded-full text-xs font-medium">
              Eleanor
            </div>
          </div>

          {/* Node: Arthur (Top Right) */}
          <div className="absolute top-[10%] right-[30%] flex flex-col items-center gap-3 transform hover:scale-105 transition duration-300 group">
            <div className="relative w-20 h-20 rounded-full flex items-center justify-center overflow-hidden cursor-pointer node-sphere">
              <img
                alt="Grandfather"
                className="w-full h-full object-cover opacity-90 mix-blend-overlay"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuCDhLUFv5szvoRAVSbahWGywuRzLAKS4-XIM6otu1mt-r5W18nVWh3on-JbibTabUFGEIazSECismV9zfEyOmhl0n24Q5O7mKRpiqDqlGm6Ra5uo5jaGZjHAPSSuEuAIb8xgsQGpZIMMLRUC4KG7qDawkAs5h1aoi_NreIXlez8ZzJNQp1VMdgqDiRmbR6nVtcd5G9Q6n4WqK6g2ysTdSmIeCPEYqjBMMIByIk6I-igkeg-Ldkn-INnX79EPFGupTI4zCjqsE5yYIA"
              />
              <div className="absolute inset-0 bg-blue-500/20"></div>
            </div>
            <div className="bg-white/10 backdrop-blur-md border border-white/20 px-3 py-1 rounded-full text-xs font-medium">
              Arthur
            </div>
          </div>

          {/* Node: Sarah (Middle Left) */}
          <div className="absolute top-[40%] left-[20%] flex flex-col items-center gap-3 transform hover:scale-105 transition duration-300 group">
            <div className="relative w-24 h-24 rounded-full flex items-center justify-center overflow-hidden cursor-pointer node-sphere ring-4 ring-white/5">
              <img
                alt="Mother"
                className="w-full h-full object-cover opacity-90 mix-blend-overlay"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuCMDbX7JieH4uSusSVXrUvvvaCAAPI4aD_oC_4HH3TYYaaG-MWB-lkJC0i5fqeWETP4Fpla1f0aiWNz0Qnnpheta8n14tyv8LTu_zGgEUtSplutOcD--os7vc6G8QwVoCNuCagef6G18FisqHgJhoiPOtcinMJvc9vmGZqdyPJiGMJ7LJMMqzfRpWsDer5q7bNtrqJ4zO_D0ikEjEncu0Cl4u0LdUdL4L7GVthH5d2s2rxrFgNIplVxTR-nKiZhkmaIl9sa1qYHCLE"
              />
            </div>
            <div className="bg-white/10 backdrop-blur-md border border-white/20 px-4 py-1.5 rounded-full text-sm font-medium">
              Sarah
            </div>
          </div>

          {/* Node: James (Middle Right) */}
          <div className="absolute top-[40%] right-[20%] flex flex-col items-center gap-3 transform hover:scale-105 transition duration-300 group">
            <div className="relative w-24 h-24 rounded-full flex items-center justify-center overflow-hidden cursor-pointer node-sphere ring-4 ring-white/5">
              <img
                alt="Father"
                className="w-full h-full object-cover opacity-90 mix-blend-overlay"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuBE_HpWIEztdgAPmQ24PPpDGgInaG2eGfLCYR0uzMZQHZp7cTtIfM-aTBo6lgG_-cqqedozeRBy7xOkVTdPA0hjGxmb4SQjT8f3QpW1s19VQegUqUG4Jya1EQELZ73cdZkDOzTFcWSWkPpB7nkjFcDHziIpEaWrCpsSUKug2uJPb9IIL14s2UdIDaWVah4FJJqUAVq5ZG3XKJHUXDcxYuGxF0qKZP6HgmrGbyJ0vBl0xJTMaq2ErB34vyWeYrvymT9Xg1EdaYPLJAM"
              />
            </div>
            <div className="bg-white/10 backdrop-blur-md border border-white/20 px-4 py-1.5 rounded-full text-sm font-medium">
              James
            </div>
          </div>

          {/* Node: Clara (You - Center Bottom) */}
          <div className="absolute top-[65%] left-1/2 -translate-x-1/2 flex flex-col items-center gap-4 z-30">
            <div className="relative">
              <div className="absolute -inset-4 bg-primary/20 rounded-full blur-xl animate-pulse"></div>
              <div className="relative w-32 h-32 rounded-full flex items-center justify-center overflow-hidden cursor-pointer node-sphere active ring-4 ring-primary/30">
                <img
                  alt="You"
                  className="w-full h-full object-cover opacity-95 mix-blend-normal"
                  src="https://lh3.googleusercontent.com/aida-public/AB6AXuDhl4SNeg9ZC9UWBbLI1ptM64bI-SW6FQw4tsJoMuZdChIXSIN7ll-oIXag-zciUa7w7KeM6lfGx0qXt85YQUheatD5I9-bFjpSOva_EseJBhW7LiVeGA7EvfFOSY1lL8cO9rNv3lc0HfzuNIqmo4QbsMedN2lYYPM5LFpFE8QaZ97TU5NgJFXSTWLjQGwwm3cG9lyau80rtSf9AH49ZMwUKmv-m48Lr3jcXREDHXmEqYfWgfqCT5nR2Bjz1yfygaixlp9X4Lx9_c4"
                />
              </div>
              <div className="absolute bottom-0 right-0 bg-primary w-8 h-8 rounded-full flex items-center justify-center border-2 border-white/20 shadow-lg">
                <span className="material-symbols-outlined text-[16px] text-white">
                  visibility
                </span>
              </div>
            </div>
            <div className="bg-white/10 backdrop-blur-xl border border-primary/30 bg-primary/10 px-6 py-2 rounded-2xl text-lg font-bold">
              Clara Sterling
            </div>
          </div>
        </div>
      </main>

      {/* Right Sidebar: Profile Details */}
      <aside className="absolute right-8 top-1/2 -translate-y-1/2 w-80 perspective-500 hidden md:block">
        <div className="bg-white/10 backdrop-blur-2xl border border-white/30 shadow-glass rounded-[2rem] p-6 transform rotate-y-[-10deg] hover:rotate-y-0 transition-transform duration-500 origin-left">
          <div className="flex justify-between items-start mb-6">
            <div>
              <h2 className="text-2xl font-bold">Clara Sterling</h2>
              <p className="text-sm text-blue-200">Born 1996 • London, UK</p>
            </div>
            <button className="bg-white/10 p-2 rounded-full hover:bg-white/20 transition-colors">
              <span className="material-symbols-outlined text-[20px]">
                edit
              </span>
            </button>
          </div>

          <div className="grid grid-cols-2 gap-3 mb-4">
            <div className="bg-white/5 rounded-xl p-3 border border-white/10 hover:bg-white/10 transition-colors cursor-pointer group">
              <span className="material-symbols-outlined text-accent mb-1 group-hover:scale-110 transition-transform">
                photo_library
              </span>
              <div className="text-xs text-gray-400">Media</div>
              <div className="text-lg font-bold">245</div>
            </div>
            <div className="bg-white/5 rounded-xl p-3 border border-white/10 hover:bg-white/10 transition-colors cursor-pointer group">
              <span className="material-symbols-outlined text-green-400 mb-1 group-hover:scale-110 transition-transform">
                description
              </span>
              <div className="text-xs text-gray-400">Documents</div>
              <div className="text-lg font-bold">12</div>
            </div>
          </div>

          <div className="bg-white/5 rounded-xl p-4 border border-white/10 mb-4">
            <div className="flex items-center gap-2 mb-2">
              <span className="material-symbols-outlined text-yellow-400 text-[18px]">
                history_edu
              </span>
              <span className="text-sm font-bold">Bio Highlight</span>
            </div>
            <p className="text-xs text-gray-300 leading-relaxed">
              Architect and amateur historian. Restored the Victorian archive of
              the Sterling family in 2023.
            </p>
          </div>

          <button className="w-full py-3 rounded-xl bg-gradient-to-r from-primary/80 to-accent/80 hover:from-primary hover:to-accent border border-white/20 font-bold text-sm shadow-[0_0_20px_rgba(59,130,246,0.5)] transition-all">
            Explore Timeline
          </button>
        </div>
      </aside>

      {/* Bottom Nav */}
      <div className="absolute bottom-10 left-1/2 -translate-x-1/2">
        <div className="bg-white/10 backdrop-blur-2xl border border-white/30 shadow-glass px-6 py-3 rounded-full flex items-center gap-8">
          <button className="flex flex-col items-center gap-1 group">
            <div className="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center group-hover:bg-primary group-hover:text-white transition-all">
              <span className="material-symbols-outlined">zoom_out_map</span>
            </div>
            <span className="text-[10px] text-gray-300 font-medium tracking-wide">
              Expand
            </span>
          </button>

          <button className="flex flex-col items-center gap-1 group">
            <div className="w-12 h-12 rounded-full bg-primary/20 border border-primary/50 flex items-center justify-center shadow-[0_0_20px_rgba(59,130,246,0.5)] group-hover:scale-110 transition-transform">
              <span className="material-symbols-outlined text-white">
                travel_explore
              </span>
            </div>
            <span className="text-[10px] text-white font-bold tracking-wide">
              Explore
            </span>
          </button>

          <button className="flex flex-col items-center gap-1 group">
            <div className="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center group-hover:bg-primary group-hover:text-white transition-all">
              <span className="material-symbols-outlined">share</span>
            </div>
            <span className="text-[10px] text-gray-300 font-medium tracking-wide">
              Share
            </span>
          </button>
        </div>
      </div>

      <style>
        {`
        .node-sphere {
            background: radial-gradient(circle at 30% 30%, rgba(255, 255, 255, 0.9), rgba(255, 255, 255, 0.4) 40%, rgba(255, 255, 255, 0.1) 80%);
            backdrop-filter: blur(4px);
            border: 1px solid rgba(255, 255, 255, 0.4);
            box-shadow: inset -5px -5px 15px rgba(0, 0, 0, 0.1), 0 0 20px rgba(255, 255, 255, 0.2);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            z-index: 10;
        }
        .node-sphere:hover, .node-sphere.active {
            box-shadow: 0 0 30px rgba(59, 130, 246, 0.6), inset 0 0 20px rgba(59, 130, 246, 0.2);
            border-color: rgba(59, 130, 246, 0.5);
            transform: scale(1.1);
            z-index: 20;
        }
        .animate-float {
             animation: float 6s ease-in-out infinite;
        }
        @keyframes float {
            0% { transform: translateY(0px) rotateY(12deg); }
            50% { transform: translateY(-10px) rotateY(12deg); }
            100% { transform: translateY(0px) rotateY(12deg); }
        }
        .perspective-1000 { perspective: 1000px; }
        .transform-style-3d { transform-style: preserve-3d; }
        `}
      </style>
    </div>
  );
};

export default SpatialHeritageTree;
