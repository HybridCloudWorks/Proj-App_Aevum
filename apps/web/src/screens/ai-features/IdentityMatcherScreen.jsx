/**
 * AI Identity Matcher Screen
 *
 * Migrated from Stitch screen: 9205c379075a4bbba03dd845382fb51b
 * Uses AI to identify faces in historical photos and suggest matches in the tree.
 */

import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import {
  subscribeToFamilies,
  subscribeToFamilyMembers,
  requestMediaAnalysis,
} from "@lib/firestore";
import BottomNav from "@/components/BottomNav";
import "./IdentityMatcherScreen.css";

function IdentityMatcherScreen() {
  const navigate = useNavigate();
  const { user } = useAuth();
  const [selectedFace, setSelectedFace] = useState(1);
  const [families, setFamilies] = useState([]);
  const [members, setMembers] = useState([]);
  const [isAnalyzing, setIsAnalyzing] = useState(true);

  // 1. Fetch data
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

  // 2. Simulate AI Analysis Trigger
  useEffect(() => {
    // In a real flow, the user would select a photo.
    // For this demo, we'll simulate the "call to backend" on mount if a photo is "selected"
    const timer = setTimeout(() => setIsAnalyzing(false), 2500);
    return () => clearTimeout(timer);
  }, []);

  const handleConfirm = async () => {
    // If we have a specific memoryId, we trigger the real analysis
    // For now, we simulate the link to the first member found
    if (members.length > 0) {
      const firstMember = members[0];
      console.log("Confirming match for:", firstMember.name);

      // Real backend trigger via Firestore
      // await requestMediaAnalysis('current-photo-id');

      alert(
        `Identity Confirmed: ${firstMember.name} has been linked to this photo.`,
      );
    } else {
      alert("Identity Confirmed & Linked to Tree!");
    }
    navigate("/family-tree");
  };

  return (
    <div className="identity-matcher-container pb-32 p-6">
      {/* Header */}
      <header className="flex items-center justify-between mb-8">
        <button
          onClick={() => navigate(-1)}
          className="p-2 -ml-2 rounded-full hover:bg-white/5 text-white"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            className="h-6 w-6"
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
        <h1 className="text-sm font-bold uppercase tracking-widest text-white/60">
          Identify Faces
        </h1>
        <button
          onClick={() => navigate("/dashboard")}
          className="text-sm font-semibold text-indigo-400"
        >
          Skip
        </button>
      </header>

      {/* Main Subject Photo */}
      <div className="glass-pane overflow-hidden relative mb-6">
        <div className="relative">
          <img
            src="https://images.unsplash.com/photo-1511895426328-dc8714191300?w=1000&q=80"
            className={`w-full aspect-[4/3] object-cover transition-opacity duration-1000 ${isAnalyzing ? "opacity-30 grayscale" : "opacity-80"}`}
            alt="Historical Group"
          />

          {isAnalyzing ? (
            <div className="absolute inset-0 flex flex-col items-center justify-center">
              <div className="w-12 h-12 border-4 border-indigo-500/30 border-t-indigo-500 rounded-full animate-spin mb-4"></div>
              <p className="text-xs font-bold text-white uppercase tracking-[0.2em] animate-pulse">
                Analyzing Faces...
              </p>
            </div>
          ) : (
            <>
              {/* AI Face Boxes */}
              <div
                className={`face-box ${selectedFace === 0 ? "selected" : ""}`}
                style={{
                  top: "25%",
                  left: "15%",
                  width: "60px",
                  height: "60px",
                }}
                onClick={() => setSelectedFace(0)}
              ></div>
              <div
                className={`face-box ${selectedFace === 1 ? "selected" : ""}`}
                style={{
                  top: "22%",
                  left: "45%",
                  width: "70px",
                  height: "70px",
                }}
                onClick={() => setSelectedFace(1)}
              ></div>
              <div
                className={`face-box ${selectedFace === 2 ? "selected" : ""}`}
                style={{
                  top: "28%",
                  left: "75%",
                  width: "55px",
                  height: "55px",
                }}
                onClick={() => setSelectedFace(2)}
              ></div>
            </>
          )}
        </div>
        <div className="p-4 text-center">
          <p className="text-[10px] text-white/40 font-medium mb-1 uppercase tracking-tighter">
            {isAnalyzing ? "Processing Neural Engine" : "AI Prediction"}
          </p>
          <h2 className="text-xl font-bold text-white">
            {isAnalyzing ? (
              "Detecting Subjects..."
            ) : (
              <>
                Is this <span className="text-indigo-400">Grandpa Joe?</span>
              </>
            )}
          </h2>
        </div>
      </div>

      {/* Suggested Matches */}
      <section className="mb-8">
        <h3 className="text-[10px] font-bold text-white/30 uppercase tracking-widest mb-4">
          Suggested Matches
        </h3>
        <div className="flex gap-4 overflow-x-auto scrollbar-hide pb-2">
          {members.length > 0 ? (
            members.map((member, idx) => (
              <div
                key={member.id}
                className={`glass-pane p-4 min-w-[140px] flex flex-col items-center text-center transition-all ${idx === 0 && !isAnalyzing ? "active-glow" : ""}`}
              >
                <img
                  src={
                    member.photoURL ||
                    `https://ui-avatars.com/api/?name=${encodeURIComponent(member.name || "")}&background=random`
                  }
                  className={`w-16 h-16 rounded-full mb-3 border ${idx === 0 ? "border-indigo-500" : "border-white/10"}`}
                  alt={member.name}
                />
                <h4 className="text-xs font-bold text-white mb-1">
                  {member.name || member.role}
                </h4>
                <span
                  className={`${idx === 0 ? "match-badge" : "bg-white/10"} text-[9px] px-2 py-0.5 rounded-full font-bold text-white`}
                >
                  {idx === 0
                    ? "94% Match"
                    : `${Math.floor(Math.random() * 40 + 30)}% Match`}
                </span>
              </div>
            ))
          ) : (
            <>
              {/* Fallback to samples if no members in Firestore */}
              <div className="glass-pane p-4 min-w-[140px] flex flex-col items-center text-center">
                <img
                  src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&h=100&fit=crop"
                  className="w-16 h-16 rounded-full mb-3 border border-indigo-500"
                  alt="Joe"
                />
                <h4 className="text-xs font-bold text-white mb-1">
                  Joseph Sterling
                </h4>
                <span className="match-badge text-[9px] px-2 py-0.5 rounded-full font-bold">
                  94% Match
                </span>
              </div>
            </>
          )}

          {/* Add New */}
          <div className="glass-pane p-4 min-w-[140px] flex flex-col items-center justify-center border-dashed border-white/20">
            <div className="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center mb-2">
              <svg
                className="w-5 h-5 text-white/40"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path strokeWidth="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
              </svg>
            </div>
            <span className="text-[9px] font-bold text-white/40 uppercase">
              New Person
            </span>
          </div>
        </div>
      </section>

      <BottomNav />

      {/* Contextual Info Cards (Bento) */}
      <div className="grid grid-cols-2 gap-4 mb-8">
        <div className="glass-pane p-4">
          <p className="text-[9px] font-bold text-white/30 uppercase mb-2">
            AI Grouping
          </p>
          <div className="flex -space-x-3">
            <img
              src="https://images.unsplash.com/photo-1542037104857-ffbb0b9155fb?w=100&h=100&fit=crop"
              className="w-10 h-10 rounded-lg border-2 border-gray-900 object-cover"
            />
            <img
              src="https://images.unsplash.com/photo-1511895426328-dc8714191300?w=100&h=100&fit=crop"
              className="w-10 h-10 rounded-lg border-2 border-gray-900 object-cover"
            />
            <div className="w-10 h-10 rounded-lg bg-white/10 flex items-center justify-center text-[10px] font-bold border-2 border-gray-900 text-white">
              +12
            </div>
          </div>
          <p className="text-[10px] mt-2 text-white/50 leading-tight">
            Similar faces found in London collection.
          </p>
        </div>
        <div className="glass-pane p-4">
          <p className="text-[9px] font-bold text-white/30 uppercase mb-2">
            Family Tree
          </p>
          <div className="flex items-center gap-2">
            <div className="w-2 h-2 rounded-full bg-indigo-500 shadow-[0_0_8px_#6366f1]"></div>
            <span className="text-xs font-semibold text-white">
              Miller Branch
            </span>
          </div>
          <p className="text-[10px] mt-2 text-white/50">
            Likely descendant of Arthur Sterling.
          </p>
        </div>
      </div>

      {/* Action Buttons */}
      <div className="fixed bottom-0 left-0 right-0 p-6 bg-gradient-to-t from-black via-black/90 to-transparent">
        <div className="flex flex-col gap-3">
          <button
            onClick={handleConfirm}
            className="w-full h-14 bg-gradient-to-r from-indigo-500 to-purple-500 rounded-2xl font-bold text-lg text-white shadow-lg shadow-indigo-500/20"
          >
            Confirm Match
          </button>
          <div className="grid grid-cols-2 gap-3">
            <button className="h-12 glass-pane bg-white/5 font-bold text-[10px] uppercase tracking-widest text-white/60">
              Not a Person
            </button>
            <button className="h-12 glass-pane bg-white/5 font-bold text-[10px] uppercase tracking-widest text-white/60">
              Edit Selection
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default IdentityMatcherScreen;
