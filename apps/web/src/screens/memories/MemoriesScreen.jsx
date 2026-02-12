/**
 * Aevum Member Memories Screen (Feed)
 *
 * Migrated from Stitch screen: 72a1ca49f3894dc7bf419d937d2c4d96
 * Displays personal memories, bento-style featured moments, and quick actions.
 */

import { useState, useEffect } from "react";
import { useNavigate, Link } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import { subscribeToFamilies, subscribeToMemories } from "@lib/firestore";
import "./MemoriesScreen.css";

function MemoriesScreen() {
  const navigate = useNavigate();
  const { user } = useAuth();
  const [families, setFamilies] = useState([]);
  const [memories, setMemories] = useState([]);
  const [loading, setLoading] = useState(true);

  // 1. Get user's families
  useEffect(() => {
    if (!user) return;
    const unsub = subscribeToFamilies(user.uid, setFamilies);
    return () => unsub();
  }, [user]);

  // 2. Subscribe to memories for the first family
  useEffect(() => {
    if (families.length === 0) return;
    const activeFamilyId = families[0].id;
    const unsub = subscribeToMemories(activeFamilyId, (data) => {
      setMemories(data);
      setLoading(false);
    });
    return () => unsub();
  }, [families]);

  // Use sample if empty for demo purposes, otherwise show real ones
  const featuredMemories =
    memories.length > 0
      ? memories
      : [
          {
            id: "sample-1",
            title: "The Wedding Portrait",
            location: "London",
            year: "1924",
            imageUrl:
              "https://images.unsplash.com/photo-1542037104857-ffbb0b9155fb?w=800&q=80",
          },
          {
            id: "sample-2",
            imageUrl:
              "https://images.unsplash.com/photo-1511895426328-dc8714191300?w=400&q=80",
          },
          {
            id: "sample-3",
            imageUrl:
              "https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=400&q=80",
          },
        ];

  return (
    <div className="memories-feed-container pb-24">
      <div className="mesh-bg"></div>

      {/* Sticky Glass Header */}
      <header className="glass-header sticky top-12 z-50 px-6 py-4 flex items-center gap-4 mx-4 rounded-3xl border border-white/10">
        <button
          onClick={() => navigate(-1)}
          className="w-10 h-10 rounded-full flex items-center justify-center bg-white/5 border border-white/10 text-white"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            className="w-6 h-6"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth="2"
              d="M15 19l-7-7 7-7"
            />
          </svg>
        </button>
        <div className="flex items-center gap-3">
          <img
            src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=80&h=80&fit=crop"
            className="w-10 h-10 rounded-full border border-indigo-500/50"
            alt="Arthur James Sterling"
          />
          <div className="text-left">
            <h1 className="font-semibold text-sm text-white">
              Arthur James Sterling
            </h1>
            <p className="text-[10px] text-white/50 uppercase tracking-widest font-bold">
              1892 — 1964
            </p>
          </div>
        </div>
      </header>

      <main className="px-6 mt-6 space-y-6">
        {/* Quick Action Bento Grid */}
        <div className="grid grid-cols-2 gap-4">
          <div className="bento-card p-5 flex flex-col justify-between aspect-square">
            <div className="w-10 h-10 rounded-xl bg-indigo-500/20 flex items-center justify-center text-indigo-400">
              <span className="material-symbols-outlined">add</span>
            </div>
            <h2 className="font-semibold text-sm text-white">Add Memory</h2>
          </div>
          <div
            className="bento-card p-5 flex flex-col justify-between aspect-square cursor-pointer"
            onClick={() => navigate("/ai/restoration")}
          >
            <div className="w-10 h-10 rounded-xl bg-purple-500/20 flex items-center justify-center text-purple-400">
              <span className="material-symbols-outlined">auto_fix_high</span>
            </div>
            <h2 className="font-semibold text-sm text-white">AI Restore</h2>
          </div>
        </div>

        {/* Memories Bento Grid */}
        <section className="space-y-4">
          <div className="flex items-center justify-between">
            <h3 className="text-xs font-bold uppercase tracking-widest text-white/40">
              Featured Moments
            </h3>
            <button className="text-[10px] font-bold text-indigo-400">
              View All
            </button>
          </div>

          <div className="photo-grid">
            {featuredMemories.map((memory, index) => (
              <div
                key={memory.id}
                className={`bento-card ${index === 0 ? "featured-moment" : "aspect-square-card"} overflow-hidden relative`}
                style={{
                  backgroundImage: `url('${memory.imageUrl}')`,
                  backgroundSize: "cover",
                  backgroundPosition: "center",
                }}
              >
                {index === 0 && (
                  <>
                    <div className="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent"></div>
                    <div className="absolute bottom-4 left-4 text-left">
                      <p className="text-[10px] font-bold text-white/60">
                        {memory.location}
                        {memory.year ? `, ${memory.year}` : ""}
                      </p>
                      <h4 className="font-semibold text-sm text-white">
                        {memory.title}
                      </h4>
                    </div>
                  </>
                )}
              </div>
            ))}
          </div>
        </section>
      </main>

      {/* Floating Action Button */}
      <div className="fixed bottom-28 left-1/2 -translate-x-1/2 flex items-center gap-3">
        <button className="fab-glass h-14 px-6 rounded-full flex items-center gap-3 active:scale-95 transition-transform text-white">
          <span className="material-symbols-outlined text-indigo-400">
            bolt
          </span>
          <span className="text-sm font-semibold">Magic Tagging</span>
        </button>
      </div>
    </div>
  );
}

export default MemoriesScreen;
