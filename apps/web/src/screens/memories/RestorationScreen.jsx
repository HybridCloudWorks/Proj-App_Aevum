/**
 * Memories Screen
 *
 * Converted from Stitch: member_memories_1/code.html
 * AI photo restoration with before/after comparison and enhancement controls.
 */

import { useNavigate, Link } from "react-router-dom";
import { requestPhotoRestoration } from "@lib/firestore";
import BottomNav from "@/components/BottomNav";

function RestorationScreen() {
  const navigate = useNavigate();
  const [sliderPosition, setSliderPosition] = useState(50);
  const [colorize, setColorize] = useState(true);
  const [sharpen, setSharpen] = useState(true);
  const [repair, setRepair] = useState(false);
  const [isProcessing, setIsProcessing] = useState(false);

  const handleSliderChange = (e) => {
    setSliderPosition(e.target.value);
  };

  const handleSave = async () => {
    setIsProcessing(true);

    // Real call to backend via Firestore
    const params = { colorize, sharpen, repair };
    // Example memoryId for development
    const result = await requestPhotoRestoration("example-photo-id", params);

    setTimeout(() => {
      setIsProcessing(false);
      alert(
        "AI Restoration task submitted! You'll be notified when it's ready.",
      );
      navigate("/memories");
    }, 2000);
  };

  return (
    <div className="relative flex h-full min-h-screen w-full flex-col max-w-md mx-auto shadow-2xl bg-gray-50 dark:bg-[#0B1121]">
      {/* Header */}
      <div className="sticky top-0 z-40 bg-white/70 dark:bg-[#0B1121]/70 backdrop-blur-xl border-b border-white/20 dark:border-white/5 px-6 py-4 pt-12 flex items-center justify-between">
        <Link
          to="/dashboard"
          className="flex size-10 items-center justify-center rounded-full hover:bg-black/5 dark:hover:bg-white/10 transition-colors"
        >
          <span className="material-symbols-outlined text-slate-900 dark:text-white">
            arrow_back_ios_new
          </span>
        </Link>
        <div className="text-center">
          <h1 className="font-bold text-lg tracking-tight dark:text-white">
            Aevum
          </h1>
          <p className="text-[10px] font-medium text-slate-500 dark:text-slate-400 uppercase tracking-widest">
            AI Restoration
          </p>
        </div>
        <button className="flex size-10 items-center justify-center rounded-full hover:bg-black/5 dark:hover:bg-white/10 transition-colors">
          <span className="material-symbols-outlined text-slate-900 dark:text-white">
            ios_share
          </span>
        </button>
      </div>

      {/* Content */}
      <div className="flex-1 px-5 py-6 space-y-6 pb-32">
        {/* Before/After Comparison */}
        <div className="relative group">
          <div className="relative h-[400px] rounded-3xl overflow-hidden shadow-2xl shadow-indigo-500/20 dark:shadow-indigo-900/20">
            {/* Before Image (Full) */}
            <div
              className="absolute inset-0 bg-cover bg-center"
              style={{
                backgroundImage: `url('https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?auto=format&fit=crop&w=800')`,
                filter: "grayscale(100%) contrast(1.2) sepia(0.3)",
              }}
            >
              <span className="absolute top-4 left-4 bg-black/60 backdrop-blur-md text-white px-3 py-1 rounded-full text-xs font-bold border border-white/10">
                Before
              </span>
            </div>

            {/* After Image (Clipped) */}
            <div
              className="absolute inset-0 bg-cover bg-center"
              style={{
                backgroundImage: `url('https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?auto=format&fit=crop&w=800')`,
                clipPath: `inset(0 ${100 - sliderPosition}% 0 0)`,
                borderRight: "2px solid rgba(255, 255, 255, 0.8)",
              }}
            >
              <span className="absolute top-4 right-4 bg-indigo-600/90 backdrop-blur-md text-white px-3 py-1 rounded-full text-xs font-bold shadow-lg">
                After
              </span>
            </div>

            {/* Slider Handle */}
            <div
              className="absolute top-0 bottom-0 w-[2px] bg-white z-20"
              style={{ left: `${sliderPosition}%` }}
            >
              <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-10 h-10 bg-white rounded-full flex items-center justify-center shadow-lg text-indigo-500">
                <span className="material-symbols-outlined text-xl">
                  compare_arrows
                </span>
              </div>
            </div>

            {/* Invisible Range Input */}
            <input
              type="range"
              min="0"
              max="100"
              value={sliderPosition}
              onChange={handleSliderChange}
              className="absolute inset-0 w-full h-full opacity-0 cursor-ew-resize z-30"
            />
          </div>

          <div className="flex justify-between mt-3 px-2">
            <p className="text-xs text-slate-500 dark:text-slate-400 font-medium">
              Original
            </p>
            <p className="text-xs font-bold text-indigo-500">Enhanced Result</p>
          </div>
        </div>

        {/* Section Header */}
        <div className="flex items-center gap-2 mt-8">
          <span className="material-symbols-outlined text-indigo-500 text-xl">
            tune
          </span>
          <h2 className="text-lg font-bold text-slate-900 dark:text-white">
            Restoration Controls
          </h2>
        </div>

        {/* Control Cards Grid */}
        <div className="grid grid-cols-2 gap-4">
          {/* Colorize */}
          <ControlCard
            icon="palette"
            iconColor="indigo"
            title="Colorize"
            description="Add natural colors to B&W photos"
            checked={colorize}
            onChange={() => setColorize(!colorize)}
          />

          {/* Sharpen */}
          <ControlCard
            icon="shutter_speed"
            iconColor="blue"
            title="Sharpen"
            description="Enhance details and remove blur"
            checked={sharpen}
            onChange={() => setSharpen(!sharpen)}
          />

          {/* Repair Scratches (Full Width) */}
          <div className="col-span-2 glass-card p-4 rounded-3xl flex items-center justify-between relative overflow-hidden group">
            <div className="absolute inset-0 bg-gradient-to-r from-emerald-500/10 to-teal-500/10 dark:from-emerald-500/20 dark:to-teal-500/20 opacity-0 group-hover:opacity-100 transition-opacity" />
            <div className="flex items-center gap-4 relative z-10">
              <div className="p-2.5 rounded-xl bg-emerald-100 dark:bg-emerald-900/40 text-emerald-600 dark:text-emerald-400">
                <span className="material-symbols-outlined text-2xl">
                  healing
                </span>
              </div>
              <div>
                <h3 className="font-bold text-slate-900 dark:text-white">
                  Repair Scratches
                </h3>
                <p className="text-[11px] text-slate-500 dark:text-slate-400">
                  Fix tears, dust and damage
                </p>
              </div>
            </div>
            <Toggle
              checked={repair}
              onChange={() => setRepair(!repair)}
              color="emerald"
            />
          </div>
        </div>

        {/* Save Button */}
        <button
          onClick={handleSave}
          disabled={isProcessing}
          className="w-full mt-6 bg-slate-900 dark:bg-white text-white dark:text-slate-900 py-4 px-6 rounded-2xl font-bold shadow-lg shadow-indigo-500/20 active:scale-[0.98] transition-all flex items-center justify-center gap-3 group disabled:opacity-70"
        >
          {isProcessing ? (
            <span className="material-symbols-outlined animate-spin text-xl">
              sync
            </span>
          ) : (
            <span className="material-symbols-outlined text-xl">download</span>
          )}
          <span>{isProcessing ? "Processing..." : "Save Enhanced Photo"}</span>
        </button>
      </div>

      <BottomNav />
    </div>
  );
}

// Control Card Component
function ControlCard({
  icon,
  iconColor,
  title,
  description,
  checked,
  onChange,
}) {
  const colorClasses = {
    indigo: {
      bg: "bg-indigo-100 dark:bg-indigo-900/40",
      text: "text-indigo-600 dark:text-indigo-400",
      gradient:
        "from-indigo-500/10 to-purple-500/10 dark:from-indigo-500/20 dark:to-purple-500/20",
    },
    blue: {
      bg: "bg-blue-100 dark:bg-blue-900/40",
      text: "text-blue-600 dark:text-blue-400",
      gradient:
        "from-blue-500/10 to-cyan-500/10 dark:from-blue-500/20 dark:to-cyan-500/20",
    },
  };

  const colors = colorClasses[iconColor] || colorClasses.indigo;

  return (
    <div className="glass-card p-4 rounded-3xl flex flex-col justify-between h-40 relative overflow-hidden group">
      <div
        className={`absolute inset-0 bg-gradient-to-br ${colors.gradient} opacity-0 group-hover:opacity-100 transition-opacity`}
      />
      <div className="relative z-10 flex justify-between items-start">
        <div className={`p-2.5 rounded-xl ${colors.bg} ${colors.text}`}>
          <span className="material-symbols-outlined text-2xl">{icon}</span>
        </div>
        <Toggle checked={checked} onChange={onChange} color={iconColor} />
      </div>
      <div className="relative z-10">
        <h3 className="font-bold text-slate-900 dark:text-white">{title}</h3>
        <p className="text-[11px] text-slate-500 dark:text-slate-400 leading-tight mt-1">
          {description}
        </p>
      </div>
    </div>
  );
}

// Toggle Component
function Toggle({ checked, onChange, color = "indigo" }) {
  const colorClasses = {
    indigo: "bg-indigo-500",
    blue: "bg-blue-500",
    emerald: "bg-emerald-500",
  };

  return (
    <button
      onClick={onChange}
      className={`relative w-10 h-5 rounded-full transition-colors ${checked ? colorClasses[color] : "bg-gray-300 dark:bg-gray-600"}`}
    >
      <div
        className={`absolute top-0.5 w-4 h-4 rounded-full bg-white shadow transition-transform ${checked ? "right-0.5" : "left-0.5"}`}
      />
    </button>
  );
}

export default RestorationScreen;
