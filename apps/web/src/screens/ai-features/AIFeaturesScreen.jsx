/**
 * AI Features Hub
 *
 * Provides access to AI-driven genealogy tools:
 * - Identity Matcher (Face Detection)
 * - Photo Restoration
 * - Family Chronicles (Story Generation)
 */

import { useNavigate } from "react-router-dom";
import BottomNav from "@/components/BottomNav";
import "./IdentityMatcherScreen.css"; // Reuse glass styles

function AIFeaturesScreen() {
  const navigate = useNavigate();

  const aiTools = [
    {
      id: "matcher",
      title: "Identity Matcher",
      desc: "Connect faces in old photos to your family tree nodes.",
      icon: "face",
      path: "/ai/identity-matcher",
      color: "indigo",
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
      path: "/ai/chronicles", // Upcoming
      color: "orange",
    },
  ];

  return (
    <div className="identity-matcher-container p-6 pb-32">
      <div className="mesh-bg"></div>

      <header className="mb-10 pt-8">
        <h1 className="text-3xl font-serif font-bold text-white mb-2">
          AI Lab
        </h1>
        <p className="text-white/50 text-sm">
          Advanced tools to preserve your heritage.
        </p>
      </header>

      <div className="space-y-4">
        {aiTools.map((tool) => (
          <div
            key={tool.id}
            onClick={() => navigate(tool.path)}
            className="glass-pane p-6 flex items-center gap-5 cursor-pointer hover:bg-white/10 transition-colors"
          >
            <div
              className={`w-14 h-14 rounded-2xl flex items-center justify-center bg-${tool.color}-500/20 text-${tool.color}-400`}
            >
              <span className="material-symbols-outlined text-3xl">
                {tool.icon}
              </span>
            </div>
            <div className="flex-1">
              <h3 className="font-bold text-white mb-1">{tool.title}</h3>
              <p className="text-xs text-white/40 leading-relaxed">
                {tool.desc}
              </p>
            </div>
            <span className="material-symbols-outlined text-white/20">
              chevron_right
            </span>
          </div>
        ))}
      </div>

      <div className="mt-8 glass-pane p-5 border-dashed border-indigo-500/30">
        <div className="flex items-center gap-3 mb-3">
          <div className="w-2 h-2 rounded-full bg-indigo-500 animate-pulse shadow-[0_0_8px_#6366f1]"></div>
          <span className="text-[10px] font-bold uppercase tracking-widest text-indigo-400">
            Deep Search Active
          </span>
        </div>
        <p className="text-xs text-white/60">
          AI is currently indexing 42 new archival documents found in the Global
          Heritage Map.
        </p>
      </div>

      <BottomNav />
    </div>
  );
}

export default AIFeaturesScreen;
