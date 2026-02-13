import { useState } from "react";
import "./HeritageMapScreen.css";

function HeritageMapScreen() {
  const [activeFilter, setActiveFilter] = useState("Ancestral Roots");

  return (
    <div className="bg-background-dark text-white font-sans h-screen flex flex-col overflow-hidden relative selection:bg-primary/50">
      {/* Header */}
      <header className="h-16 md:h-20 glass-panel flex items-center justify-between px-4 md:px-8 z-50 shrink-0">
        <div className="flex items-center gap-4">
          <div className="w-10 h-10 bg-primary rounded-xl flex items-center justify-center shadow-lg shadow-primary/20">
            <span className="material-symbols-outlined text-white">
              account_tree
            </span>
          </div>
          <div className="hidden md:block">
            <h1 className="text-xl font-bold tracking-tight">Aevum</h1>
            <p className="text-[10px] text-gray-400 uppercase tracking-widest font-semibold">
              Global Heritage
            </p>
          </div>
        </div>

        {/* View Toggle */}
        <div className="bg-black/40 p-1 rounded-full flex gap-1 border border-white/5 mx-2 md:mx-0">
          <button
            onClick={() => setActiveFilter("Ancestral Roots")}
            className={`px-3 md:px-6 py-2 rounded-full text-xs md:text-sm font-medium transition-all ${
              activeFilter === "Ancestral Roots"
                ? "bg-white/10 text-white"
                : "text-gray-400 hover:text-white"
            }`}
          >
            Ancestral Roots
          </button>
          <button
            onClick={() => setActiveFilter("Family Travels")}
            className={`px-3 md:px-6 py-2 rounded-full text-xs md:text-sm font-medium transition-all ${
              activeFilter === "Family Travels"
                ? "bg-white/10 text-white"
                : "text-gray-400 hover:text-white"
            }`}
          >
            Family Travels
          </button>
        </div>

        {/* Right Nav */}
        <div className="flex items-center gap-6">
          <div className="flex -space-x-2 hidden md:flex">
            <img
              alt="User"
              className="w-8 h-8 rounded-full border-2 border-background-dark object-cover"
              src="https://lh3.googleusercontent.com/aida-public/AB6AXuCvrfWGXR_NSzBzI-JasKOidA7kNnec1xEo-F4tEKONh3BnnTTr9SujMk86VlGSW4a0huOIl6C2-R1sS-MsjiTawJGTP61ugi0m18NTYSVhw1RJ9WNIJ5KkZ9reDqFDL3lPIx5tKg3TLO33-8ZkodDYfpah3gEaa5hVhIdnFEgox0Tsbk7Ueci3-w1ulBfXeGCvrzfXdA3U2ehwlnXybAw7RQA8mrOAQPZeMGma_1gywJx1ghseyqQpyiletZuSh3Q4hQ5LA5j3Gjk"
            />
            <div className="w-8 h-8 rounded-full border-2 border-background-dark bg-gray-800 flex items-center justify-center text-[10px] font-bold">
              +4
            </div>
          </div>
          <button className="material-symbols-outlined text-gray-400 hover:text-white transition-colors">
            search
          </button>
          <button className="material-symbols-outlined text-gray-400 hover:text-white transition-colors hidden md:block">
            notifications
          </button>
        </div>
      </header>

      {/* Main Map Container */}
      <main className="flex-1 relative map-container mesh-gradient w-full h-full overflow-hidden">
        <div className="absolute inset-0 world-map-placeholder"></div>
        {/* Grid Overlay */}
        <div
          className="absolute inset-0 opacity-10 pointer-events-none"
          style={{
            backgroundImage:
              "linear-gradient(#ffffff 1px, transparent 1px), linear-gradient(90deg, #ffffff 1px, transparent 1px)",
            backgroundSize: "80px 80px",
          }}
        ></div>

        {/* Glowing Orbs (Map Data Points) - Responsive Logic could vary, currently hardcoded % for demo */}
        {/* Point 1: Ricci Estate */}
        <div className="absolute top-[35%] left-[48%] group cursor-pointer">
          <div className="glowing-orb">
            <img
              alt="Ancestor"
              className="orb-photo"
              src="https://lh3.googleusercontent.com/aida-public/AB6AXuCvrfWGXR_NSzBzI-JasKOidA7kNnec1xEo-F4tEKONh3BnnTTr9SujMk86VlGSW4a0huOIl6C2-R1sS-MsjiTawJGTP61ugi0m18NTYSVhw1RJ9WNIJ5KkZ9reDqFDL3lPIx5tKg3TLO33-8ZkodDYfpah3gEaa5hVhIdnFEgox0Tsbk7Ueci3-w1ulBfXeGCvrzfXdA3U2ehwlnXybAw7RQA8mrOAQPZeMGma_1gywJx1ghseyqQpyiletZuSh3Q4hQ5LA5j3Gjk"
            />
            <div className="absolute -bottom-14 left-1/2 -translate-x-1/2 glass-card px-3 py-2 rounded-lg opacity-0 group-hover:opacity-100 transition-all whitespace-nowrap z-50">
              <p className="text-xs font-bold">Ricci Estate, Italy</p>
              <p className="text-[10px] text-gray-400 font-mono">
                1892 • Scanned Doc
              </p>
            </div>
          </div>
        </div>

        {/* Point 2: New York */}
        <div className="absolute top-[40%] left-[20%] group cursor-pointer">
          <div className="glowing-orb">
            <img
              alt="Ancestor"
              className="orb-photo"
              src="https://lh3.googleusercontent.com/aida-public/AB6AXuCcPMHZe7pihuDC5a1Ab23u52UektHv1tziZdoknIH6xx0WN3z71zNmLVdb1d_tRYkuxnnGDZpOwQp2juuCCakBuRSWjSGuLqPoF7Prb-Hm3AbibIn1J39HzeYV9NOJ8bMG4oShj8sgbjU3m5xCUe_RURkKEkxgqLG7NSqmtBEql701G8VrT9PjHRA8cTOxE4mqWflN0bOs3SsQwt0-hc6AyYTnFsHdUGEjO1HDl6fK613ZVMwJCUAb8sF6jzfwHqFp_cTPg_zr90w"
            />
            <div className="absolute -bottom-14 left-1/2 -translate-x-1/2 glass-card px-3 py-2 rounded-lg opacity-0 group-hover:opacity-100 transition-all whitespace-nowrap z-50">
              <p className="text-xs font-bold">New York, USA</p>
              <p className="text-[10px] text-gray-400 font-mono">
                1910 • Metadata
              </p>
            </div>
          </div>
        </div>

        {/* Point 3: China */}
        <div className="absolute top-[45%] left-[75%] group cursor-pointer">
          <div className="glowing-orb">
            <div className="w-10 h-10 rounded-full bg-gradient-to-br from-amber-500 to-orange-600 flex items-center justify-center text-white font-bold border-2 border-white z-10 shadow-lg">
              C
            </div>
            <div className="absolute -bottom-14 left-1/2 -translate-x-1/2 glass-card px-3 py-2 rounded-lg opacity-0 group-hover:opacity-100 transition-all whitespace-nowrap z-50">
              <p className="text-xs font-bold">Guangdong, China</p>
              <p className="text-[10px] text-gray-400 font-mono">
                1860 • User Profile
              </p>
            </div>
          </div>
        </div>

        {/* Map Controls */}
        <div className="absolute bottom-40  md:bottom-8 left-4 md:left-8 flex flex-col gap-2 z-40">
          <button className="w-10 h-10 glass-card rounded-xl flex items-center justify-center hover:bg-white/10 transition-colors">
            <span className="material-symbols-outlined text-sm">add</span>
          </button>
          <button className="w-10 h-10 glass-card rounded-xl flex items-center justify-center hover:bg-white/10 transition-colors">
            <span className="material-symbols-outlined text-sm">remove</span>
          </button>
          <button className="w-10 h-10 glass-card rounded-xl flex items-center justify-center hover:bg-white/10 mt-2 transition-colors">
            <span className="material-symbols-outlined text-sm">
              my_location
            </span>
          </button>
        </div>

        {/* Ancestral Statistics Card */}
        <div className="hidden md:block absolute top-8 left-8 glass-card p-4 rounded-2xl w-64 z-40">
          <h3 className="text-xs font-bold uppercase tracking-wider text-gray-400 mb-4">
            Ancestral Statistics
          </h3>
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <span className="w-2 h-2 rounded-full bg-primary"></span>
                <span className="text-sm text-gray-300">Europe</span>
              </div>
              <span className="text-sm font-semibold">42%</span>
            </div>
            <div className="w-full bg-white/5 h-1.5 rounded-full overflow-hidden">
              <div className="bg-primary h-full w-[42%]"></div>
            </div>
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <span className="w-2 h-2 rounded-full bg-amber-500"></span>
                <span className="text-sm text-gray-300">Asia</span>
              </div>
              <span className="text-sm font-semibold">28%</span>
            </div>
            <div className="w-full bg-white/5 h-1.5 rounded-full overflow-hidden">
              <div className="bg-amber-500 h-full w-[28%]"></div>
            </div>
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <span className="w-2 h-2 rounded-full bg-emerald-500"></span>
                <span className="text-sm text-gray-300">Americas</span>
              </div>
              <span className="text-sm font-semibold">15%</span>
            </div>
            <div className="w-full bg-white/5 h-1.5 rounded-full overflow-hidden">
              <div className="bg-emerald-500 h-full w-[15%]"></div>
            </div>
          </div>
        </div>
      </main>

      {/* Bottom Sheet - Responsive Grid */}
      <section className="bg-glass-surface backdrop-blur-xl border-t border-glass-border p-4 md:p-6 z-50 shrink-0 max-h-[40vh] md:max-h-[350px] overflow-hidden flex flex-col">
        <div className="max-w-7xl mx-auto w-full h-full flex flex-col md:grid md:grid-cols-12 gap-4">
          {/* Stories Section - 8 cols on desktop, full on mobile */}
          <div className="md:col-span-8 glass-card rounded-3xl p-4 md:p-6 flex flex-col min-h-0">
            <div className="flex items-center justify-between mb-4 md:mb-6 shrink-0">
              <div className="flex items-center gap-2 md:gap-3">
                <span className="material-symbols-outlined text-primary text-base md:text-xl">
                  auto_stories
                </span>
                <h2 className="text-base md:text-lg font-bold">
                  Stories from Tuscany, Italy
                </h2>
              </div>
              <button className="text-xs text-primary font-semibold hover:underline">
                Explore All
              </button>
            </div>

            {/* Horizontal Scroll Area */}
            <div className="flex-1 overflow-x-auto flex gap-4 scrollbar-hide pb-2">
              {/* Card 1 */}
              <div className="min-w-[260px] md:min-w-[300px] h-full bg-white/5 rounded-2xl p-4 border border-white/5 hover:border-white/10 transition-all cursor-pointer group flex flex-col">
                <div className="flex items-center gap-3 mb-3 shrink-0">
                  <img
                    alt="Author"
                    className="w-8 h-8 rounded-full border border-white/10"
                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCvrfWGXR_NSzBzI-JasKOidA7kNnec1xEo-F4tEKONh3BnnTTr9SujMk86VlGSW4a0huOIl6C2-R1sS-MsjiTawJGTP61ugi0m18NTYSVhw1RJ9WNIJ5KkZ9reDqFDL3lPIx5tKg3TLO33-8ZkodDYfpah3gEaa5hVhIdnFEgox0Tsbk7Ueci3-w1ulBfXeGCvrzfXdA3U2ehwlnXybAw7RQA8mrOAQPZeMGma_1gywJx1ghseyqQpyiletZuSh3Q4hQ5LA5j3Gjk"
                  />
                  <div>
                    <p className="text-xs font-bold">Elena Ricci</p>
                    <p className="text-[10px] text-gray-400">
                      Published 2 days ago
                    </p>
                  </div>
                </div>
                <h4 className="font-bold text-sm mb-2 group-hover:text-primary transition-colors">
                  The Vineyard Legacy of 1892
                </h4>
                <p className="text-xs text-gray-400 line-clamp-3 leading-relaxed">
                  Discover how the Ricci family established the first vineyard
                  in the hills of Montepulciano during the late 19th century...
                </p>
                <div className="mt-auto pt-2 flex items-center gap-1 text-[10px] text-gray-500 font-mono">
                  <span className="material-symbols-outlined text-[10px]">
                    event
                  </span>
                  Source: Family Letter (1893)
                </div>
              </div>

              {/* Card 2 */}
              <div className="min-w-[260px] md:min-w-[300px] h-full bg-white/5 rounded-2xl p-4 border border-white/5 hover:border-white/10 transition-all cursor-pointer group flex flex-col">
                <div className="flex items-center gap-3 mb-3 shrink-0">
                  <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center">
                    <span className="material-symbols-outlined text-primary text-sm">
                      history_edu
                    </span>
                  </div>
                  <div>
                    <p className="text-xs font-bold">Archive Bot</p>
                    <p className="text-[10px] text-gray-400">
                      Historical Document
                    </p>
                  </div>
                </div>
                <h4 className="font-bold text-sm mb-2 group-hover:text-primary transition-colors">
                  Census Records: Florence 1910
                </h4>
                <p className="text-xs text-gray-400 line-clamp-3 leading-relaxed">
                  Official residency records showing the movement of the
                  Smith-Ricci branch into the urban center of Florence...
                </p>
                <div className="mt-auto pt-2 flex items-center gap-1 text-[10px] text-gray-500 font-mono">
                  <span className="material-symbols-outlined text-[10px]">
                    calendar_month
                  </span>
                  Extracted: May 12, 1910
                </div>
              </div>
              {/* Card 3 */}
              <div className="min-w-[260px] md:min-w-[300px] h-full bg-white/5 rounded-2xl p-4 border border-white/5 hover:border-white/10 transition-all cursor-pointer group flex flex-col">
                <div className="flex items-center gap-3 mb-3 shrink-0">
                  <img
                    alt="Author"
                    className="w-8 h-8 rounded-full border border-white/10"
                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCcPMHZe7pihuDC5a1Ab23u52UektHv1tziZdoknIH6xx0WN3z71zNmLVdb1d_tRYkuxnnGDZpOwQp2juuCCakBuRSWjSGuLqPoF7Prb-Hm3AbibIn1J39HzeYV9NOJ8bMG4oShj8sgbjU3m5xCUe_RURkKEkxgqLG7NSqmtBEql701G8VrT9PjHRA8cTOxE4mqWflN0bOs3SsQwt0-hc6AyYTnFsHdUGEjO1HDl6fK613ZVMwJCUAb8sF6jzfwHqFp_cTPg_zr90w"
                  />
                  <div>
                    <p className="text-xs font-bold">Sarah Smith</p>
                    <p className="text-[10px] text-gray-400">
                      Published 1 week ago
                    </p>
                  </div>
                </div>
                <h4 className="font-bold text-sm mb-2 group-hover:text-primary transition-colors">
                  Lost Recipes of Nonna Ricci
                </h4>
                <p className="text-xs text-gray-400 line-clamp-3 leading-relaxed">
                  Handwritten culinary secrets passed down through four
                  generations in the heart of the Tuscan countryside...
                </p>
              </div>
            </div>
          </div>

          {/* DNA Velocity - Hidden on mobile or stacked if highly relevant? Keeping it in flow for tablet+ */}
          <div className="hidden md:flex md:col-span-4 glass-card rounded-3xl p-6 relative overflow-hidden group flex-col">
            <div className="absolute -top-4 -right-4 w-32 h-32 bg-primary/10 rounded-full blur-3xl pointer-events-none"></div>
            <h3 className="text-xs font-bold uppercase tracking-wider text-gray-400 mb-6 z-10">
              Migration DNA Velocity
            </h3>
            <div className="space-y-6 relative z-10 flex-1 flex flex-col justify-end">
              <div>
                <div className="flex justify-between items-end mb-2">
                  <span className="text-2xl font-bold">14.2k</span>
                  <span className="text-[10px] text-emerald-500 font-bold">
                    +12% vs last gen
                  </span>
                </div>
                <p className="text-xs text-gray-400">
                  Cumulative Miles Traveled
                </p>
              </div>
              <div className="grid grid-cols-3 gap-2">
                <div className="bg-white/5 p-3 rounded-xl border border-white/5 text-center transition-colors hover:bg-white/10">
                  <p className="text-[10px] text-gray-400 mb-1">Ports</p>
                  <p className="text-sm font-bold">18</p>
                </div>
                <div className="bg-white/5 p-3 rounded-xl border border-white/5 text-center transition-colors hover:bg-white/10">
                  <p className="text-[10px] text-gray-400 mb-1">Eras</p>
                  <p className="text-sm font-bold">4</p>
                </div>
                <div className="bg-white/5 p-3 rounded-xl border border-white/5 text-center transition-colors hover:bg-white/10">
                  <p className="text-[10px] text-gray-400 mb-1">Unions</p>
                  <p className="text-sm font-bold">12</p>
                </div>
              </div>
              <button className="w-full py-3 bg-white/5 hover:bg-white/10 rounded-xl text-xs font-bold transition-all border border-white/10 flex items-center justify-center gap-2">
                <span className="material-symbols-outlined text-sm">
                  insights
                </span>
                Generate Migration Insights
              </button>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}

export default HeritageMapScreen;
