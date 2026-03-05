/**
 * Dashboard Screen
 *
 * Converted from Stitch: welcome_to_kinship_1/code.html
 * Main dashboard after authentication showing family tree, memories, and quick actions.
 */

import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import {
  subscribeToFamilies,
  subscribeToMediaItems,
  subscribeToAITasks,
  updateAITaskStatus,
  createAITask,
  subscribeToFamilyMembers,
} from "@lib/firestore";
import { signOut } from "@lib/auth";

function DashboardScreen() {
  const { user } = useAuth();
  const [families, setFamilies] = useState([]);
  const [members, setMembers] = useState([]);
  const [memories, setMemories] = useState([]);

  const [aiTasks, setAiTasks] = useState([]);

  // Subscribe to user's families and AI tasks
  useEffect(() => {
    if (!user) return;

    const unsubFamilies = subscribeToFamilies(user.uid, setFamilies);
    const unsubTasks = subscribeToAITasks(user.uid, setAiTasks);

    return () => {
      unsubFamilies();
      unsubTasks();
    };
  }, [user]);

  // Subscribe to members for the active family
  const activeFamilyId = families.length > 0 ? families[0].id : null;

  useEffect(() => {
    if (!activeFamilyId) return;
    const unsubMembers = subscribeToFamilyMembers(activeFamilyId, setMembers);
    return () => unsubMembers();
  }, [activeFamilyId]);

  // Subscribe to memories for the active family
  useEffect(() => {
    if (!activeFamilyId) return;
    const unsubMemories = subscribeToMediaItems(activeFamilyId, setMemories);
    return () => unsubMemories();
  }, [activeFamilyId]);

  const handleStartRestore = async (taskId) => {
    if (taskId) {
      await updateAITaskStatus(taskId, "running");
    } else {
      await createAITask(user.uid, {
        title: "Grandpa '54",
        type: "Enhance color",
        status: "pending",
        imageUrl:
          "https://lh3.googleusercontent.com/aida-public/AB6AXuCst1gIFGnX9hkdMwGTaxY6xjUlP-IAFFAh7ypfOuPKGVthwfRdOj01OQ5TVfUrQz3nmE7f3sWLFcEeZsZFJmMIX1GQYL3xDuFw49ZFBVnhAXd455GgLwYdqEj6VP9zHQjOLdbNqUtH9egfkXyq99VsuzDKq8pMEh8dCfPAv4XR6muac_M4rmeOXxkl_Ao8uGNz3sN9rMJ3IlXfIdezJzFvDSMtysjXO7GXs4B2tLwjld77v9VX3o4-npz_pJY5nIomO-I1vO1tcJ4",
      });
    }
  };

  const handleSignOut = async () => {
    await signOut();
  };

  return (
    <div className="relative flex h-full w-full min-h-screen flex-col overflow-x-hidden">
      {/* Background gradients */}
      <div className="fixed inset-0 z-0">
        <div className="absolute top-[-10%] left-[-10%] w-[60%] h-[60%] rounded-full bg-blue-600/30 blur-[100px]" />
        <div className="absolute bottom-[-10%] right-[-10%] w-[60%] h-[60%] rounded-full bg-purple-600/30 blur-[100px]" />
        <div className="absolute top-[40%] left-[30%] w-[50%] h-[50%] rounded-full bg-pink-500/20 blur-[120px]" />
        <div className="absolute inset-0 bg-black/10 backdrop-blur-[1px]" />
      </div>

      {/* Header */}
      <header className="relative z-20 px-6 pt-14 pb-4 flex justify-between items-center">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-full bg-gradient-to-tr from-blue-400 to-purple-500 p-[2px] shadow-lg">
            <img
              alt="User Profile"
              className="w-full h-full rounded-full object-cover border-2 border-black/50"
              src={
                user?.photoURL ||
                `https://ui-avatars.com/api/?name=${encodeURIComponent(user?.displayName || "User")}&background=5a5cf2&color=fff`
              }
            />
          </div>
          <div>
            <h1 className="text-sm text-gray-300 font-medium">Welcome back,</h1>
            <p className="text-lg font-bold font-serif leading-none tracking-tight">
              {user?.displayName?.split(" ")[0] || "User"}
            </p>
          </div>
        </div>
        <button
          className="w-10 h-10 glass-card rounded-full flex items-center justify-center active:scale-95 transition-transform"
          onClick={handleSignOut}
        >
          <span className="material-symbols-outlined text-white/80">
            logout
          </span>
        </button>
      </header>

      {/* Main Content */}
      <main className="relative z-10 flex-1 px-4 pb-24 overflow-y-auto scrollbar-hide">
        {/* Family Tree Card */}
        <div className="w-full h-56 glass-card rounded-3xl mb-4 relative overflow-hidden group">
          <div
            className="absolute inset-0 bg-cover bg-center opacity-40 mix-blend-overlay"
            style={{
              backgroundImage: `url('https://images.unsplash.com/photo-1534330207526-9e4823cde21d?auto=format&fit=crop&q=80&w=2000')`,
            }}
          />
          <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent" />

          {/* Tree visualization placeholder */}
          <div className="absolute inset-0 opacity-30 pointer-events-none">
            <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg">
              <circle cx="50%" cy="80%" r="4" fill="white" />
              <line
                x1="50%"
                y1="80%"
                x2="30%"
                y2="50%"
                stroke="white"
                strokeWidth="1"
              />
              <line
                x1="50%"
                y1="80%"
                x2="70%"
                y2="50%"
                stroke="white"
                strokeWidth="1"
              />
              <circle cx="30%" cy="50%" r="3" fill="white" />
              <circle cx="70%" cy="50%" r="3" fill="white" />
              <line
                x1="30%"
                y1="50%"
                x2="20%"
                y2="30%"
                stroke="white"
                strokeWidth="1"
              />
              <line
                x1="30%"
                y1="50%"
                x2="40%"
                y2="30%"
                stroke="white"
                strokeWidth="1"
              />
              <circle cx="20%" cy="30%" r="2" fill="white" />
              <circle cx="40%" cy="30%" r="2" fill="white" />
            </svg>
          </div>

          <div className="absolute bottom-0 left-0 p-5 w-full">
            <div className="flex justify-between items-end">
              <div>
                <span className="inline-block px-2 py-1 bg-blue-500/30 backdrop-blur-md rounded-md text-[10px] font-bold uppercase tracking-wider mb-2 border border-blue-400/30 text-blue-100">
                  Quick Pan
                </span>
                <h2 className="text-2xl font-serif font-semibold text-white">
                  Family Tree
                </h2>
                <p className="text-sm text-gray-300">
                  {families.length > 0
                    ? `${families.length} families`
                    : "Start your family tree"}
                </p>
              </div>
              <Link
                to="/family-tree"
                className="w-10 h-10 bg-white text-black rounded-full flex items-center justify-center shadow-lg hover:scale-105 transition-transform"
              >
                <span className="material-symbols-outlined">open_in_full</span>
              </Link>
            </div>
          </div>
        </div>

        {/* Stats Grid */}
        <div className="grid grid-cols-2 gap-4">
          {/* Growth Card */}
          <div className="col-span-1 glass-card p-4 rounded-3xl flex flex-col justify-between h-44 relative overflow-hidden">
            <div className="absolute -right-4 -top-4 w-24 h-24 bg-green-500/20 rounded-full blur-2xl" />
            <div className="flex items-center gap-2 mb-2 z-10">
              <span className="material-symbols-outlined text-green-400 text-xl">
                spa
              </span>
              <h3 className="font-bold text-sm text-gray-200">Growth</h3>
            </div>
            <div className="z-10">
              <div className="text-3xl font-bold text-white mb-1">
                {members.length}
              </div>
              <p className="text-xs text-gray-400">Members added</p>
            </div>
            <div className="mt-3 z-10">
              <div className="w-full bg-white/10 rounded-full h-1.5 mb-1">
                <div
                  className="bg-green-400 h-1.5 rounded-full"
                  style={{ width: "75%" }}
                />
              </div>
              <p className="text-[10px] text-green-300 font-medium">
                +{members.length} this month
              </p>
            </div>
          </div>

          {/* AI Tasks Card */}
          <div className="col-span-1 glass-card p-4 rounded-3xl flex flex-col justify-between h-44 relative overflow-hidden">
            <div className="absolute -left-4 -bottom-4 w-24 h-24 bg-purple-500/20 rounded-full blur-2xl" />
            <div className="flex items-center justify-between mb-2 z-10">
              <div className="flex items-center gap-2">
                <span className="material-symbols-outlined text-purple-400 text-xl">
                  auto_fix_high
                </span>
                <h3 className="font-bold text-sm text-gray-200">AI Tasks</h3>
              </div>
              <span className="bg-red-500 text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full">
                3
              </span>
            </div>
            <div className="space-y-2 z-10">
              {aiTasks.length > 0 ? (
                <div className="flex items-center gap-3 p-2 bg-white/5 rounded-xl border border-white/5">
                  <div className="w-8 h-8 rounded-lg bg-gray-600 overflow-hidden flex-shrink-0">
                    <img
                      src={aiTasks[0].imageUrl}
                      alt="Task"
                      className="w-full h-full object-cover opacity-80"
                    />
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="text-xs font-medium truncate">
                      {aiTasks[0].title}
                    </p>
                    <p className="text-[10px] text-purple-300">
                      {aiTasks[0].type}
                    </p>
                  </div>
                </div>
              ) : (
                <p className="text-center text-[10px] text-gray-500 italic py-2">
                  No pending tasks
                </p>
              )}
            </div>
            <button
              onClick={() =>
                handleStartRestore(aiTasks.length > 0 ? aiTasks[0].id : null)
              }
              className="mt-2 w-full py-2 bg-purple-500/20 hover:bg-purple-500/30 border border-purple-500/30 rounded-xl text-xs font-medium text-purple-100 transition-colors text-center block"
            >
              {aiTasks.length > 0 ? "Start Restore" : "Create Task"}
            </button>
          </div>

          {/* Recent Memories */}
          <div className="col-span-2 glass-card p-5 rounded-3xl">
            <div className="flex justify-between items-center mb-4">
              <div className="flex items-center gap-2">
                <span className="material-symbols-outlined text-orange-400 text-xl">
                  history_edu
                </span>
                <h3 className="font-bold text-sm text-gray-200">
                  Recent Memories
                </h3>
              </div>
              <Link
                to="/memories"
                className="text-xs text-gray-400 hover:text-white transition-colors"
              >
                View All
              </Link>
            </div>
            <div className="flex gap-3 overflow-x-auto scrollbar-hide pb-1">
              {memories.length > 0
                ? memories.map((memory) => (
                    <div
                      key={memory.id}
                      className="flex-shrink-0 w-32 group cursor-pointer"
                    >
                      <div className="w-32 h-40 rounded-2xl overflow-hidden relative mb-2 shadow-lg border border-white/10 bg-gray-800">
                        {memory.imageUrl ? (
                          <>
                            {/* ⚡ Bolt Optimization: Added lazy loading and async decoding to offscreen memories list to reduce initial load time and prevent main thread blocking */}
                            <img
                              src={memory.imageUrl}
                              alt={memory.title}
                              className="w-full h-full object-cover"
                              loading="lazy"
                              decoding="async"
                            />
                          </>
                        ) : (
                          <div className="w-full h-full bg-gradient-to-br from-gray-700 to-gray-800" />
                        )}
                        <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent" />
                        <div className="absolute bottom-2 left-2">
                          <p className="text-xs font-bold text-white">
                            {memory.year ||
                              new Date(
                                memory.createdAt?.seconds * 1000,
                              ).getFullYear()}
                          </p>
                        </div>
                      </div>
                      <p className="text-xs font-medium text-gray-300 truncate pl-1">
                        {memory.title}
                      </p>
                    </div>
                  ))
                : /* Fallback placeholders if no real memories yet */
                  [
                    { year: "1985", title: "Summer Wedding" },
                    { year: "1992", title: "First Grade" },
                  ].map((memory, i) => (
                    <div
                      key={i}
                      className="flex-shrink-0 w-32 group cursor-pointer"
                    >
                      <div className="w-32 h-40 rounded-2xl overflow-hidden relative mb-2 shadow-lg border border-white/10 bg-gradient-to-br from-gray-700 to-gray-800">
                        <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent" />
                        <div className="absolute bottom-2 left-2">
                          <p className="text-xs font-bold text-white">
                            {memory.year}
                          </p>
                        </div>
                      </div>
                      <p className="text-xs font-medium text-gray-300 truncate pl-1">
                        {memory.title}
                      </p>
                    </div>
                  ))}

              {/* Add New */}
              <Link
                to="/memories"
                className="flex-shrink-0 w-32 group cursor-pointer"
              >
                <div className="w-32 h-40 rounded-2xl overflow-hidden relative mb-2 shadow-lg border border-white/10 flex items-center justify-center bg-white/5">
                  <span className="material-symbols-outlined text-white/50 text-3xl">
                    add_a_photo
                  </span>
                </div>
                <p className="text-xs font-medium text-gray-300 truncate pl-1">
                  Add New
                </p>
              </Link>
            </div>
          </div>

          {/* Quick Actions */}
          <Link
            to="/family-tree"
            className="col-span-1 h-24 glass-card p-4 rounded-3xl flex items-center gap-3 cursor-pointer hover:bg-white/15 transition-colors"
          >
            <div className="w-10 h-10 rounded-full bg-blue-500/20 flex items-center justify-center text-blue-400">
              <span className="material-symbols-outlined">person_add</span>
            </div>
            <div>
              <p className="font-bold text-sm text-white">Invite</p>
              <p className="text-[10px] text-gray-400">Kinship</p>
            </div>
          </Link>

          <Link
            to="/memories"
            className="col-span-1 h-24 glass-card p-4 rounded-3xl flex items-center gap-3 cursor-pointer hover:bg-white/15 transition-colors"
          >
            <div className="w-10 h-10 rounded-full bg-orange-500/20 flex items-center justify-center text-orange-400">
              <span className="material-symbols-outlined">mic</span>
            </div>
            <div>
              <p className="font-bold text-sm text-white">Record</p>
              <p className="text-[10px] text-gray-400">Story</p>
            </div>
          </Link>
        </div>

        <div className="h-8" />
      </main>
    </div>
  );
}

export default DashboardScreen;
