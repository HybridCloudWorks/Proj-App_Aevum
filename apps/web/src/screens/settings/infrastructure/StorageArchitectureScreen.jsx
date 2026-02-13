import { useState } from "react";
import { useNavigate } from "react-router-dom";
import "./StorageArchitectureScreen.css";

function StorageArchitectureScreen() {
  const navigate = useNavigate();
  const [viewMode, setViewMode] = useState("physical");

  return (
    <div className="bg-background-light dark:bg-background-dark min-h-screen text-slate-900 dark:text-slate-100 selection:bg-primary selection:text-white pb-20 overflow-x-hidden">
      <div className="bg-blobs">
        <div className="blob blob-1"></div>
        <div className="blob blob-2"></div>
        <div className="blob blob-3"></div>
      </div>
      <header className="sticky top-0 z-50 glass-panel border-b border-white/5">
        <div className="flex items-center justify-between px-4 py-4">
          <button
            className="flex items-center justify-center text-slate-400 hover:text-white transition-colors size-10 rounded-full hover:bg-white/5"
            onClick={() => navigate(-1)}
          >
            <span className="material-symbols-outlined">arrow_back</span>
          </button>
          <div className="text-center">
            <h1 className="text-base font-bold tracking-tight text-white">
              Storage Architecture
            </h1>
            <p className="text-[10px] text-slate-400 font-medium uppercase tracking-wider">
              Your data, your bucket
            </p>
          </div>
          <button className="flex items-center justify-center text-slate-400 hover:text-white transition-colors size-10 rounded-full hover:bg-white/5">
            <span className="material-symbols-outlined">help</span>
          </button>
        </div>
      </header>
      <main className="px-4 py-6 space-y-6 max-w-md mx-auto relative z-10">
        <div className="relative p-1 rounded-xl bg-black/40 backdrop-blur-md border border-white/5 flex shadow-inner">
          <div
            className={`absolute inset-y-1 w-[calc(50%-4px)] bg-primary/20 border border-primary/40 rounded-lg shadow-[0_0_10px_rgba(17,115,212,0.3)] transition-all duration-300 ${
              viewMode === "physical"
                ? "translate-x-full left-0.5"
                : "left-1 translate-x-0"
            }`}
          ></div>
          <button
            onClick={() => setViewMode("logical")}
            className={`relative flex-1 py-2.5 text-sm font-medium transition-colors z-10 ${
              viewMode === "logical"
                ? "text-white font-bold"
                : "text-slate-400 hover:text-slate-200"
            }`}
          >
            Logical View
          </button>
          <button
            onClick={() => setViewMode("physical")}
            className={`relative flex-1 py-2.5 text-sm transition-colors z-10 flex items-center justify-center gap-2 ${
              viewMode === "physical"
                ? "text-white font-bold"
                : "text-slate-400 hover:text-slate-200"
            }`}
          >
            <span className="material-symbols-outlined text-base">
              terminal
            </span>
            Physical View
          </button>
        </div>

        {viewMode === "physical" ? (
          <div className="grid grid-cols-2 gap-4 animate-fade-in">
            <div className="col-span-2 glass-panel rounded-2xl p-5 relative overflow-hidden group">
              <div className="absolute top-0 right-0 p-3 opacity-20">
                <span className="material-symbols-outlined text-6xl">
                  cloud_sync
                </span>
              </div>
              <div className="relative z-10 flex items-start justify-between">
                <div>
                  <div className="flex items-center gap-2 mb-2">
                    <div className="size-2 rounded-full bg-green-500 animate-pulse shadow-[0_0_8px_rgba(34,197,94,0.6)]"></div>
                    <span className="text-xs font-bold text-green-400 tracking-wide uppercase">
                      Connected
                    </span>
                  </div>
                  <h3 className="text-lg font-bold text-white mb-1">
                    AWS S3 Bucket
                  </h3>
                  <p className="text-xs text-slate-400 font-mono">
                    us-east-1 • aevum-user-8823
                  </p>
                </div>
                <div
                  className="size-12 rounded-xl bg-white/5 flex items-center justify-center border border-white/10"
                  style={{
                    backgroundImage:
                      "url('https://lh3.googleusercontent.com/aida-public/AB6AXuBpXwkOkHDx6B9f3C0VlEeMkfXkw9qCOGBoURhk9_iqwk4zwdOgOBRQ6ZHc91RnZaavEu2-v1Af_IKOXBp64urLiklomn3EUJ5B0YmK8z4E9FobSvbhTj34qIbbUEj8DpZqhSvaBGh4wD1YsX7mrVqiCSP7Ko0eHXDj23d3F8-ClQRBBMcqyrAgwxZa7-gKAWzVyO8qcqyMkoj6cpSaHsyhXu2seJDeXu2TmVFrQOddcRVCuBA0PB8-cMVXyzy1RiHkgjIXHiBvp7s')",
                    backgroundSize: "cover",
                  }}
                ></div>
              </div>
              <div className="mt-6">
                <div className="flex justify-between text-[10px] font-medium text-slate-400 mb-1.5">
                  <span>Storage Used</span>
                  <span>45.2 GB / ∞</span>
                </div>
                <div className="h-1.5 w-full bg-white/10 rounded-full overflow-hidden">
                  <div className="h-full bg-gradient-to-r from-primary to-cyan-400 w-[12%] rounded-full relative">
                    <div className="absolute inset-0 bg-white/20 animate-[shimmer_2s_infinite]"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        ) : (
          <div className="glass-panel p-5 rounded-2xl flex flex-col items-center justify-center text-center gap-3 animate-fade-in min-h-[160px]">
            <div className="p-3 bg-white/5 rounded-full text-slate-400">
              <span className="material-symbols-outlined text-3xl">
                folder_special
              </span>
            </div>
            <div>
              <h3 className="text-white font-bold">
                Smart Organizational View
              </h3>
              <p className="text-slate-400 text-xs mt-1">
                AI-categorized logical folder structure coming soon.
              </p>
            </div>
          </div>
        )}

        {viewMode === "physical" && (
          <div className="col-span-2 space-y-3 animate-fade-in">
            <div className="flex items-center justify-between px-1">
              <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider">
                Directory Hierarchy
              </h4>
              <span className="text-[10px] text-primary bg-primary/10 px-2 py-0.5 rounded-full border border-primary/20">
                Write Access
              </span>
            </div>
            <div className="glass-panel rounded-2xl p-0 overflow-hidden">
              <div className="relative">
                <div className="absolute left-[26px] top-6 bottom-6 w-px bg-gradient-to-b from-white/20 to-transparent dashed border-l border-dashed border-white/20"></div>
                <div className="flex items-center p-3 px-4 hover:bg-white/5 transition-colors border-b border-glass-border">
                  <div className="relative z-10 flex items-center justify-center size-8 rounded-lg bg-blue-500/20 text-blue-400 border border-blue-500/30 mr-3 shrink-0">
                    <span className="material-symbols-outlined text-lg">
                      folder_open
                    </span>
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex justify-between items-baseline">
                      <p className="text-sm font-semibold text-white truncate">
                        2024
                      </p>
                      <span className="text-[10px] text-slate-500 font-mono">
                        drwxr-xr-x
                      </span>
                    </div>
                    <p className="text-[11px] text-slate-400">
                      Root Year Folder
                    </p>
                  </div>
                </div>
                <div className="flex items-center p-3 px-4 hover:bg-white/5 transition-colors border-b border-glass-border">
                  <div className="flex items-center justify-center w-8 mr-3 shrink-0">
                    <div className="relative z-10 flex items-center justify-center size-8 rounded-lg bg-purple-500/20 text-purple-400 border border-purple-500/30 ml-4">
                      <span className="material-symbols-outlined text-lg">
                        folder_shared
                      </span>
                    </div>
                  </div>
                  <div className="flex-1 min-w-0 ml-4">
                    <div className="flex justify-between items-baseline">
                      <p className="text-sm font-semibold text-white truncate">
                        Wedding_Anniversary
                      </p>
                      <span className="text-[10px] text-slate-500 font-mono">
                        drwxr-xr-x
                      </span>
                    </div>
                    <p className="text-[11px] text-slate-400">Event</p>
                  </div>
                </div>
                <div className="flex items-center p-3 px-4 hover:bg-white/5 transition-colors border-b border-glass-border">
                  <div className="flex items-center justify-center w-8 mr-3 shrink-0">
                    <div className="relative z-10 flex items-center justify-center size-8 rounded-lg bg-pink-500/20 text-pink-400 border border-pink-500/30 ml-8">
                      <span className="material-symbols-outlined text-lg">
                        person
                      </span>
                    </div>
                  </div>
                  <div className="flex-1 min-w-0 ml-8">
                    <div className="flex justify-between items-baseline">
                      <p className="text-sm font-semibold text-white truncate">
                        Person_John_Doe
                      </p>
                      <span className="text-[10px] text-slate-500 font-mono">
                        drwxr-xr-x
                      </span>
                    </div>
                    <p className="text-[11px] text-slate-400">
                      Unique Entity ID
                    </p>
                  </div>
                </div>
                <div className="flex items-center p-3 px-4 bg-primary/10 border-l-2 border-l-primary">
                  <div className="flex items-center justify-center w-8 mr-3 shrink-0">
                    <div className="relative z-10 flex items-center justify-center size-8 rounded-lg bg-emerald-500/20 text-emerald-400 border border-emerald-500/30 ml-12">
                      <span className="material-symbols-outlined text-lg">
                        image
                      </span>
                    </div>
                  </div>
                  <div className="flex-1 min-w-0 ml-12">
                    <div className="flex justify-between items-baseline">
                      <p className="text-sm font-bold text-white truncate">
                        IMG_4420.heic
                      </p>
                      <span className="text-[10px] text-slate-400 font-mono">
                        4.2MB
                      </span>
                    </div>
                    <p className="text-[11px] text-primary">Target Object</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        )}

        {viewMode === "physical" && (
          <div className="col-span-2 grid grid-cols-2 gap-4 mt-2 animate-fade-in">
            <div className="glass-panel p-3 rounded-2xl flex flex-col gap-3">
              <div className="flex items-center gap-2 text-slate-400 mb-1">
                <span className="material-symbols-outlined text-sm">
                  visibility
                </span>
                <span className="text-[10px] font-bold uppercase tracking-wider">
                  Object Preview
                </span>
              </div>
              <div
                className="w-full aspect-square rounded-lg bg-cover bg-center border border-white/10 shadow-lg relative group overflow-hidden"
                style={{
                  backgroundImage:
                    "url('https://lh3.googleusercontent.com/aida-public/AB6AXuBo-K8C0XejjWreSQSGhVRJ7plSl7S0oxhM_sWAjoQ2iGRFB5r2fOvLhMfHytlqxGb8hSoYLn4BMNu1CCnGuXCLaTKFhtxk3ptDeQ9O9cu_cIOz7DKYpYKWnPfF0p3RX8V-HQ9JZ0D2CF2YtMBAr0MtXeD1WEpLz73N8gqqaFE6nlrV15vZYJyEhw1WHRManKJBbM21DApZ1uyFC6DF-6LvtDm1IrAD4ttMFAClImEViFUHSkyawKCeE-Fdf76DrZzQveYYs5ka3i4')",
                }}
              >
                <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                  <span className="material-symbols-outlined text-white">
                    open_in_full
                  </span>
                </div>
              </div>
              <div className="flex justify-between items-center text-[10px] font-mono text-slate-400">
                <span>HEIC</span>
                <span>4032 x 3024</span>
              </div>
            </div>
            <div className="glass-panel-active p-3 rounded-2xl flex flex-col gap-3 relative overflow-hidden">
              <div className="absolute -right-4 -top-4 w-16 h-16 bg-primary/20 blur-2xl rounded-full"></div>
              <div className="flex items-center justify-between mb-1 relative z-10">
                <div className="flex items-center gap-2 text-primary">
                  <span className="material-symbols-outlined text-sm">
                    data_object
                  </span>
                  <span className="text-[10px] font-bold uppercase tracking-wider">
                    Sidecar.json
                  </span>
                </div>
                <span className="size-2 rounded-full bg-primary shadow-[0_0_8px_rgba(17,115,212,0.8)]"></span>
              </div>
              <div className="flex-1 bg-black/40 rounded-lg p-2.5 overflow-hidden border border-white/5 font-mono text-[10px] leading-relaxed text-slate-300 relative">
                <div className="absolute left-2 top-2.5 bottom-2 w-4 text-slate-600 text-right pr-1 border-r border-white/10 select-none">
                  1<br />2<br />3<br />4<br />5<br />6
                </div>
                <div className="pl-6 overflow-x-auto">
                  <span className="text-slate-500">{"{"}</span>
                  <br />
                  <span className="text-purple-400">"event"</span>:{" "}
                  <span className="text-green-400">"Wedding"</span>,<br />
                  <span className="text-purple-400">"people"</span>: [<br />
                  <span className="text-green-400">"John"</span>,{" "}
                  <span className="text-green-400">"Sarah"</span>
                  <br />
                  ],
                  <br />
                  <span className="text-purple-400">"date"</span>:{" "}
                  <span className="text-orange-400">"2024-06-15"</span>
                  <br />
                  <span className="text-slate-500">{"}"}</span>
                </div>
              </div>
              <div className="flex justify-between items-center text-[10px] font-mono text-slate-400">
                <span>JSON</span>
                <span>Portable</span>
              </div>
            </div>
          </div>
        )}
        <div className="fixed bottom-6 left-0 right-0 px-4 max-w-md mx-auto z-40">
          <button className="w-full glass-panel bg-gradient-to-r from-primary/80 to-blue-600/80 hover:from-primary hover:to-blue-600 text-white font-semibold py-3.5 rounded-xl shadow-[0_8px_32px_rgba(17,115,212,0.4)] border border-primary/50 flex items-center justify-center gap-2 transition-all active:scale-[0.98]">
            <span className="material-symbols-outlined">verified</span>
            Verify Integrity &amp; Export
          </button>
        </div>
      </main>
    </div>
  );
}

export default StorageArchitectureScreen;
