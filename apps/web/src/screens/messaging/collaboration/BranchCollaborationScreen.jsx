import { useNavigate } from "react-router-dom";
import BottomNav from "@/components/BottomNav";
import "./BranchCollaborationScreen.css";

function BranchCollaborationScreen() {
  const navigate = useNavigate();

  return (
    <div className="font-display bg-background-dark text-white overflow-hidden h-screen w-full relative mesh-gradient">
      <header className="pt-12 px-6 pb-4 flex justify-between items-center z-20 relative">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">
            Branch Collaboration
          </h1>
          <p className="text-sm text-gray-400">
            Connecting with{" "}
            <span className="text-white font-medium">Marcus Chen</span>
          </p>
        </div>
        <div className="glass-panel p-2 rounded-full relative">
          <span className="material-symbols-outlined text-gray-300">hub</span>
        </div>
      </header>
      <main className="flex-1 overflow-y-auto px-6 pb-32 scrollbar-hide z-10 relative h-[calc(100vh-160px)]">
        <section className="mb-6 relative">
          <div className="absolute left-1/2 -translate-x-1/2 -top-6 h-10 w-0.5 bg-gradient-to-b from-transparent to-primary/50"></div>
          <div className="glass-panel rounded-2xl p-5 relative overflow-hidden">
            <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-primary to-transparent opacity-50"></div>
            <div className="flex flex-col items-center justify-center text-center relative z-10">
              <div className="text-xs uppercase tracking-widest text-primary font-bold mb-4 bg-primary/10 px-3 py-1 rounded-full border border-primary/20">
                Common Ancestor Found
              </div>
              <div className="flex items-center justify-center gap-6 mb-4 w-full">
                <div className="flex flex-col items-center gap-2">
                  <div className="w-12 h-12 rounded-full bg-gray-700 border-2 border-gray-600 flex items-center justify-center overflow-hidden">
                    <span className="text-xs font-bold text-gray-400">YOU</span>
                  </div>
                  <div className="h-8 w-0.5 bg-gray-600/50"></div>
                </div>
                <div className="relative">
                  <div className="w-20 h-20 rounded-full border-4 border-primary/30 p-1 relative z-10 bg-gray-900">
                    <img
                      alt="Ancestor Portrait"
                      className="w-full h-full rounded-full object-cover grayscale"
                      src="https://lh3.googleusercontent.com/aida-public/AB6AXuAbclN__jVQYshUAg9jY-ANGf807yXDAYHUNaRbRCgjjnQ2cRSpaKAY5WMdOQbhhWMAT3eXs_3SuNyb5acJn6KFwBkYQLnP6H8X6ygXPaKj8-oyx1E9u0smKGvzj8VUA0DzrWbq-NM9GQ6vb5zQrgBY4WfuxW2eMQS-_Qa4QXEfY1qj5NrYWGdFPr_aI00rM1xOmVS-1XdBxIxm4E0uyhIEjNZ8TxGLGYlSYuP6osRBtuqsHeqGY9B3Dnm8f2WqfDew1pWZjeb9EBo"
                    />
                  </div>
                  <div className="absolute inset-0 bg-primary/20 blur-xl rounded-full"></div>
                  <div className="absolute -bottom-2 left-1/2 -translate-x-1/2 bg-primary text-white text-[10px] font-bold px-2 py-0.5 rounded-full whitespace-nowrap z-20 shadow-lg">
                    Match 100%
                  </div>
                </div>
                <div className="flex flex-col items-center gap-2">
                  <div className="w-12 h-12 rounded-full bg-gray-700 border-2 border-gray-600 flex items-center justify-center overflow-hidden relative">
                    <img
                      alt="Collaborator"
                      className="w-full h-full object-cover opacity-80"
                      src="https://lh3.googleusercontent.com/aida-public/AB6AXuAF57b3fakFmL3eSId6hKntS09KSSRN04zqAbv4UIx33UANjeKTZxx5f2QzKdchrlP5foMipmYC7Lp8GBCL6f58T4iFYvYywdpQTo35oTb-K56zCGGf1TqyBCbG-bcZ5mHOPwTClyiuBiYl8qjGPZ67XcnjrqN1Uvcjri97cidCGTwhYlOQT3BYrt_NnW29xuRIIx4lbwKBZh1s1q-m_ecsix4bCy0t21D91pSPGcl5INe70F8ajhXONFdPPJ0tdIZnaLWvjkwYctE"
                    />
                  </div>
                  <div className="h-8 w-0.5 bg-gray-600/50"></div>
                </div>
              </div>
              <h2 className="text-xl font-bold text-white mb-1">
                Eleanor Vance
              </h2>
              <p className="text-sm text-gray-400 mb-3">
                1892 - 1968 • Great-Grandmother
              </p>
              <div className="flex items-center gap-2 text-xs text-gray-500 bg-black/20 p-2 rounded-lg w-full justify-center border border-white/5">
                <span className="material-symbols-outlined text-sm">link</span>
                <span>Connection verified via birth records</span>
              </div>
            </div>
            <div
              className="absolute inset-0 z-0 opacity-10"
              style={{
                backgroundImage:
                  "radial-gradient(#1173d4 1px, transparent 1px)",
                backgroundSize: "20px 20px",
              }}
            ></div>
          </div>
        </section>
        <section className="mb-6 grid grid-cols-2 gap-3">
          <div className="glass-panel rounded-2xl p-4 flex flex-col justify-between h-32 relative overflow-hidden group">
            <div className="absolute right-0 top-0 p-3 opacity-20 group-hover:opacity-40 transition-opacity">
              <span className="material-symbols-outlined text-4xl">
                call_split
              </span>
            </div>
            <h3 className="text-gray-400 text-xs font-medium uppercase">
              Your Branch
            </h3>
            <div>
              <div className="text-2xl font-bold text-white mb-1">124</div>
              <div className="text-[10px] text-gray-500">People linked</div>
            </div>
            <div className="w-full bg-gray-700 h-1 rounded-full mt-2 overflow-hidden">
              <div className="bg-blue-500 h-full w-3/4"></div>
            </div>
          </div>
          <div className="glass-panel rounded-2xl p-4 flex flex-col justify-between h-32 relative overflow-hidden group">
            <div className="absolute right-0 top-0 p-3 opacity-20 group-hover:opacity-40 transition-opacity">
              <span className="material-symbols-outlined text-4xl">
                account_tree
              </span>
            </div>
            <h3 className="text-gray-400 text-xs font-medium uppercase">
              Marcus's Branch
            </h3>
            <div>
              <div className="text-2xl font-bold text-white mb-1">86</div>
              <div className="text-[10px] text-gray-500">People linked</div>
            </div>
            <div className="w-full bg-gray-700 h-1 rounded-full mt-2 overflow-hidden">
              <div className="bg-purple-500 h-full w-1/2"></div>
            </div>
          </div>
        </section>
        <section className="mb-24">
          <div className="flex justify-between items-center mb-3">
            <h3 className="text-sm font-bold text-gray-300 uppercase tracking-wider">
              Shared Memories
            </h3>
            <span className="text-xs text-primary font-medium cursor-pointer hover:text-blue-300 transition-colors">
              View Gallery
            </span>
          </div>
          <div className="grid grid-cols-3 grid-rows-2 gap-3 h-48">
            <div className="col-span-2 row-span-2 glass-panel rounded-2xl p-0 overflow-hidden relative group cursor-pointer">
              <img
                alt="Family Gathering 1945"
                className="w-full h-full object-cover opacity-80 group-hover:scale-105 transition-transform duration-500 grayscale group-hover:grayscale-0"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuClFPrfWupmTzNvklcoXZ4wkZ-xb9V2FPAJCGla7lijfUUqZD1w9PAaQV4SmOdlMJQcSQG6MrezbnaucBeZ1b7SOMThYg9nwnaaYwNdWSBIwFKKCm2f-U3c_uyZvMUjJcirB-pn6u5OBXIMhA587MzOCRVrfk_zlJpdwm9Vt5bsQW4JpmJg6klhxNhOxQ6ShcUWiwBWSkg-NMsVjDmnA1M0Oi5ZU3OGoS02yK2SBbMYblmqzXAtHOF_Ux2W6rIglkt-Zp1V459sg4c"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent"></div>
              <div className="absolute bottom-3 left-3">
                <div className="flex -space-x-2 mb-1">
                  <div className="w-6 h-6 rounded-full border-2 border-black bg-gray-500 overflow-hidden">
                    <img
                      className="w-full h-full object-cover"
                      src="https://lh3.googleusercontent.com/aida-public/AB6AXuAuEfa-7AYydHr6eYoG7AaUD8gOjMkO9lVmTTqbnYhPk02zGeSRkuLGOl32N_NsASG9WKgWRh8KL86v-nMcGO274EQ4VMVGamLh2w6ErFYz_c1Oq8r4o1aKBjSMSAYalLGRuHYQZSduZkntG5cK1IDuBOsjajYwtwu8XEuk84d9r1KC2f3_AjAJ0XEHmYDiDPuspvDAQndviWnsZlNGmD2_0PpYMsolbmZpH9PWWQOziLK-PeYrLYGf30vPe8C5VzGuEJUCJAed2E0"
                    />
                  </div>
                  <div className="w-6 h-6 rounded-full border-2 border-black bg-gray-500 overflow-hidden">
                    <img
                      className="w-full h-full object-cover"
                      src="https://lh3.googleusercontent.com/aida-public/AB6AXuDpSDbz0t4qn77b_6w-m2pNoiNgqN1PYKNy3GdEBCrVpHF955JD1KD2q7hU4AgtfkWNsRyJy0AwuyXpMo75yxGWZqv9f-HvsyDIAXj7WUi69vgbvd5gXOJME6hK_a6ePndRMmZP5xgQ_xVGB0ByMvF2cnn7QvBBzbP34cDszMQ4on5iTVDG11lGtm1EFCDqQrUTLvEVG4_cjRFmPbqkrb1X8vb97-VCqJ6uph0Cdcby-ZUdXWwbZqP3JQBiASN0khlAUBv5aA9Cb3c"
                    />
                  </div>
                </div>
                <p className="text-xs text-white font-medium">1945 Reunion</p>
              </div>
              <div className="absolute top-2 right-2 bg-black/40 backdrop-blur-md rounded-full p-1.5">
                <span className="material-symbols-outlined text-white text-xs">
                  auto_awesome
                </span>
              </div>
            </div>
            <div className="col-span-1 row-span-1 glass-panel rounded-2xl p-0 overflow-hidden relative group cursor-pointer">
              <img
                alt="Letter"
                className="w-full h-full object-cover opacity-70 group-hover:scale-105 transition-transform duration-500"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuCrqFqpoA3_h9vJNsPNGBfbOwZSTx8o8PQ1bfxuSAensbythwxV-QE3cMaZrrP2SV2nrGYPDRywcoQwfMqh3jRNZ9BcVByZMEyzhGbi8xVpwd_jKwYRgd59dlF5jD9A9Ff7gctJOzRkbfxO8VHoCfMUc5y9ZQnpEwRGlE6I0jdAZCQ_fDbkF5WDdlvw1hILMutwSgI1lChSqC3nMIHmK5FGqAKYpZzOhc98o-CLdp4Y2HZ3M7YAoCmDG-dB1wy-7l0PXWQc1QSfL_E"
              />
              <div className="absolute inset-0 bg-black/20 group-hover:bg-transparent transition-colors"></div>
            </div>
            <div className="col-span-1 row-span-1 glass-panel rounded-2xl p-0 overflow-hidden relative group cursor-pointer flex items-center justify-center">
              <div className="absolute inset-0 bg-white/5 group-hover:bg-white/10 transition-colors"></div>
              <span className="text-xl font-bold text-gray-400 group-hover:text-white transition-colors">
                +12
              </span>
            </div>
          </div>
        </section>
      </main>
      <div className="fixed bottom-24 w-full px-6 z-40 pointer-events-none">
        <div className="flex gap-3 pointer-events-auto">
          <button
            className="flex-1 glass-panel hover:bg-white/5 text-gray-300 font-medium py-4 px-6 rounded-xl transition-colors flex items-center justify-center gap-2"
            onClick={() => navigate("/messages/chat/marcus-chen")}
          >
            <span className="material-symbols-outlined text-[20px]">
              chat_bubble
            </span>
            <span>Message</span>
          </button>
          <button className="flex-[2] bg-primary hover:bg-blue-600 text-white font-bold py-4 px-6 rounded-xl glow-button transition-all transform hover:scale-[1.02] active:scale-[0.98] flex items-center justify-center gap-2">
            <span className="material-symbols-outlined">merge_type</span>
            <span>Request Merge</span>
          </button>
        </div>
      </div>
      <BottomNav />
    </div>
  );
}

export default BranchCollaborationScreen;
