/**
 * AI Features Hub
 *
 * Provides access to AI-driven genealogy tools:
 * - Identity Matcher (Face Detection)
 * - Photo Restoration
 * - Family Chronicles (Story Generation)
 */

import { useNavigate } from "react-router-dom";

function AIFeaturesScreen() {
  const navigate = useNavigate();

  const aiTools = [
    {
      id: "matcher",
      title: "Identity Matcher",
      desc: "Connect faces in old photos to your family tree nodes.",
      icon: "face",
      path: "/ai/identity-matcher",
      color: "blue",
    },
    {
      id: "restore",
      title: "AI Restoration",
      desc: "Enhance, colorize, and repair damaged historical memories.",
      icon: "auto_fix_high",
      path: "/ai/restoration",
      color: "purple",
    },
    {
      id: "chronicles",
      title: "Family Chronicles",
      desc: "Generate narrative stories from your family documents.",
      icon: "auto_stories",
      path: "/ai/chronicles",
      color: "orange",
    },
    {
      id: "resource-manager",
      title: "AI Resource Manager",
      desc: "Manage enhancement queues and processing power.",
      icon: "memory",
      path: "/ai/resource-manager",
      color: "cyan",
    },
    {
      id: "spatial-gallery",
      title: "Spatial Memory Gallery",
      desc: "Immersive 3D gallery for VisionOS (Prototype).",
      icon: "photo_library",
      path: "/memories/spatial-gallery",
      color: "indigo",
    },
    {
      id: "spatial-tree",
      title: "Spatial Heritage Tree",
      desc: "Interactive genealogy visualization (Prototype).",
      icon: "schema",
      path: "/family-tree/spatial",
      color: "emerald",
    },
  ];

  return (
    <div className="bg-background-light dark:bg-background-dark min-h-screen p-6 pb-24 font-display">
      <header className="mb-10 pt-8">
        <h1 className="text-4xl font-extrabold text-slate-900 dark:text-white mb-2 tracking-tight">
          AI Lab
        </h1>
        <p className="text-slate-500 dark:text-slate-400 text-sm font-medium">
          Advanced tools to preserve and rediscover your heritage.
        </p>
      </header>

      <div className="space-y-4">
        {aiTools.map((tool) => (
          <div
            key={tool.id}
            onClick={() => navigate(tool.path)}
            className="glass-panel p-6 flex items-center gap-5 cursor-pointer hover:bg-black/5 dark:hover:bg-white/5 transition-all transform active:scale-[0.98] rounded-2xl"
          >
            <div
              className={`w-14 h-14 rounded-2xl flex items-center justify-center bg-${tool.color}-500/20 text-${tool.color}-500 shadow-inner`}
            >
              <span className="material-symbols-outlined text-3xl">
                {tool.icon}
              </span>
            </div>
            <div className="flex-1">
              <h3 className="font-bold text-slate-900 dark:text-white mb-1">
                {tool.title}
              </h3>
              <p className="text-xs text-slate-500 dark:text-slate-400 leading-relaxed">
                {tool.desc}
              </p>
            </div>
            <span className="material-symbols-outlined text-slate-300 dark:text-white/20">
              chevron_right
            </span>
          </div>
        ))}
      </div>

      <div className="mt-8 glass-panel p-5 border-dashed border-primary/30 rounded-2xl">
        <div className="flex items-center gap-3 mb-3">
          <div className="w-2 h-2 rounded-full bg-primary animate-pulse shadow-[0_0_8px_rgba(17,115,212,0.6)]"></div>
          <span className="text-[10px] font-bold uppercase tracking-widest text-primary">
            Neural Indexing Active
          </span>
        </div>
        <p className="text-xs text-slate-600 dark:text-white/60 leading-relaxed">
          The engine is currently analyzing{" "}
          <span className="text-primary font-bold">42 archival documents</span>{" "}
          found in the Global Heritage Map. New matches will appear in your
          notifications.
        </p>
      </div>
    </div>
  );
}

export default AIFeaturesScreen;
