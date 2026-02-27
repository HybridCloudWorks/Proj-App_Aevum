/**
 * Family Tree Screen
 *
 * Converted from Stitch: family_tree_explorer_1/code.html
 * Interactive family tree with glass cards, pan/zoom, and member management.
 */

import { useState, useEffect, useRef, useMemo, memo } from "react";
import { Link } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import { subscribeToFamilies, subscribeToFamilyMembers } from "@lib/firestore";

function FamilyTreeScreen() {
  const { user } = useAuth();
  const [families, setFamilies] = useState([]);
  const [members, setMembers] = useState([]);
  const [scale, setScale] = useState(1);
  const [position, setPosition] = useState({ x: 0, y: 0 });
  const [isDragging, setIsDragging] = useState(false);
  const canvasRef = useRef(null);

  useEffect(() => {
    if (!user) return;
    const unsub = subscribeToFamilies(user.uid, setFamilies);
    return () => unsub();
  }, [user]);

  useEffect(() => {
    if (families.length === 0) return;
    const unsub = subscribeToFamilyMembers(families[0].id, setMembers);
    return () => unsub();
  }, [families]);

  const handleZoomIn = () => setScale((s) => Math.min(s + 0.2, 2));
  const handleZoomOut = () => setScale((s) => Math.max(s - 0.2, 0.5));
  const handleCenter = () => {
    setScale(1);
    setPosition({ x: 0, y: 0 });
  };

  // Enhanced Graph-based Relationship Mapping
  // This helper finds a relative by checking specific relationship paths
  // e.g. "Father of User", "Spouse of Mother", etc.
  const treeData = useMemo(() => {
    const getMember = (roleOrRelationship) => {
      // 1. Direct role match
      let found = members.find(
        (m) =>
          m.role === roleOrRelationship ||
          m.relationship === roleOrRelationship,
      );
      if (found) return found;

      // 2. Fallback to inferred relationships (for more complex trees)
      // In a real graph, we'd search fatherId, motherId, etc.
      if (roleOrRelationship === "Grandfather") {
        const father = members.find((m) => m.role === "Father");
        if (father && father.fatherId)
          return members.find((m) => m.id === father.fatherId);
      }

      return null;
    };

    return {
      greatGrandma: getMember("Great Grandma") || {
        name: "Great Grandma",
        years: "1920 - 1998",
        hasMemory: true,
      },
      grandpaJohn: getMember("Grandfather") || {
        name: "Grandpa John",
        years: "1945 - 2018",
        hasMemory: true,
        badge: "New Story",
      },
      grandmaMary: getMember("Grandmother") || {
        name: "Grandma Mary",
        years: "1948 - Present",
      },
      father: getMember("Father") || {
        name: "Michael Johnson",
        years: "1970 - Present",
        role: "Father",
      },
      mother: getMember("Mother") || {
        name: "Sarah Johnson",
        years: "1972 - Present",
        role: "Mother",
      },
      user: {
        name: user?.displayName || "You",
        years: "1995 - Present",
        isUser: true,
      },
    };
  }, [members, user]);

  const handleMouseDown = () => {
    setIsDragging(true);
  };

  const handleMouseMove = (e) => {
    if (!isDragging) return;
    setPosition((prev) => ({
      x: prev.x + e.movementX,
      y: prev.y + e.movementY,
    }));
  };

  const handleMouseUp = () => {
    setIsDragging(false);
  };

  // Touch support for mobile panning
  const lastTouch = useRef(null);
  const handleTouchStart = (e) => {
    lastTouch.current = { x: e.touches[0].clientX, y: e.touches[0].clientY };
  };

  const handleTouchMove = (e) => {
    if (!lastTouch.current) return;
    const touch = e.touches[0];
    const dx = touch.clientX - lastTouch.current.x;
    const dy = touch.clientY - lastTouch.current.y;
    setPosition((prev) => ({
      x: prev.x + dx,
      y: prev.y + dy,
    }));
    lastTouch.current = { x: touch.clientX, y: touch.clientY };
  };

  const handleTouchEnd = () => {
    lastTouch.current = null;
  };

  return (
    <div className="bg-[#0f151b] text-white font-display overflow-hidden h-screen flex flex-col selection:bg-primary selection:text-white">
      {/* Header */}
      <header className="absolute top-0 left-0 right-0 z-20 flex items-center justify-between px-4 py-4 glass-panel border-b-0 rounded-b-3xl mx-2 mt-2">
        <div className="flex items-center gap-3">
          <Link
            to="/dashboard"
            className="p-2 rounded-full hover:bg-white/10 transition-colors text-white/80"
          >
            <span className="material-symbols-outlined text-2xl">
              arrow_back
            </span>
          </Link>
          <div>
            <h1 className="text-lg font-bold leading-tight bg-clip-text text-transparent bg-gradient-to-r from-white to-slate-400">
              {families[0]?.name || "Johnson Ancestry"}
            </h1>
            <p className="text-[10px] text-slate-400 font-medium tracking-wide">
              EDITING NOW
            </p>
          </div>
        </div>
        <div className="flex items-center gap-2">
          <button className="glass-card px-3 py-1.5 rounded-full flex items-center gap-1.5 hover:bg-white/10 transition-colors">
            <span className="material-symbols-outlined text-lg text-primary">
              filter_alt
            </span>
            <span className="text-xs font-medium">Filter</span>
          </button>
          <button className="p-2 rounded-full bg-primary text-white shadow-[0_0_20px_rgba(17,115,212,0.6)] hover:bg-primary/90 transition-colors">
            <span className="material-symbols-outlined text-xl">
              person_add
            </span>
          </button>
        </div>
      </header>

      {/* Tree Canvas */}
      <main
        ref={canvasRef}
        onMouseDown={handleMouseDown}
        onMouseMove={handleMouseMove}
        onMouseUp={handleMouseUp}
        onMouseLeave={handleMouseUp}
        onTouchStart={handleTouchStart}
        onTouchMove={handleTouchMove}
        onTouchEnd={handleTouchEnd}
        className="flex-1 overflow-hidden relative cursor-grab active:cursor-grabbing bg-[#0b0f14]"
        style={{
          backgroundImage:
            "radial-gradient(rgba(255,255,255,0.07) 1px, transparent 1px)",
          backgroundSize: "32px 32px",
        }}
      >
        {/* Background blurs */}
        <div className="absolute top-1/4 left-1/4 w-[500px] h-[500px] bg-primary/10 rounded-full blur-[100px] pointer-events-none" />
        <div className="absolute bottom-1/4 right-1/4 w-[400px] h-[400px] bg-purple-500/5 rounded-full blur-[80px] pointer-events-none" />

        {/* Scrollable Tree Container */}
        <div
          className="w-full h-full overflow-auto scrollbar-hide flex flex-col items-center justify-center py-20 px-4"
          style={{
            transform: `scale(${scale}) translate(${position.x}px, ${position.y}px)`,
          }}
        >
          <div className="min-w-[800px] min-h-[1000px] flex flex-col items-center relative">
            {/* Generation 1: Great Grandparents */}
            <div className="flex gap-16 mb-16 relative z-10">
              <MemberCard member={treeData.greatGrandma} />
              <UnknownMemberCard />
            </div>

            {/* Connection line down */}
            <div className="w-64 h-8 border-t border-white/20 mb-0 relative -mt-12 mx-auto rounded-t-xl z-0" />
            <div className="h-8 w-[1px] bg-white/20 mb-8" />

            {/* Generation 2: Grandparents */}
            <div className="flex gap-24 mb-16 relative z-10">
              <div className="flex gap-6 relative">
                <div className="absolute top-full left-1/2 w-[1px] h-12 bg-white/20 -translate-x-1/2 z-0" />
                <MemberCard
                  member={treeData.grandpaJohn}
                  size="medium"
                  glowing
                />
                <div className="self-center w-6 h-[1px] bg-white/20" />
                <MemberCard member={treeData.grandmaMary} size="medium" />
              </div>
              <div className="flex gap-4 items-center opacity-60 hover:opacity-100 transition-opacity">
                <div className="w-16 h-16 rounded-full glass-card flex items-center justify-center text-white text-xs font-bold shadow-glass cursor-pointer hover:scale-110 transition-transform border border-white/20">
                  +2
                </div>
              </div>
            </div>

            {/* Connection line down */}
            <div className="w-[340px] h-12 border-t border-white/20 relative -mt-12 rounded-t-3xl" />
            <div className="h-8 w-[1px] bg-white/20 mb-8" />

            {/* Generation 3: Parents */}
            <div className="flex gap-32 mb-16 relative z-10">
              <div className="flex flex-col items-center relative">
                <MemberCard member={treeData.father} size="large" />
                <div className="absolute top-full left-1/2 w-[1px] h-16 bg-white/20 -translate-x-1/2 z-0" />
              </div>
              <div className="flex flex-col items-center relative">
                <MemberCard member={treeData.mother} size="large" />
                <div className="absolute top-full left-1/2 w-[1px] h-16 bg-white/20 -translate-x-1/2 z-0" />
              </div>
            </div>

            {/* Connection line down */}
            <div className="w-[300px] border-t border-white/20 h-10 relative -mt-12 rounded-t-full" />
            <div className="h-10 w-[2px] bg-gradient-to-b from-white/20 to-primary mb-4 shadow-[0_0_15px_rgba(17,115,212,0.5)]" />

            {/* Current User */}
            <div className="relative z-20 mb-12">
              <UserCard member={treeData.user} photoURL={user?.photoURL} />
              <div className="absolute top-full left-1/2 w-[1px] h-12 bg-white/20 -translate-x-1/2 z-0" />
            </div>

            {/* Add Child Button */}
            <div className="flex gap-8 relative z-10">
              <div className="flex flex-col items-center">
                <button className="w-14 h-14 rounded-full glass-card border-dashed border-white/30 flex items-center justify-center text-slate-400 hover:text-white hover:border-white transition-all shadow-glass hover:shadow-[0_0_15px_rgba(255,255,255,0.1)] group">
                  <span className="material-symbols-outlined group-hover:scale-110 transition-transform">
                    add
                  </span>
                </button>
                <p className="mt-3 text-xs text-slate-500 font-medium">
                  Add Child
                </p>
              </div>
            </div>
          </div>
        </div>
      </main>

      {/* Pan Control */}
      <div className="absolute bottom-28 right-6 z-30">
        <div className="relative w-32 h-32">
          <div className="absolute inset-0 glass-panel rounded-full shadow-2xl flex items-center justify-center">
            <div className="w-12 h-12 rounded-full bg-white/5 border border-white/10" />
            <span className="absolute top-2 left-1/2 -translate-x-1/2 material-symbols-outlined text-slate-400 text-sm pointer-events-none">
              expand_less
            </span>
            <span className="absolute bottom-2 left-1/2 -translate-x-1/2 material-symbols-outlined text-slate-400 text-sm pointer-events-none">
              expand_more
            </span>
            <span className="absolute left-2 top-1/2 -translate-y-1/2 material-symbols-outlined text-slate-400 text-sm pointer-events-none">
              chevron_left
            </span>
            <span className="absolute right-2 top-1/2 -translate-y-1/2 material-symbols-outlined text-slate-400 text-sm pointer-events-none">
              chevron_right
            </span>
          </div>
          <button className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-14 h-14 rounded-full bg-gradient-to-b from-slate-700 to-slate-900 border border-slate-600 shadow-[0_4px_10px_rgba(0,0,0,0.5),inset_0_2px_4px_rgba(255,255,255,0.1)] active:scale-95 transition-transform z-10 flex items-center justify-center group">
            <span className="material-symbols-outlined text-white/70 text-2xl group-active:text-primary transition-colors">
              pan_tool
            </span>
          </button>
          <button
            onClick={handleCenter}
            className="absolute -top-2 -right-2 w-10 h-10 rounded-full bg-primary text-white shadow-lg flex items-center justify-center hover:bg-primary/90 transition-all z-20 border-2 border-[#0f151b]"
          >
            <span className="material-symbols-outlined text-lg">
              center_focus_weak
            </span>
          </button>
        </div>
        <p className="text-center text-[10px] text-slate-500 font-medium mt-2 bg-black/40 px-2 py-0.5 rounded-full w-max mx-auto backdrop-blur-sm">
          Infinite Pan
        </p>
      </div>

      {/* Zoom Controls */}
      <div className="absolute bottom-28 left-6 z-30 flex flex-col gap-3">
        <div className="glass-panel p-1.5 rounded-full flex flex-col gap-2 shadow-lg">
          <button
            onClick={handleZoomIn}
            className="w-10 h-10 rounded-full hover:bg-white/10 text-white flex items-center justify-center transition-colors"
            title="Zoom In"
          >
            <span className="material-symbols-outlined text-xl">add</span>
          </button>
          <button
            onClick={handleZoomOut}
            className="w-10 h-10 rounded-full hover:bg-white/10 text-white flex items-center justify-center transition-colors"
            title="Zoom Out"
          >
            <span className="material-symbols-outlined text-xl">remove</span>
          </button>
        </div>
        <button className="w-12 h-12 rounded-full glass-panel text-white/90 shadow-lg flex items-center justify-center border border-white/10 hover:bg-white/5 transition-colors group relative">
          <span className="material-symbols-outlined text-xl group-hover:text-primary transition-colors">
            visibility
          </span>
          <span className="absolute left-full ml-2 px-2 py-1 bg-black/80 text-white text-[10px] rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap pointer-events-none">
            Focus Mode
          </span>
        </button>
      </div>
    </div>
  );
}

// Member Card Component
const MemberCard = memo(function MemberCard({
  member,
  size = "small",
  glowing = false,
}) {
  const sizeClasses = {
    small: "w-32 h-44 p-3",
    medium: "w-36 h-48 p-3",
    large: "w-40 h-52 p-4",
  };

  const photoSize = {
    small: "w-16 h-16",
    medium: "w-20 h-20",
    large: "w-20 h-20 ring-4 ring-white/5",
  };

  return (
    <div
      className={`glass-card rounded-2xl flex flex-col items-center relative hover:scale-105 transition-transform duration-300 group ${sizeClasses[size]} ${glowing ? "animate-pulse-slow border-orange-500/30" : ""}`}
    >
      {member.hasMemory && (
        <div
          className="absolute top-3 right-3 w-1.5 h-1.5 rounded-full bg-orange-400 shadow-[0_0_8px_rgba(255,165,0,0.8)] animate-pulse"
          title="New Memory"
        />
      )}
      <div
        className={`${photoSize[size]} rounded-full bg-slate-700 mb-3 overflow-hidden border-2 border-white/20 shadow-lg group-hover:border-primary/50 transition-colors`}
      >
        {member.photoURL ? (
          <img
            src={member.photoURL}
            alt={member.name}
            className="w-full h-full object-cover"
          />
        ) : (
          <div className="w-full h-full bg-gradient-to-br from-slate-600 to-slate-800 flex items-center justify-center">
            <span className="material-symbols-outlined text-slate-400 text-2xl">
              person
            </span>
          </div>
        )}
      </div>
      <p
        className={`${size === "large" ? "text-base" : "text-sm"} font-bold text-center text-white truncate w-full`}
      >
        {member.name}
      </p>
      <p className="text-xs text-slate-400">{member.years}</p>
      {member.badge && (
        <span className="mt-2 text-[9px] text-orange-300 font-medium px-2 py-0.5 rounded-full bg-orange-500/10 border border-orange-500/20">
          {member.badge}
        </span>
      )}
      {member.role && (
        <div
          className={`mt-3 px-3 py-1 rounded-full ${member.role === "Father" ? "bg-blue-500/10 border-blue-500/20 text-blue-300" : "bg-pink-500/10 border-pink-500/20 text-pink-300"} border text-[10px] font-bold uppercase tracking-wider backdrop-blur-sm`}
        >
          {member.role}
        </div>
      )}
    </div>
  );
});

// Unknown Member Card
const UnknownMemberCard = memo(function UnknownMemberCard() {
  return (
    <div className="w-32 h-44 glass-card bg-white/5 rounded-2xl border-dashed border-white/20 flex flex-col items-center justify-center p-3 relative group hover:bg-white/10 transition-colors cursor-pointer">
      <div className="w-12 h-12 rounded-full bg-white/5 mb-2 flex items-center justify-center text-slate-500 group-hover:text-primary transition-colors border border-white/5">
        <span className="material-symbols-outlined text-3xl">person</span>
      </div>
      <p className="text-xs font-medium text-center text-slate-400 group-hover:text-white/80">
        Unknown
      </p>
      <button className="absolute -bottom-3 w-8 h-8 rounded-full bg-gradient-to-br from-primary to-blue-600 text-white flex items-center justify-center shadow-lg hover:scale-110 transition-transform border border-white/10">
        <span className="material-symbols-outlined text-lg">add</span>
      </button>
    </div>
  );
});

// User Card (highlighted)
const UserCard = memo(function UserCard({ member, photoURL }) {
  return (
    <div className="w-60 h-72 glass-card rounded-3xl border-2 border-primary/30 shadow-[0_0_20px_rgba(17,115,212,0.6)] flex flex-col items-center p-0 relative overflow-hidden group">
      <div className="absolute top-0 left-0 w-full h-32 bg-gradient-to-b from-primary/20 via-primary/5 to-transparent" />
      <div className="mt-8 mb-4 relative z-10">
        <div className="w-32 h-32 rounded-full p-1 bg-gradient-to-br from-primary via-blue-400 to-transparent shadow-2xl">
          <div className="w-full h-full rounded-full overflow-hidden border-4 border-[#1e293b]">
            <img
              className="w-full h-full object-cover"
              alt="You"
              src={
                photoURL ||
                `https://ui-avatars.com/api/?name=${encodeURIComponent(member.name)}&background=5a5cf2&color=fff&size=128`
              }
            />
          </div>
        </div>
        <div className="absolute -bottom-2 -right-2 bg-primary text-white text-[10px] font-bold px-2 py-1 rounded-full border border-slate-900 shadow-lg">
          YOU
        </div>
      </div>
      <div className="relative z-10 text-center px-4 w-full">
        <p className="text-xl font-bold text-white tracking-tight">
          {member.name}
        </p>
        <p className="text-sm text-slate-400 mt-1">{member.years}</p>
        <div className="flex gap-3 justify-center mt-5 opacity-0 group-hover:opacity-100 transition-all duration-300 transform translate-y-2 group-hover:translate-y-0">
          <button className="w-9 h-9 rounded-full bg-white/10 hover:bg-white/20 flex items-center justify-center text-white transition-colors border border-white/10 backdrop-blur-md">
            <span className="material-symbols-outlined text-sm">edit</span>
          </button>
          <button className="w-9 h-9 rounded-full bg-white/10 hover:bg-white/20 flex items-center justify-center text-white transition-colors border border-white/10 backdrop-blur-md">
            <span className="material-symbols-outlined text-sm">
              add_a_photo
            </span>
          </button>
          <button className="w-9 h-9 rounded-full bg-white/10 hover:bg-white/20 flex items-center justify-center text-white transition-colors border border-white/10 backdrop-blur-md">
            <span className="material-symbols-outlined text-sm">
              visibility
            </span>
          </button>
        </div>
      </div>
    </div>
  );
});

export default FamilyTreeScreen;
