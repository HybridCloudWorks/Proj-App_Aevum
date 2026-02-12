/**
 * Aevum Messenger Hub Screen
 *
 * Migrated from Stitch screen: 732382af817245b4a058aeb99c40d215
 * Central messaging hub for family branches and private chats.
 */

import { useNavigate } from "react-router-dom";
import BottomNav from "@/components/BottomNav";
import "./MessengerHubScreen.css";

function MessengerHubScreen() {
  const navigate = useNavigate();

  return (
    <div className="messenger-hub-container pb-32">
      <div className="mesh-background"></div>

      {/* Header Section */}
      <header className="px-6 pt-12 pb-6">
        <h1 className="text-3xl font-extrabold tracking-tight mb-1 text-white">
          Messages
        </h1>
        <p className="text-white/40 text-sm font-medium">
          Coordinate your family legacy.
        </p>
      </header>

      {/* Family Branches Carousel */}
      <section className="mb-8">
        <div className="px-6 mb-4 flex items-center justify-between">
          <h2 className="text-xs font-bold uppercase tracking-widest text-white/30">
            Your Branches
          </h2>
          <button className="text-xs font-bold text-indigo-400">Manage</button>
        </div>
        <div className="flex gap-4 overflow-x-auto px-6 scrollbar-hide pb-2">
          {/* Branch 1: Active */}
          <div className="glass-pane branch-card p-5 flex flex-col justify-between active-glow">
            <div className="w-10 h-10 rounded-full bg-indigo-500/20 flex items-center justify-center border border-indigo-500/30">
              <svg
                className="w-5 h-5 text-indigo-400"
                fill="currentColor"
                viewBox="0 0 20 20"
              >
                <path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a.997.997 0 00-.12-.47c1.183-.694 2.156-1.026 3.12-1.026h.001c.552 0 .999.448.999 1V18h-4z" />
              </svg>
            </div>
            <div>
              <p className="font-bold text-sm text-white">Ricci Branch</p>
              <p className="text-[10px] text-white/40">12 Members</p>
            </div>
          </div>
          {/* Branch 2 */}
          <div className="glass-pane branch-card p-5 flex flex-col justify-between">
            <div className="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center border border-white/10">
              <svg
                className="w-5 h-5 text-white/60"
                fill="currentColor"
                viewBox="0 0 20 20"
              >
                <path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a.997.997 0 00-.12-.47c1.183-.694 2.156-1.026 3.12-1.026h.001c.552 0 .999.448.999 1V18h-4z" />
              </svg>
            </div>
            <div>
              <p className="font-bold text-sm text-white">Miller Branch</p>
              <p className="text-[10px] text-white/40">8 Members</p>
            </div>
          </div>
          {/* Add New */}
          <div className="glass-pane branch-card p-5 flex flex-col items-center justify-center border-dashed border-white/20 bg-transparent">
            <div className="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center border border-white/10 mb-2">
              <svg
                className="w-5 h-5 text-white/40"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path strokeWidth="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
              </svg>
            </div>
            <p className="text-[10px] font-bold uppercase tracking-tighter text-white/40">
              New Branch
            </p>
          </div>
        </div>
      </section>

      {/* Recent Chats */}
      <main className="px-6 space-y-4">
        <h2 className="text-xs font-bold uppercase tracking-widest text-white/30 mb-4">
          Recent Conversations
        </h2>

        {/* Chat Item 1 */}
        <div className="glass-pane p-4 flex items-center gap-4">
          <div className="relative">
            <img
              src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&h=100&fit=crop"
              className="w-14 h-14 rounded-2xl border border-white/10"
              alt="Father"
            />
            <div className="absolute -bottom-1 -right-1 status-orb border-2 border-[#09090b]"></div>
          </div>
          <div className="flex-grow text-left">
            <div className="flex justify-between items-center mb-1">
              <h3 className="font-bold text-sm text-white">
                Arthur James Sterling
              </h3>
              <span className="text-[10px] text-white/30 font-bold">
                2m ago
              </span>
            </div>
            <p className="text-xs text-white/60 line-clamp-1 italic">
              "The photo restoration looks incredible..."
            </p>
          </div>
        </div>

        {/* Chat Item 2 (Group) */}
        <div className="glass-pane p-4 flex items-center gap-4">
          <div className="w-14 h-14 rounded-2xl bg-indigo-500/10 border border-indigo-500/20 flex items-center justify-center">
            <span className="text-indigo-400 font-bold">MB</span>
          </div>
          <div className="flex-grow text-left">
            <div className="flex justify-between items-center mb-1">
              <h3 className="font-bold text-sm text-white">
                Miller Family Chat
              </h3>
              <span className="text-[10px] text-white/30 font-bold">
                1h ago
              </span>
            </div>
            <p className="text-xs text-white/60 line-clamp-1">
              <span className="text-indigo-400 font-bold">Sarah:</span> "Just
              added 5 new immigration records."
            </p>
          </div>
        </div>
      </main>

      {/* Request Access FAB */}
      <button className="fixed bottom-28 right-6 fab-glow h-14 px-6 rounded-full flex items-center gap-3 active:scale-95 transition-all z-50 text-white font-bold uppercase tracking-tight">
        <svg
          className="w-5 h-5 text-white"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path strokeWidth="2.5" d="M12 4v16m8-8H4" />
        </svg>
        <span className="text-sm">Request Access</span>
      </button>

      <BottomNav />
    </div>
  );
}

export default MessengerHubScreen;
