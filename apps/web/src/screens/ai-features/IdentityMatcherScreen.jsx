import { useNavigate } from "react-router-dom";
import "./IdentityMatcherScreen.css";

function IdentityMatcherScreen() {
  const navigate = useNavigate();

  return (
    <div className="bg-background-dark text-slate-200 min-h-screen flex flex-col font-display antialiased overflow-x-hidden selection:bg-primary/30">
      <div className="h-12 w-full"></div>
      {/* Header */}
      <header className="flex items-center justify-between px-6 py-4 sticky top-0 z-50 bg-background-dark/80 backdrop-blur-lg">
        <button
          onClick={() => navigate(-1)}
          className="flex items-center justify-center w-10 h-10 rounded-full hover:bg-white/5 transition-colors"
        >
          <span className="material-symbols-outlined text-[24px]">
            arrow_back
          </span>
        </button>
        <h1 className="text-[17px] font-bold tracking-tight">Identify Faces</h1>
        <button className="text-[15px] font-semibold text-slate-400 hover:text-primary transition-colors">
          Skip
        </button>
      </header>
      <main className="flex-1 flex flex-col gap-6 px-6 pb-12 max-w-md mx-auto w-full">
        {/* Main Photo with detection box */}
        <div className="relative w-full aspect-[4/3] rounded-3xl overflow-hidden glass-panel group shadow-2xl ring-1 ring-white/10">
          <div
            className="absolute inset-0 bg-cover bg-center"
            style={{
              backgroundImage:
                "url('https://lh3.googleusercontent.com/aida-public/AB6AXuC31RpQX57UnykwreUCc1soshAuPgixpGwElecNvQXJSif9R6dIbPPm0zmW6RHa7tjxEgZtuSVpi3k2_i1U5keZSMfcKSoN63rF_cmlAs4G6EciEafIpZyLQqrzMwKGBmucasxYidpGUFHoDgS_YjYEDpWZzRUl3QLJ3gaNFw8-T2Ey2fboKwpq3-4GLm_vuhp7DZEHLbAN---O1iWdAKzJkHVHEp_pYQ7H-gYYgBoj5mcHx-Vo76VwBxdADbZ-gQk6LFwU29mfDRs')",
            }}
          >
            <div className="absolute inset-0 bg-black/10"></div>
          </div>
          {/* Active Detection Box */}
          <div className="absolute top-[30%] left-[43%] w-[22%] h-[28%] border-[2.5px] border-primary rounded-2xl shadow-[0_0_25px_rgba(17,115,212,0.4)] z-20">
            <div className="absolute -top-9 left-1/2 -translate-x-1/2 bg-primary text-white text-[10px] font-extrabold px-3 py-1 rounded-full whitespace-nowrap shadow-lg tracking-wider uppercase">
              Selected
            </div>
          </div>
          {/* Inactive Detection Boxes */}
          <div className="absolute top-[35%] left-[20%] w-[16%] h-[20%] border border-white/50 rounded-xl z-10 backdrop-blur-[1px]"></div>
          <div className="absolute top-[28%] left-[70%] w-[18%] h-[22%] border border-white/50 rounded-xl z-10 backdrop-blur-[1px]"></div>
          {/* Date Badge */}
          <div className="absolute bottom-4 left-4 flex gap-2">
            <div className="bg-black/40 backdrop-blur-md px-3 py-1.5 rounded-full border border-white/10 flex items-center gap-1.5">
              <span className="material-symbols-outlined text-[14px] text-white/70">
                calendar_today
              </span>
              <span className="text-[11px] font-bold text-white/90 uppercase tracking-widest">
                1964
              </span>
            </div>
          </div>
        </div>

        {/* Question Header */}
        <div className="space-y-1">
          <h2 className="text-[28px] font-extrabold text-white leading-tight tracking-tight">
            Is this <span className="text-primary">Grandpa Joe</span>?
          </h2>
          <p className="text-[14px] text-slate-400 font-medium">
            Found in "Summer Vacation 1964"
          </p>
        </div>

        {/* Suggestion Slider */}
        <div className="flex gap-4 overflow-x-auto pb-2 -mx-6 px-6 scrollbar-hide snap-x">
          {/* Match 1 (Primary) */}
          <div className="snap-center shrink-0 flex flex-col gap-4 p-5 rounded-3xl glass-panel-active min-w-[150px] relative border-primary/40">
            <div className="absolute top-3 right-3 flex items-center justify-center w-6 h-6 bg-primary rounded-full shadow-lg">
              <span className="material-symbols-outlined text-white text-[16px] font-bold">
                check
              </span>
            </div>
            <div
              className="w-16 h-16 rounded-full bg-cover bg-center border-2 border-primary shadow-[0_0_15px_rgba(17,115,212,0.3)] mx-auto"
              style={{
                backgroundImage:
                  "url('https://lh3.googleusercontent.com/aida-public/AB6AXuDQG7P7lNixOixWvE-uS3QVuXaZo73C1_JToDK4GOiaD53rADv7ZLGMfrfENeu5KKJCtFWoy0hiyQ6EPq4uOX6mu5eybJK8NXPVc1S_p77UXJ-z_2gk2HcIfj4MVG3AEW9ZqXROc5W3YnRZfLSo_YzzVJrA4D8XJqZzG_HQBr78F8alwK74qJkLeiVrNMAJb9jR2mPq3m1RN-L92BvA2qgUFYsht_QfWe8Crbu1KqY9H0gWRT9v1A9GpVzo9epCGr_ECpIFR7gs3kk')",
              }}
            ></div>
            <div className="text-center">
              <p className="text-sm font-bold text-white tracking-wide">
                Grandpa Joe
              </p>
              <div className="mt-1.5 inline-flex bg-primary/20 px-2 py-0.5 rounded-full">
                <span className="text-[10px] font-extrabold text-primary tracking-tight">
                  98% MATCH
                </span>
              </div>
            </div>
          </div>

          {/* Match 2 */}
          <div className="snap-center shrink-0 flex flex-col gap-4 p-5 rounded-3xl glass-panel min-w-[150px] cursor-pointer hover:bg-white/5 transition-all">
            <div
              className="w-16 h-16 rounded-full bg-cover bg-center border border-white/10 opacity-60 mx-auto grayscale"
              style={{
                backgroundImage:
                  "url('https://lh3.googleusercontent.com/aida-public/AB6AXuBd-l6-9V3Ex2vMHKhRjeppS1TU2PWOD27Ok4JlbnfgpLrHhEp1NjFJpIgghXZfZW1RzYUnwfZMpThAHHQ5ePpwHVZy31S5xeTL2wrj4fOZbhU8aTT4HC4TJ_66d7Cw0jUv-YnvyThMPWmHuvHhCOLD8h67Zk8k5KaHttOXqEtPTllTUWMbp17pwIcd6v6LLmDTqQ1uudhu7r8Alhv3-6rqRScb32F-CNV9FIBvdadhlDnNMyME3QePtPLJaIAV3V0MYfqyrfQd2as')",
              }}
            ></div>
            <div className="text-center">
              <p className="text-sm font-semibold text-slate-300">Uncle Bob</p>
              <p className="text-[11px] font-bold text-slate-500 mt-1 uppercase tracking-tighter">
                45% Match
              </p>
            </div>
          </div>

          {/* Add New */}
          <div className="snap-center shrink-0 flex flex-col items-center justify-center gap-3 p-5 rounded-3xl glass-panel min-w-[150px] border-dashed border-white/20 hover:bg-white/5 transition-all">
            <div className="w-14 h-14 rounded-full bg-white/5 flex items-center justify-center text-slate-400">
              <span className="material-symbols-outlined text-[32px]">add</span>
            </div>
            <p className="text-sm font-semibold text-slate-400">New Person</p>
          </div>
        </div>

        {/* Info Grid */}
        <div className="grid grid-cols-2 gap-4">
          <div className="glass-panel p-5 rounded-3xl flex flex-col gap-4">
            <div className="flex items-center gap-2">
              <span className="material-symbols-outlined text-primary text-[20px]">
                groups
              </span>
              <h3 className="text-[10px] font-black uppercase tracking-[0.15em] text-slate-500">
                AI Grouping
              </h3>
            </div>
            <p className="text-[13px] text-white font-semibold leading-snug">
              Seen in <span className="text-primary">12 other photos</span>
            </p>
            <div className="flex -space-x-3 mt-1">
              <div
                className="w-10 h-10 rounded-full border-2 border-background-dark bg-cover bg-center ring-1 ring-white/5"
                style={{
                  backgroundImage:
                    "url('https://lh3.googleusercontent.com/aida-public/AB6AXuDEt93VvmPatuIdcvBAtnOsxhF60XyfQD21bTbIw0x_Pvx0GJV0L7SRZagvjhdUzqKVhqByw2c7d1RmaD5rfaPprFioXhjUnjLXnHP75wfR8ubwbnlSBUViwOW2PMgRFlFGQg62Y7FCcDQWdKgt1VBjA08nQnNj0oXk7WA8xs8DBGuNVoSKEE6Gi6uQGdWyg36MOk8D5RrgYktOxUhddQs3yM475s1oJhS0gf6I3OR147mUDZT68u5KNJCSlFDtmQfC74_D4f7eseU')",
                }}
              ></div>
              <div
                className="w-10 h-10 rounded-full border-2 border-background-dark bg-cover bg-center ring-1 ring-white/5"
                style={{
                  backgroundImage:
                    "url('https://lh3.googleusercontent.com/aida-public/AB6AXuBf7xm8Z9piMx_mY5YoM2D0l6Bg3LC8L-t3BGxfhtL9dDdRvUI32SnovMSetReN1ZTOnZC2P-JKAvVU7rmoOQDUZtq_6EGx3X8OSsRMYW7a_cWJcF8IkIsKg8fvVoFlf-Qz4LWmGoJaBnusZQxXp_vfqNWZoiXlDSK2yVJB7rCPQAewLSUHiwTGV4vCcyWicr6hwa7w8uJN-JGVQUsU9Um-nwt8v8LhQ5kFcGkRNENBZ76K90zTVYjtqq2uYva7gMD4jNBiqP4UVVI')",
                }}
              ></div>
              <div
                className="w-10 h-10 rounded-full border-2 border-background-dark bg-cover bg-center ring-1 ring-white/5"
                style={{
                  backgroundImage:
                    "url('https://lh3.googleusercontent.com/aida-public/AB6AXuDvdZlAcdH-arBCQtllaYrgDaWwGGMRaMBu2q7Hc0-eUbz1eNmDdGj-oudRxM68nv_-ji303R8fmdTNpFErADfWJOvpQhrfwYAakGRy8j_dK9J7tY5j2gPsL7EeObEZWPepIRZSQ-Dcl-6wocNcFCmMpRmswVVinw0XyUomhavnm5IrVSyvCLMZnfRHQ2CTAqioFkjSI4H7X39tqnGCL2hVWz0L0IqD2hxNvkIlgUtAw1Ga6n9-ddBQA4dofF4ZvLq7PIsSA3Jg8O8')",
                }}
              ></div>
              <div className="w-10 h-10 rounded-full border-2 border-background-dark bg-slate-800 flex items-center justify-center text-[10px] font-bold text-slate-300 ring-1 ring-white/5">
                +9
              </div>
            </div>
          </div>
          <div className="glass-panel p-5 rounded-3xl flex flex-col justify-between">
            <div className="space-y-3">
              <div className="flex items-center gap-2">
                <span className="material-symbols-outlined text-primary text-[20px]">
                  account_tree
                </span>
                <h3 className="text-[10px] font-black uppercase tracking-[0.15em] text-slate-500">
                  Family Tree
                </h3>
              </div>
              <p className="text-[13px] text-white font-semibold">
                Suggested from{" "}
                <span className="text-primary underline decoration-primary/30 underline-offset-4">
                  Paternal Line
                </span>
              </p>
            </div>
            <div className="mt-4 pt-4 border-t border-white/5 flex items-center gap-2">
              <span className="material-symbols-outlined text-[16px] text-slate-500">
                location_on
              </span>
              <span className="text-[11px] font-bold text-slate-400 uppercase tracking-tight">
                Detroit, MI
              </span>
            </div>
          </div>
        </div>

        {/* Action Buttons */}
        <div className="mt-auto space-y-4 pt-4">
          <button className="w-full h-16 bg-primary hover:bg-primary/90 active:scale-[0.98] transition-all text-white rounded-2xl font-bold text-[17px] shadow-xl shadow-primary/20 flex items-center justify-center gap-3">
            <span className="material-symbols-outlined text-[24px]">
              face_retouching_natural
            </span>
            Confirm Match
          </button>
          <div className="grid grid-cols-2 gap-4">
            <button className="h-14 glass-panel hover:bg-white/10 transition-colors text-slate-300 rounded-2xl font-bold text-[14px] flex items-center justify-center gap-2 tracking-wide">
              <span className="material-symbols-outlined text-[20px]">
                person_off
              </span>
              Not a Person
            </button>
            <button className="h-14 glass-panel hover:bg-white/10 transition-colors text-slate-300 rounded-2xl font-bold text-[14px] flex items-center justify-center gap-2 tracking-wide">
              <span className="material-symbols-outlined text-[20px]">
                edit_note
              </span>
              Edit Selection
            </button>
          </div>
        </div>
      </main>
      <div className="h-8 w-full flex justify-center items-end pb-2">
        <div className="w-32 h-1.5 bg-white/20 rounded-full"></div>
      </div>
    </div>
  );
}

export default IdentityMatcherScreen;
