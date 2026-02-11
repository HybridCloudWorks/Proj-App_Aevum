# FRAMEWORK-PIVOT: Flutter vs. Capacitor (React)

**Objective**: Determine if the Aevum project should pivot from its current Capacitor-wrapped Web architecture to a pure Flutter native architecture.

## ⚖️ Tactical Comparison

| Aspect               | Current: Capacitor + React              | Pivot: Pure Flutter                          |
| :------------------- | :-------------------------------------- | :------------------------------------------- |
| **Logic Layer**      | JavaScript / TypeScript                 | Dart                                         |
| **UI Engine**        | WebView (HTML/Tailwind)                 | Skia / Impeller (Native Canvas)              |
| **Stitch Synergy**   | **High**: Uses the 57 folders directly. | **Low**: Requires manual Widget translation. |
| **Firebase Support** | Excellent (via Web/JavaScript SDK)      | **Natural**: Google-built (FlutterFire).     |
| **visionOS**         | Compatibility Mode (Web shell)          | Native Spatial support (Experimental/Rapid). |
| **Perf / Feel**      | 8/10 (High dependency on Vite speed)    | 10/10 (Smooth 60/120fps native)              |

---

## 🛡️ Persona Critiques

### 👨‍💻 MAD (Mobile App Dev): "The Native Purity Test"

> "Flutter is 'natural' because it handles 3D models and spatial UI (visionOS) much better than a WebView. If Aevum wants a premium 'Apple-like' feel for the Heritage Map, Flutter is the winner. However, you'll have to basically 're-read' the 57 Stitch folders and code them again in Dart."

### ⚙️ FED (Frontend Engineer): "The Time-to-Market Trap"

> "We already have 57 screens mapped and ready in HTML. Capacitor lets us ship tomorrow. If we move to Flutter, we add 4-6 weeks of UI translation. Flutter isn't just a language; it's a completely different UI paradigm."

---

## 🎯 The Recommendation

### Choose **Capacitor (Stay)** if:

- You want to use the **57 Stitch Screens** as they are.
- You want the fastest path to a working MVP on Android/iOS/Web.
- You prefer the CSS-based design system you've already established.

### Choose **Flutter (Pivot)** if:

- Performance and "Physicality" (smooth scrolling, custom animations) are your #1 priority.
- You are planning a deep **visionOS Integration** that requires 3D/reality-kit hooks (vibrant 3D trees).
- You want the most "Natural" Firebase experience.

## 🏁 Technical Note on "Naturalness"

The user is right: Flutter + Firebase + visionOS is a powerful Google/Apple hybrid stack. The only "friction" is the translation of the existing HTML/CSS assets.
