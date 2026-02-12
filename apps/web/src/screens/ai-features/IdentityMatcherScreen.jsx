/**
 * AI Identity Matcher Screen
 *
 * Converted from Stitch: Precision AI Face Matcher - Aevum
 * Uses AI to identify faces in historical photos and suggest matches in the tree.
 */

import { useState, useEffect, useRef } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import {
  subscribeToFamilies,
  subscribeToFamilyMembers,
  updateFamilyMember,
} from "@lib/firestore";

function IdentityMatcherScreen() {
  const navigate = useNavigate();
  const { user } = useAuth();
  const [families, setFamilies] = useState([]);
  const [members, setMembers] = useState([]);
  const [selectedMatch, setSelectedMatch] = useState(null); // The ID of the suggested member
  const [isAnalyzing, setIsAnalyzing] = useState(true);

  // Simulation state for detected faces in the current photo
  const [detectedFaces] = useState([
    {
      id: 1,
      name: "Grandpa Joe",
      confidence: 98,
      top: "32%",
      left: "48%",
      width: "14%",
      height: "18%",
    },
    {
      id: 2,
      name: "Uncle Bob",
      confidence: 45,
      top: "36%",
      left: "22%",
      width: "10%",
      height: "14%",
    },
    {
      id: 3,
      name: "Unknown",
      confidence: 78,
      top: "29%",
      left: "72%",
      width: "12%",
      height: "16%",
    },
  ]);
  const [activeFaceId, setActiveFaceId] = useState(1);

  useEffect(() => {
    if (!user) return;
    const unsub = subscribeToFamilies(user.uid, setFamilies);
    return () => unsub();
  }, [user]);

  useEffect(() => {
    if (families.length === 0) return;
    const unsub = subscribeToFamilyMembers(families[0].id, (newMembers) => {
      setMembers(newMembers);
      // Auto-select the best match if available
      if (newMembers.length > 0 && !selectedMatch) {
        setSelectedMatch(newMembers[0].id);
      }
    });
    return () => unsub();
  }, [families]);

  useEffect(() => {
    const timer = setTimeout(() => setIsAnalyzing(false), 2000);
    return () => clearTimeout(timer);
  }, []);

  const activeFace = detectedFaces.find((f) => f.id === activeFaceId);

  const handleConfirm = async () => {
    if (!selectedMatch) return;

    if (selectedMatch === "ai-group-1") {
      // Create a new "Potential" member in the tree
      if (families.length > 0) {
        console.log("Creating new potential relative from AI cluster...");
        // In a real scenario, we'd call addFamilyMember with role: 'Potential Relative' or similar
        alert(
          "New Cluster Confirmed! This person has been added to your tree as a 'Potential Relative' for you to identify later.",
        );
      }
    } else {
      const member = members.find((m) => m.id === selectedMatch);
      console.log(
        "Confirming match for face:",
        activeFaceId,
        "with member:",
        member?.name,
      );
      alert(`Match confirmed! ${member?.name} has been tagged in this photo.`);
    }

    navigate("/family-tree");
  };

  return (
    <div className="bg-background-light dark:bg-background-dark min-h-screen flex flex-col font-display antialiased overflow-x-hidden">
      {/* Header */}
      <header className="sticky top-0 z-50 flex items-center justify-between px-4 py-3 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-md">
        <button
          onClick={() => navigate(-1)}
          className="flex items-center justify-center w-10 h-10 rounded-full text-slate-900 dark:text-white hover:bg-black/5 dark:hover:bg-white/10 transition-colors"
        >
          <span className="material-symbols-outlined">arrow_back</span>
        </button>
        <h1 className="text-lg font-bold text-slate-900 dark:text-white tracking-tight">
          Identify Faces
        </h1>
        <button
          onClick={() => navigate("/dashboard")}
          className="text-sm font-semibold text-slate-500 dark:text-slate-400 hover:text-primary dark:hover:text-primary transition-colors"
        >
          Skip
        </button>
      </header>

      <main className="flex-1 flex flex-col gap-4 p-4 pb-24 max-w-md mx-auto w-full overflow-y-auto">
        {/* Main Photo with Face Markers */}
        <div className="relative w-full aspect-[4/3] rounded-2xl overflow-hidden glass-panel group shadow-2xl">
          <div
            className="absolute inset-0 bg-cover bg-center"
            style={{
              backgroundImage: `url('https://lh3.googleusercontent.com/aida-public/AB6AXuC31RpQX57UnykwreUCc1soshAuPgixpGwElecNvQXJSif9R6dIbPPm0zmW6RHa7tjxEgZtuSVpi3k2_i1U5keZSMfcKSoN63rF_cmlAs4G6EciEafIpZyLQqrzMwKGBmucasxYidpGUFHoDgS_YjYEDpWZzRUl3QLJ3gaNFw8-T2Ey2fboKwpq3-4GLm_vuhp7DZEHLbAN---O1iWdAKzJkHVHEp_pYQ7H-gYYgBoj5mcHx-Vo76VwBxdADbZ-gQk6LFwU29mfDRs')`,
            }}
          >
            <div className="absolute inset-0 bg-black/20"></div>
          </div>

          {!isAnalyzing &&
            detectedFaces.map((face) => (
              <div
                key={face.id}
                onClick={() => setActiveFaceId(face.id)}
                className={`absolute border rounded-sm transition-all cursor-pointer z-20 ${
                  activeFaceId === face.id
                    ? "border-primary/50 bg-primary/10 shadow-[0_0_20px_rgba(17,115,212,0.4)] scan-corners"
                    : "border-white/30 hover:border-white/60 opacity-60 hover:opacity-100"
                }`}
                style={{
                  top: face.top,
                  left: face.left,
                  width: face.width,
                  height: face.height,
                }}
              >
                {activeFaceId === face.id && (
                  <>
                    <div className="absolute inset-0 scan-corners-inner"></div>
                    <div className="absolute -top-8 left-1/2 -translate-x-1/2 bg-primary text-white text-[10px] font-bold px-2 py-0.5 rounded-full whitespace-nowrap shadow-lg">
                      Selected
                    </div>
                  </>
                )}
              </div>
            ))}

          {isAnalyzing && (
            <div className="absolute inset-0 bg-black/40 backdrop-blur-sm flex flex-col items-center justify-center z-50">
              <div className="w-12 h-12 border-4 border-primary/30 border-t-primary rounded-full animate-spin mb-4"></div>
              <p className="text-white text-sm font-bold tracking-widest animate-pulse">
                ANALYZING FACES
              </p>
            </div>
          )}

          <div className="absolute bottom-3 right-3 bg-black/60 backdrop-blur-md text-white/80 text-[10px] px-2 py-1 rounded-md font-medium flex items-center gap-1 border border-white/10">
            <span className="material-symbols-outlined text-[12px]">
              calendar_today
            </span>{" "}
            1964
          </div>
        </div>

        <div className="px-1 pt-2">
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white leading-tight">
            Is this{" "}
            <span className="text-primary">
              {activeFaceId === 3
                ? "Unknown?"
                : activeFace?.name || "Detecting..."}
            </span>
            ?
          </h2>
          <p className="text-sm text-slate-500 dark:text-slate-400 mt-1">
            Found in "Summer Vacation 1964"
          </p>
        </div>

        {/* Suggested Matches Scroll */}
        <div className="flex gap-3 overflow-x-auto pb-2 -mx-4 px-4 scrollbar-hide snap-x">
          {/* Real Matches from Tree */}
          {members.map((member) => (
            <div
              key={member.id}
              onClick={() => setSelectedMatch(member.id)}
              className={`snap-center shrink-0 flex flex-col gap-3 p-4 rounded-2xl min-w-[140px] cursor-pointer relative overflow-hidden transition-all ${
                selectedMatch === member.id
                  ? "glass-panel-active scale-105"
                  : "glass-panel opacity-70 grayscale hover:grayscale-0 hover:opacity-100"
              }`}
            >
              {selectedMatch === member.id && (
                <div className="absolute top-2 right-2 flex items-center justify-center w-5 h-5 bg-primary rounded-full z-10">
                  <span className="material-symbols-outlined text-white text-[14px]">
                    check
                  </span>
                </div>
              )}
              <div
                className={`w-14 h-14 rounded-full bg-cover bg-center border-2 mx-auto ${selectedMatch === member.id ? "border-primary shadow-lg" : "border-white/10"}`}
                style={{
                  backgroundImage: `url('${member.photoURL || `https://ui-avatars.com/api/?name=${encodeURIComponent(member.name || "")}&background=random`}')`,
                }}
              ></div>
              <div className="text-center">
                <p className="text-sm font-bold text-slate-900 dark:text-white truncate max-w-[100px] mx-auto">
                  {member.name}
                </p>
                <p className="text-xs font-semibold text-primary mt-1">
                  98% Match
                </p>
              </div>
            </div>
          ))}

          {/* AI Grouping / "Unidentified" Matches (75%+) */}
          {activeFaceId === 3 && (
            <div
              onClick={() => setSelectedMatch("ai-group-1")}
              className={`snap-center shrink-0 flex flex-col gap-3 p-4 rounded-2xl min-w-[140px] cursor-pointer relative overflow-hidden transition-all ${
                selectedMatch === "ai-group-1"
                  ? "glass-panel-active scale-105"
                  : "glass-panel"
              }`}
            >
              <div className="w-14 h-14 rounded-full bg-slate-200 dark:bg-slate-800 flex items-center justify-center text-slate-400 dark:text-slate-500 mx-auto border-2 border-dashed border-primary/30 relative">
                <span className="material-symbols-outlined text-2xl">
                  person
                </span>
                <div className="absolute -bottom-1 -right-1 bg-primary text-white w-5 h-5 rounded-full flex items-center justify-center text-[10px] font-bold">
                  ?
                </div>
              </div>
              <div className="text-center">
                <p className="text-sm font-bold text-slate-900 dark:text-white">
                  New Cluster
                </p>
                <p className="text-xs font-semibold text-primary mt-1">
                  82% Confidence
                </p>
              </div>
            </div>
          )}

          {/* Add New Person */}
          <div className="snap-center shrink-0 flex flex-col items-center justify-center gap-2 p-4 rounded-2xl glass-panel min-w-[140px] cursor-pointer hover:bg-white/5 transition-colors border-dashed border-slate-300 dark:border-slate-700">
            <div className="w-12 h-12 rounded-full bg-slate-100 dark:bg-slate-800 flex items-center justify-center text-slate-400 dark:text-slate-500">
              <span className="material-symbols-outlined">add</span>
            </div>
            <p className="text-sm font-medium text-slate-700 dark:text-slate-300">
              New Person
            </p>
          </div>
        </div>

        {/* Context Grid */}
        <div className="grid grid-cols-2 gap-3">
          <div className="glass-panel p-4 rounded-2xl flex flex-col gap-3">
            <div className="flex items-center gap-2 mb-1">
              <span className="material-symbols-outlined text-primary text-[18px]">
                face
              </span>
              <h3 className="text-xs font-bold uppercase tracking-wider text-slate-500 dark:text-slate-400">
                AI Grouping
              </h3>
            </div>
            <p className="text-sm text-slate-800 dark:text-slate-200 font-medium leading-tight">
              Seen in{" "}
              <span className="text-primary font-bold">12 other photos</span>
            </p>
            <div className="flex -space-x-3 overflow-hidden py-1">
              <div className="w-10 h-10 rounded-full border-2 border-white dark:border-[#1e2329] bg-slate-300"></div>
              <div className="w-10 h-10 rounded-full border-2 border-white dark:border-[#1e2329] bg-slate-400"></div>
              <div className="w-10 h-10 rounded-full border-2 border-white dark:border-[#1e2329] bg-slate-500"></div>
              <div className="w-10 h-10 rounded-full border-2 border-white dark:border-[#1e2329] bg-slate-200 dark:bg-slate-800 flex items-center justify-center text-[10px] font-bold text-slate-600 dark:text-slate-400">
                +9
              </div>
            </div>
          </div>
          <div className="glass-panel p-4 rounded-2xl flex flex-col justify-between">
            <div>
              <h3 className="text-xs font-bold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-2">
                Family Tree
              </h3>
              <p className="text-sm text-slate-800 dark:text-slate-200">
                Suggested from{" "}
                <span className="font-semibold text-slate-900 dark:text-white">
                  Paternal Line
                </span>
              </p>
            </div>
            <div className="mt-4 pt-4 border-t border-slate-200 dark:border-white/10">
              <div className="flex items-center gap-2 text-xs text-slate-500 dark:text-slate-400">
                <span className="material-symbols-outlined text-[16px]">
                  share_location
                </span>
                <span>Detroit, MI</span>
              </div>
            </div>
          </div>
        </div>

        {/* Persistent Bottom Actions */}
        <div className="fixed bottom-0 left-0 right-0 p-4 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-xl border-t border-white/5 z-50">
          <div className="max-w-md mx-auto flex flex-col gap-3">
            <button
              onClick={handleConfirm}
              className="w-full h-14 bg-primary hover:bg-blue-600 active:bg-blue-700 text-white rounded-xl font-bold text-lg shadow-lg shadow-primary/25 flex items-center justify-center gap-2 transition-all transform active:scale-[0.98]"
            >
              <span className="material-symbols-outlined">person_check</span>
              Confirm Match
            </button>
            <div className="grid grid-cols-2 gap-3">
              <button
                onClick={() => navigate("/dashboard")}
                className="h-12 glass-panel hover:bg-white/10 text-slate-700 dark:text-slate-300 rounded-xl font-medium text-sm flex items-center justify-center gap-2 transition-colors"
              >
                <span className="material-symbols-outlined text-[18px]">
                  person_off
                </span>
                Not a Person
              </button>
              <button className="h-12 glass-panel hover:bg-white/10 text-slate-700 dark:text-slate-300 rounded-xl font-medium text-sm flex items-center justify-center gap-2 transition-colors">
                <span className="material-symbols-outlined text-[18px]">
                  edit
                </span>
                Edit Selection
              </button>
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}

export default IdentityMatcherScreen;
