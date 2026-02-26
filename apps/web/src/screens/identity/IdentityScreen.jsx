import { useNavigate } from "react-router-dom";
import "./IdentityScreen.css";

/**
 * Identity Screen
 *
 * High-fidelity implementation based on Stitch design:
 * daddb58a32cf445ba688d4ea17f63f9f (Aevum Identity Profile)
 */
function IdentityScreen() {
  const navigate = useNavigate();

  return (
    <div className="identity-screen-wrapper bg-background-light dark:bg-background-dark font-display antialiased min-h-screen flex flex-col overflow-hidden text-white selection:bg-primary selection:text-white">
      {/* Top Navigation Area */}
      <header className="fixed top-0 w-full z-50 pt-12 pb-4 px-6 flex justify-between items-center bg-gradient-to-b from-[#0f0f12] to-transparent">
        <button
          onClick={() => navigate(-1)}
          className="w-10 h-10 flex items-center justify-center rounded-full glass-pill text-white hover:bg-white/20 transition-colors"
        >
          <span className="material-symbols-outlined">arrow_back</span>
        </button>
        <div className="text-sm font-medium tracking-wide uppercase text-white/60">
          Family Tree
        </div>
        <button className="w-10 h-10 flex items-center justify-center rounded-full glass-pill text-white hover:bg-white/20 transition-colors">
          <span className="material-symbols-outlined">more_horiz</span>
        </button>
      </header>

      {/* Main Scrollable Content */}
      <main className="flex-1 overflow-y-auto no-scrollbar pt-24 pb-28 px-4">
        {/* Hero Section */}
        <div className="relative w-full rounded-3xl overflow-hidden mb-4 shadow-2xl">
          {/* Background Blended Flags Abstract */}
          <div className="absolute inset-0 z-0">
            <div className="absolute inset-0 bg-[#0f0f12]/40 z-10"></div>{" "}
            {/* Overlay for contrast */}
            <div
              className="w-full h-full bg-cover bg-center"
              style={{
                backgroundImage:
                  "url('https://lh3.googleusercontent.com/aida-public/AB6AXuD-oyhRVhSG2iIq_vrIA4_h8UAzmKunZ_CN647bOSTeCAJysuwNaoZzrdXx6p4kZKvRS4riWOYIQzNYjgtpVc2NWIF-A_L-cnphJoXiApokraUhkMqHAb5uUN8Hl3a-dReB_iBGLiikNvLepb-iJ1XzWq3QcsEXev7WeJiu4KfYr5kAX5f_yR-xvyw7N11UtvozoUw1kmMUzlwOYI5LkGlgIG53q3_1fACbjcF4MTtnH2ZAlh4bKeYqwvmKgaZ_MbCcZtCeOzpiCyY')",
                filter: "hue-rotate(200deg) saturate(1.5)",
              }}
            ></div>
          </div>
          <div className="relative z-20 flex flex-col items-center pt-8 pb-8 px-6 glass-card border-none bg-gradient-to-b from-transparent to-[#0f0f12]/90">
            {/* Parent Origin Indicators (Top Left) */}
            <div className="absolute top-4 left-4 flex gap-2">
              <div
                className="glass-pill px-2 py-1 rounded-full flex items-center gap-1.5"
                title="Mother's Lineage"
              >
                <span className="material-symbols-outlined text-[14px] text-pink-300">
                  female
                </span>
                <img
                  alt="UK Flag"
                  className="w-4 h-3 rounded-[2px] opacity-80"
                  src="https://lh3.googleusercontent.com/aida-public/AB6AXuDzzjrxVlqF1xub-PtALcCXbgaJZU4vNgfsIA5JLrlOxpXT3RBbeKc5WQoRObzwsTmMeg_wGg9WYluJmJUGKeK9RxgAiXM1xsURVQUUcxEBjK-goU7WgvTlZf6qw-m8WoOU6GUv4_bGU4S0uF6tKNYOn_s7q6Uy3LHqkaMHS3yfICWJzm7PDOzhUaG6ZgcL2IZQAx4WcUE_FcmDrrRpMj_PefiYgoE_VDxwxnncBaRyBHlHc9imPXtC1Raa_qEpkpXi47AP8pSMzDA"
                />
              </div>
              <div
                className="glass-pill px-2 py-1 rounded-full flex items-center gap-1.5"
                title="Father's Lineage"
              >
                <span className="material-symbols-outlined text-[14px] text-blue-300">
                  male
                </span>
                <img
                  alt="USA Flag"
                  className="w-4 h-3 rounded-[2px] opacity-80"
                  src="https://lh3.googleusercontent.com/aida-public/AB6AXuAeQSfjEriYOvmYAgYJWykUtj_D6FkYi1q6XRQlpRQiQv1VuOQWbzC7VipIyEAaJ7FCY6LrMjTuXVRRzOBSr9Fcnczysp-n16vxzIieHhWVT1x6p-4bsSNIZKPO0_mnDMaJ9f-czMbThB1zir_lPqjdTlOSMNpyPjrQk_vRExNDX-tFCJze_8w6GwvPVW379L9Gu9fQrdWk10CpDnv4qnuSw4n--PAxYQdo-LFn7UcCfGP2qgFS_q4TgVAI9jZRpXycKG6p7wE22q4"
                />
              </div>
            </div>
            {/* Profile Avatar Complex */}
            <div className="relative mb-6 mt-6">
              {/* Main Avatar Ring */}
              <div className="w-32 h-32 rounded-full p-1 bg-gradient-to-br from-white/20 to-white/5 shadow-2xl backdrop-blur-sm">
                <div className="w-full h-full rounded-full overflow-hidden border-2 border-[#0f0f12]">
                  <img
                    alt="Vintage 1920s style portrait of Arthur Sterling"
                    className="w-full h-full object-cover grayscale sepia-[.30] contrast-125 brightness-90"
                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCiBhyW7LOXta9AdX-TD8CixwU9Se6lU4DZRI0y5L9hoKLdTJsv8OpUOxX2LDUInp2ygYOiZb9LActFcsnZW_6iYlEz9Jna4cLRiYAEfX1wbybd7ZnC3fbrpobpdU3z-mxgi_lF0hca3R4CWPwXIwF8kz6BYrrAbiLU8m2Th61nIrSdhASVvhRcpfN-9vW_Orpd7PYoSV_z2Ai8i2OGcvOlVWERtAMxWEZ74N7i_rwoDIo0LSNVYjhGv3bN7_wL54L28DYxaArmVvE"
                  />
                </div>
              </div>
              {/* Verified Badge (Right) */}
              <div className="absolute bottom-1 right-0 translate-x-1/4 -translate-y-1/4">
                <div className="bg-primary text-white p-1.5 rounded-full shadow-[0_2px_8px_rgba(0,0,0,0.5)] border-2 border-[#0f0f12] flex items-center justify-center">
                  <span className="material-symbols-outlined text-[16px] font-bold">
                    check
                  </span>
                </div>
              </div>
              {/* Citizenship Badge (Left - Stacked) */}
              <div className="absolute bottom-1 left-0 -translate-x-1/4 -translate-y-1/4 flex items-center justify-center w-8 h-8">
                {/* Behind Flag (Birthright - Greyscale) */}
                <div className="absolute right-[-4px] top-[-4px] w-6 h-6 rounded-full overflow-hidden border border-white/20 shadow-lg z-0 grayscale opacity-60">
                  <img
                    alt="Small circular UK flag"
                    className="w-full h-full object-cover"
                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuDsjnLKTYfTRXi1jXH7VasYv9KqZgB649chvG4lWatc7BDxcjGgeSteTDL2XjMXM5dMOrWIEjdeLTFmxF5obSIeicOgv78WouyysGf1GbCXQbUXE03OSFtriHQLwyF6osuEh214fR1xIQ9ucn-mSdix5FKfSjsRjG8Au1B_5pwAi0OoGmTPnROUPbHwc06rFt0H-BC1cIJzmN8QTdAKqDKku7MKyr3OOkkj9EhtUHIFyyz9GC2s79V2-l3Mk2MKIU341TswO6hFsCw"
                  />
                </div>
                {/* Front Flag (Chosen - Full Color) */}
                <div className="relative w-8 h-8 rounded-full overflow-hidden border-2 border-[#0f0f12] shadow-xl z-10">
                  <img
                    alt="Small circular USA flag"
                    className="w-full h-full object-cover"
                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCGvDvYnLo0lMbyKBSHHzM8f7E2LCLNyoKTbl0Ht8wwPD5opg0JtnmzYxMvfZAncknMpMPeC6mDS6bjiKUW4tsaaIjkfmgr8NzQB8p5YVyuUEWpdEuXdOGWqFXsMhcmBrS1H3aFxUErDu5GYE3EEWFyE_Sg4Ht1qgsAIibJhO0RvPWIiFJKhLlUczqNGrbQPp8v-Ya6NdURMjnoVNmD81x7X5vzhWE9SM4m0zohMNF22rb2l4eAPZEF5v0TJgznMnd8zvFCsYwgZjs"
                  />
                </div>
              </div>
            </div>
            {/* Name & Vital Stats */}
            <div className="text-center space-y-1">
              <h1 className="text-2xl font-bold text-white tracking-tight drop-shadow-md">
                Arthur James Sterling
              </h1>
              <div className="flex items-center justify-center gap-2 text-white/70 text-sm font-medium">
                <span>1892</span>
                <span className="w-1 h-1 bg-white/40 rounded-full"></span>
                <span>1954</span>
                <span className="w-1 h-1 bg-white/40 rounded-full"></span>
                <span>62 Years</span>
              </div>
            </div>
            {/* Quick Actions */}
            <div className="flex gap-3 mt-6 w-full">
              <button className="flex-1 bg-white/10 hover:bg-white/20 active:bg-white/5 backdrop-blur-md border border-white/10 text-white py-2.5 px-4 rounded-xl text-sm font-semibold transition-all flex items-center justify-center gap-2 group">
                <span className="material-symbols-outlined text-[18px] group-hover:scale-110 transition-transform">
                  share
                </span>
                Share
              </button>
              <button className="flex-1 bg-primary hover:bg-primary/90 active:bg-primary/80 text-white py-2.5 px-4 rounded-xl text-sm font-semibold transition-all shadow-lg shadow-primary/20 flex items-center justify-center gap-2 group">
                <span className="material-symbols-outlined text-[18px] group-hover:scale-110 transition-transform">
                  edit
                </span>
                Edit Profile
              </button>
            </div>
          </div>
        </div>

        {/* Bento Grid Layout */}
        <div className="grid grid-cols-2 gap-4">
          {/* Vital Records Card */}
          <div className="col-span-2 glass-card rounded-2xl p-5 flex flex-col gap-4">
            <div className="flex justify-between items-center">
              <div className="flex items-center gap-2">
                <div className="p-1.5 rounded-lg bg-orange-500/20 text-orange-400">
                  <span className="material-symbols-outlined text-[20px]">
                    folder_open
                  </span>
                </div>
                <h3 className="font-semibold text-white/90 text-sm tracking-wide uppercase">
                  Vital Records
                </h3>
              </div>
              <span className="text-xs font-medium text-white/40 bg-white/5 px-2 py-1 rounded-md">
                3 Found
              </span>
            </div>
            <div className="space-y-3">
              <div className="flex items-center justify-between p-3 rounded-xl bg-white/5 border border-white/5 hover:bg-white/10 transition-colors cursor-pointer group">
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded bg-white/10 flex items-center justify-center text-white/70">
                    <span className="material-symbols-outlined text-[18px]">
                      description
                    </span>
                  </div>
                  <div className="flex flex-col">
                    <span className="text-sm font-medium text-white group-hover:text-primary transition-colors">
                      1900 US Census
                    </span>
                    <span className="text-[10px] text-white/50">
                      Cook County, IL
                    </span>
                  </div>
                </div>
                <span className="material-symbols-outlined text-primary text-[18px]">
                  verified
                </span>
              </div>
              <div className="flex items-center justify-between p-3 rounded-xl bg-white/5 border border-white/5 hover:bg-white/10 transition-colors cursor-pointer group">
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded bg-white/10 flex items-center justify-center text-white/70">
                    <span className="material-symbols-outlined text-[18px]">
                      badge
                    </span>
                  </div>
                  <div className="flex flex-col">
                    <span className="text-sm font-medium text-white group-hover:text-primary transition-colors">
                      WWI Draft Card
                    </span>
                    <span className="text-[10px] text-white/50">
                      Registration 1917
                    </span>
                  </div>
                </div>
                <span className="material-symbols-outlined text-primary text-[18px]">
                  verified
                </span>
              </div>
            </div>
          </div>

          {/* Life Timeline Card */}
          <div className="col-span-2 glass-card rounded-2xl p-5 relative overflow-hidden">
            <div className="absolute top-0 right-0 p-5 opacity-20 pointer-events-none">
              <span className="material-symbols-outlined text-[80px] text-white">
                history_edu
              </span>
            </div>
            <div className="flex justify-between items-center mb-6 relative z-10">
              <div className="flex items-center gap-2">
                <div className="p-1.5 rounded-lg bg-emerald-500/20 text-emerald-400">
                  <span className="material-symbols-outlined text-[20px]">
                    timeline
                  </span>
                </div>
                <h3 className="font-semibold text-white/90 text-sm tracking-wide uppercase">
                  Life Timeline
                </h3>
              </div>
            </div>
            <div className="relative pl-2 z-10 space-y-6 timeline-container">
              {/* Event 1 */}
              <div className="relative flex gap-4 items-start group">
                <div className="absolute left-[3px] mt-1.5 w-3 h-3 rounded-full border-2 border-[#1e1e23] bg-emerald-400 shadow-[0_0_10px_rgba(52,211,153,0.5)] z-10"></div>
                <div className="flex flex-col">
                  <span className="text-xs font-bold text-emerald-400 tracking-wider mb-0.5">
                    1892
                  </span>
                  <span className="text-sm font-medium text-white group-hover:text-white/80 transition-colors">
                    Born in Birmingham
                  </span>
                  <span className="text-xs text-white/50">United Kingdom</span>
                </div>
              </div>
              {/* Event 2 */}
              <div className="relative flex gap-4 items-start group">
                <div className="absolute left-[3px] mt-1.5 w-3 h-3 rounded-full border-2 border-[#1e1e23] bg-primary shadow-[0_0_10px_rgba(17,115,212,0.5)] z-10"></div>
                <div className="flex flex-col">
                  <span className="text-xs font-bold text-primary tracking-wider mb-0.5">
                    1910
                  </span>
                  <span className="text-sm font-medium text-white group-hover:text-white/80 transition-colors">
                    Immigrated to New York
                  </span>
                  <span className="text-xs text-white/50">
                    Ellis Island Records
                  </span>
                </div>
              </div>
              {/* Event 3 */}
              <div className="relative flex gap-4 items-start group">
                <div className="absolute left-[3px] mt-1.5 w-3 h-3 rounded-full border-2 border-[#1e1e23] bg-white/40 z-10"></div>
                <div className="flex flex-col">
                  <span className="text-xs font-bold text-white/60 tracking-wider mb-0.5">
                    1954
                  </span>
                  <span className="text-sm font-medium text-white group-hover:text-white/80 transition-colors">
                    Died in Chicago
                  </span>
                  <span className="text-xs text-white/50">Illinois</span>
                </div>
              </div>
            </div>
          </div>

          {/* Family Connections Card */}
          <div className="col-span-1 glass-card rounded-2xl p-4 flex flex-col justify-between aspect-square group cursor-pointer hover:bg-white/5 transition-colors">
            <div className="flex items-center gap-2 mb-2">
              <div className="p-1.5 rounded-lg bg-purple-500/20 text-purple-400">
                <span className="material-symbols-outlined text-[20px]">
                  diversity_2
                </span>
              </div>
            </div>
            <div>
              <div className="text-2xl font-bold text-white mb-1">14</div>
              <div className="text-xs text-white/60 font-medium">
                Immediate Kin
              </div>
            </div>
            <div className="flex -space-x-2 mt-2">
              <img
                alt="Portrait of a female family member"
                className="w-7 h-7 rounded-full border-2 border-[#1e1e23]"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuARn8Q5InnpKY3xRIb4_TwUw0p13UZoKJUnxvQRy9i7xBV7elGpzQtCmkptFpxtWre2AmLdifEzHVI1Td2GZormaSKRteESDU0S8AmIQOAgVHhNlaWobe-fNdk_SMQc87_zbrzpacjwghg3md9UKd9WjrUgZmh-QsRd54eWTO1AAbEjYZE52xUhdc6GPQMB6G1lWmVb5cF_HiEIuLZMsFB1aJgJI85iW8ft3yDx2m9F0cPE5DZWqE90uycpBj7nHJuGUJvPgVNCVmY"
              />
              <img
                alt="Portrait of a male family member"
                className="w-7 h-7 rounded-full border-2 border-[#1e1e23]"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuBAVEN29vQV0bD8a1EDUWXTLAk5btpsOoi7iBYlUPMtMfQtVhrGelyL_qLWDiayXB5Xx7fm1a9xT9teb0vbLOlzMyKbygMy_Qgkp93wpR2VhG4m0fKP9Oxc01gyhsnIJCgM-IBiHLbsr27NpHtBZyfxqstG6pNxhTBg9Q10LCLuE6rY5dHSkXhwEIVDm98hKGdUKIrMuRuHYCDOfPoV9MaNAZNkXnLMw4EL42QEgOhBbVS5CXoT4qOJ_MUksoJpQVsjrjcUTM3Jjpo"
              />
              <div className="w-7 h-7 rounded-full border-2 border-[#1e1e23] bg-white/10 flex items-center justify-center text-[8px] font-bold">
                +12
              </div>
            </div>
          </div>

          {/* Locations Map Card */}
          <div className="col-span-1 glass-card rounded-2xl p-0 overflow-hidden relative aspect-square group cursor-pointer">
            <div
              className="absolute inset-0 bg-cover bg-center opacity-60 group-hover:scale-105 transition-transform duration-500"
              style={{
                backgroundImage: "url('https://placeholder.pics/svg/300')",
              }}
            ></div>
            <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent"></div>
            <div className="absolute bottom-4 left-4">
              <div className="p-1.5 rounded-lg bg-blue-500/20 text-blue-400 inline-flex mb-2 backdrop-blur-md">
                <span className="material-symbols-outlined text-[20px]">
                  public
                </span>
              </div>
              <div className="text-sm font-medium text-white">
                Migration Map
              </div>
            </div>
          </div>
        </div>

        {/* Bottom Spacer for Tab Bar */}
        <div className="h-24"></div>
      </main>
    </div>
  );
}

export default IdentityScreen;
