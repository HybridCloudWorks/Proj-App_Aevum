import { useState } from "react";
import { useNavigate } from "react-router-dom";

const AIResourceManager = () => {
  const navigate = useNavigate();
  const [queue, setQueue] = useState([
    {
      id: 1,
      title: "Arthur's Portrait",
      sub: "Waiting for available slot",
      img: "https://lh3.googleusercontent.com/aida-public/AB6AXuCDhLUFv5szvoRAVSbahWGywuRzLAKS4-XIM6otu1mt-r5W18nVWh3on-JbibTabUFGEIazSECismV9zfEyOmhl0n24Q5O7mKRpiqDqlGm6Ra5uo5jaGZjHAPSSuEuAIb8xgsQGpZIMMLRUC4KG7qDawkAs5h1aoi_NreIXlez8ZzJNQp1VMdgqDiRmbR6nVtcd5G9Q6n4WqK6g2ysTdSmIeCPEYqjBMMIByIk6I-igkeg-Ldkn-INnX79EPFGupTI4zCjqsE5yYIA",
    },
    {
      id: 2,
      title: "Summer of '69",
      sub: "Waiting for available slot",
      img: "https://lh3.googleusercontent.com/aida-public/AB6AXuBE_HpWIEztdgAPmQ24PPpDGgInaG2eGfLCYR0uzMZQHZp7cTtIfM-aTBo6lgG_-cqqedozeRBy7xOkVTdPA0hjGxmb4SQjT8f3QpW1s19VQegUqUG4Jya1EQELZ73cdZkDOzTFcWSWkPpB7nkjFcDHziIpEaWrCpsSUKug2uJPb9IIL14s2UdIDaWVah4FJJqUAVq5ZG3XKJHUXDcxYuGxF0qKZP6HgmrGbyJ0vBl0xJTMaq2ErB34vyWeYrvymT9Xg1EdaYPLJAM",
    },
    {
      id: 3,
      title: "Graduation Day",
      sub: "Waiting for available slot",
      img: "https://lh3.googleusercontent.com/aida-public/AB6AXuDKCc9h28kroPDbi3yood8DU_rRb3ppXuSOqZrG8teW6ch6R_8vfapd7N4QfLJHofpxTdRMHy5tKVxPnOvBKTJD9wb9Ck3TYscqNAGqTQh97zS8OCN56oVTx9HHSNs5eB4_Raud0eo912AHG48lT2xqpe9UkgqZL3rN6EdjfcyUJZQo4zI59IWMDGpaccvlMcPx9V3YD-nr2YKbqln8AAnukHWMmw0FJehG8ytrhsqdtDxsy2gFG3STyjTYUnTTGrXKVVTaGkAnO38",
    },
  ]);

  const prioritizeItem = (id) => {
    // Move item to top
    const itemIndex = queue.findIndex((i) => i.id === id);
    if (itemIndex > 0) {
      const newQueue = [...queue];
      const [item] = newQueue.splice(itemIndex, 1);
      newQueue.unshift(item);
      setQueue(newQueue);
    }
  };

  return (
    <div className="relative min-h-screen w-full flex flex-col items-center bg-black/40 font-display text-white antialiased overflow-y-auto">
      {/* Background */}
      <div
        className="fixed inset-0 z-0 bg-cover bg-center bg-fixed pointer-events-none"
        style={{
          backgroundImage:
            "url(https://lh3.googleusercontent.com/aida-public/AB6AXuAMAQhqMdKqwr9BF9W6q0-sjbW_8a4XY5le4vFKx9ZMeQAC9dONiMya5kEBT5KX1JwO4kq4EFqvFIWDOHBNP6pAEmKBPEIoEnIG0jRr_DQNDJ_dovshvrMAx4UGyVrHGSWBw-nYEBY95u16jHe2M6dMkzLTFC-y2S8WnF_dotVL9X2pwT3xwylTVOhKJy2HQhybn8_PdqOdxAP4I-in0Q_SSC6GtLcSYetRUi7LCMPS4T8av1QzhqW_5U9GJhblLrOhnklaIMbPCnQ)",
        }}
      >
        <div className="absolute inset-0 bg-radial-gradient from-transparent via-black/40 to-black/80"></div>
        <div className="absolute inset-0 backdrop-blur-[12px]"></div>
      </div>

      {/* Header */}
      <header className="fixed top-0 left-0 w-full px-6 py-6 z-50 flex justify-between items-center bg-gradient-to-b from-black/50 to-transparent pointer-events-none">
        <button
          onClick={() => navigate(-1)}
          className="flex items-center justify-center size-10 rounded-full bg-white/10 hover:bg-white/20 border border-white/10 transition backdrop-blur-md pointer-events-auto"
        >
          <span className="material-symbols-outlined text-[20px]">
            arrow_back_ios_new
          </span>
        </button>
        <span className="font-bold tracking-wide text-sm opacity-80 uppercase">
          Aevum AI Engine
        </span>
        <button className="flex items-center justify-center size-10 rounded-full bg-white/10 hover:bg-white/20 border border-white/10 transition backdrop-blur-md pointer-events-auto">
          <span className="material-symbols-outlined text-[20px]">
            settings
          </span>
        </button>
      </header>

      {/* Main Content */}
      <main className="relative w-full max-w-md flex flex-col gap-6 z-10 pt-24 pb-32 px-6">
        {/* Enhancement Progress Card */}
        <section className="bg-white/10 backdrop-blur-2xl border border-white/20 shadow-glass rounded-[2rem] p-8 text-center relative overflow-hidden group">
          <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-primary to-transparent opacity-50"></div>
          <div className="absolute -top-10 -right-10 w-32 h-32 bg-primary/20 rounded-full blur-2xl animate-pulse pointer-events-none"></div>
          <div
            className="absolute -bottom-10 -left-10 w-32 h-32 bg-accent/20 rounded-full blur-2xl animate-pulse pointer-events-none"
            style={{ animationDelay: "1s" }}
          ></div>

          <div className="relative z-10 flex flex-col items-center">
            <div className="w-16 h-16 rounded-full bg-gradient-to-br from-primary/20 to-accent/20 border border-white/20 flex items-center justify-center mb-4 shadow-[0_0_20px_rgba(59,130,246,0.5)]">
              <span className="material-symbols-outlined text-3xl text-primary animate-pulse">
                auto_awesome
              </span>
            </div>
            <h1 className="text-2xl font-bold mb-2 bg-clip-text text-transparent bg-gradient-to-r from-white via-blue-100 to-white">
              Enhancement in Progress
            </h1>
            <p className="text-gray-300 text-sm leading-relaxed mb-6">
              Our AI is currently restoring high-fidelity details from your
              archive. To ensure quality, we're processing your queue in
              batches.
            </p>

            <div className="w-full bg-white/10 rounded-full h-2 mb-2 overflow-hidden border border-white/5">
              <div className="bg-gradient-to-r from-primary via-blue-400 to-accent h-full rounded-full w-[65%] shadow-[0_0_10px_rgba(59,130,246,0.5)] relative">
                <div className="absolute inset-0 bg-white/20 animate-[shimmer_2s_infinite]"></div>
              </div>
            </div>

            <div className="flex justify-between w-full text-xs text-gray-400 font-medium px-1">
              <span>Processing Batch 3/5</span>
              <span>~12 mins remaining</span>
            </div>
          </div>
        </section>

        {/* Currently Enhancing Section */}
        <section className="flex flex-col gap-3">
          <div className="flex items-center justify-between px-2">
            <h3 className="text-sm font-bold text-gray-200 uppercase tracking-wider">
              Currently Enhancing
            </h3>
            <span className="text-xs text-primary bg-primary/10 px-2 py-0.5 rounded border border-primary/20">
              Active
            </span>
          </div>

          <div className="bg-white/10 backdrop-blur-2xl border border-white/20 shadow-glass rounded-2xl p-4 flex gap-4 items-center">
            <div className="relative w-16 h-16 rounded-xl overflow-hidden flex-shrink-0 border border-white/20">
              <img
                alt="Enhancing"
                className="w-full h-full object-cover opacity-80"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuD0--YOXNDbLbWIddsCjq5vq9U1l6kLpHgVYUGdgffUsPBKcPc_aCMhSeNfy8Txgrb46V-GH-I_uihEXadY6fCjnjj4hoYwYkehbILFq-fHqO0yb9l-7m4tYTP9zUF0ISUJW8a-uwSTZDGQXib33FVotcpxhlWGwkY6JnbeRnjdI31P7sdF_kCguTYg7khsciRRZ0XLEmMAfr9tWmz54_yirPAAz5to9Z74r_RBmpIqKfRjSn8a5J-vgGGDcqqc0RrmahhLm8U7YR8"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-primary/40 to-transparent"></div>
              <div className="absolute bottom-0 left-0 w-full h-0.5 bg-primary animate-pulse"></div>
            </div>
            <div className="flex-1 min-w-0">
              <h4 className="font-bold text-base truncate">
                Wedding of Eleanor & Arthur
              </h4>
              <p className="text-xs text-gray-400 mb-2">
                1942 • Colorization & Upscaling
              </p>
              <div className="flex items-center gap-2 text-[10px] text-gray-300">
                <span className="material-symbols-outlined text-[12px] animate-spin">
                  sync
                </span>
                Processing texture details...
              </div>
            </div>
          </div>
        </section>

        {/* Queue Section */}
        <section className="flex flex-col gap-3">
          <div className="flex items-center justify-between px-2">
            <h3 className="text-sm font-bold text-gray-200 uppercase tracking-wider">
              Next in Queue
            </h3>
            <button className="text-xs text-blue-300 hover:text-white transition-colors">
              View All
            </button>
          </div>

          <div className="space-y-3">
            {queue.map((item) => (
              <div
                key={item.id}
                className="bg-[rgba(20,20,30,0.4)] backdrop-blur-xl border border-white/10 hover:bg-white/5 transition-colors rounded-xl p-3 flex items-center justify-between group border-l-2 border-l-transparent hover:border-l-accent"
              >
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-lg bg-gray-700 overflow-hidden relative">
                    <img
                      className="w-full h-full object-cover opacity-60 grayscale group-hover:grayscale-0 transition duration-500"
                      src={item.img}
                      alt={item.title}
                    />
                  </div>
                  <div>
                    <div className="text-sm font-medium">{item.title}</div>
                    <div className="text-[10px] text-gray-400">{item.sub}</div>
                  </div>
                </div>
                <button
                  onClick={() => prioritizeItem(item.id)}
                  className="px-3 py-1.5 rounded-lg bg-white/5 hover:bg-accent hover:text-white border border-white/10 text-xs font-medium transition-all flex items-center gap-1 group/btn"
                >
                  <span>Prioritize</span>
                  <span className="material-symbols-outlined text-[14px] group-hover/btn:rotate-45 transition-transform">
                    arrow_upward
                  </span>
                </button>
              </div>
            ))}
          </div>
        </section>

        {/* Info Box */}
        <section className="bg-white/10 backdrop-blur-2xl border border-white/20 rounded-2xl p-4 mt-2">
          <div className="flex items-start gap-3">
            <span className="material-symbols-outlined text-blue-300 mt-0.5">
              info
            </span>
            <div className="text-xs text-gray-300 leading-relaxed">
              <span className="text-white font-bold block mb-1">
                Why is there a wait?
              </span>
              High-fidelity restoration requires significant processing power.
              We limit concurrent tasks to ensure the highest quality output for
              every memory.
            </div>
          </div>
        </section>

        {/* Boost Button */}
        <button className="w-full py-4 rounded-xl bg-gradient-to-r from-primary to-blue-600 hover:from-blue-400 hover:to-primary border border-white/20 font-bold text-sm shadow-[0_0_20px_rgba(59,130,246,0.5)] transition-all flex items-center justify-center gap-2 group">
          <span className="material-symbols-outlined group-hover:animate-pulse">
            bolt
          </span>
          Boost Processing Speed
        </button>
      </main>

      {/* Bottom Floating Nav Mockup (as per screenshot/html for visual parity) */}
      <div className="fixed bottom-6 left-1/2 -translate-x-1/2 z-50">
        <div className="bg-white/10 backdrop-blur-2xl border border-white/20 px-2 py-2 rounded-full flex items-center gap-1">
          <button className="p-3 hover:bg-white/10 rounded-full transition text-gray-400 hover:text-white">
            <span className="material-symbols-outlined text-[24px]">home</span>
          </button>
          <button className="p-3 bg-white/10 rounded-full transition text-white shadow-[0_0_20px_rgba(59,130,246,0.5)] border border-white/10">
            <span className="material-symbols-outlined text-[24px]">
              memory
            </span>
          </button>
          <button className="p-3 hover:bg-white/10 rounded-full transition text-gray-400 hover:text-white">
            <span className="material-symbols-outlined text-[24px]">
              account_circle
            </span>
          </button>
        </div>
      </div>

      <style>
        {`
                @keyframes shimmer {
                    0% { transform: translateX(-100%); }
                    100% { transform: translateX(100%); }
                }
                .shadow-glass { box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37); }
                `}
      </style>
    </div>
  );
};

export default AIResourceManager;
