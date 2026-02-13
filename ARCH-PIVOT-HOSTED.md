# ARCH-PIVOT: 100% Firebase Hosted Solution Analysis

**Objective**: Determine if Aevum should move away from the "Hybrid/VPS" model to a purely cloud-managed environment.

## 📊 Comparison: Hybrid vs. 100% Hosted

| Feature         | Current: Hybrid (VPS + Firebase) | Pivot: 100% Hosted (Firebase Only)       |
| :-------------- | :------------------------------- | :--------------------------------------- |
| **Maintenance** | High (Managed K8s, SOPS, ArgoCD) | Low (Zero-Infra management)              |
| **Logic Layer** | n8n / Python API on VPS          | Firebase Cloud Functions                 |
| **AI / Search** | Qdrant Vector DB (Self-hosted)   | Vertex AI / Firebase Extension           |
| **Automation**  | Self-hosted n8n (Free execution) | Cloud Functions / Zapier (Paid per exec) |
| **Privacy**     | Owned "Power Zone" sovereignty   | Total dependence on Google Cloud         |
| **Scaling**     | Manual scaling/provisioning      | Autoscale out-of-the-box                 |

---

## 🛡️ Persona Critiques

### 👨‍💻 GDEF (Firebase Expert): "Lean into the Cloud"

> "Absolutely possible. We can replace the 'Power Zone' with **Firebase App Hosting** for the web tier and **Vertex AI for Firebase** (Gemini) for the heritage storytelling. This eliminates the 'Kubeconfig' security headache mentioned in the AGENTS.md audit."

### ⚙️ CKA (Infra Architect): "Beware the Invisible Ceiling"

> "While Firebase is easier, a 100% hosted model means our **Heritage Search** logic becomes a billable event every time a user pans the map. Qdrant on a flat-rate VPS is 'free compute'. If our tree growth scales to millions of nodes, those Cloud Function bills will add up."

### 📱 MAD (Mobile Developer): "Unified SDK Advantage"

> "Firebase is the native language of high-end mobile apps. Using a single SDK for Auth, Data, and AI (Genkit) makes for a leaner, faster mobile experience with better offline reconciliation."

---

## 🎯 The "Plug" Recommendation

**Can this be 100% Firebase?**
**Yes.** We would leverage:

1.  **Firebase Genkit**: For the AI Chronicles and Identity Matching.
2.  **Firebase Data Connect**: For the complex relational mapping of the Family Tree (PostgreSQL-backed but managed).
3.  **Firebase App Hosting**: For the Next.js/Vite frontend.

**The Hybrid Benefit (Keep the VPS)**:
Keep the VPS ONLY if you plan to run **n8n** for deep "Heritage Data Mining" from external sites or if you want to host private 3D models for **visionOS** that exceed Cloud Storage cost-efficiency.

## 🏁 Decision Point

- **Option A (Simplified)**: Move to 100% Firebase. Clean, fast, but higher "per-use" cost.
- **Option B (Hybrid)**: Use Firebase for 90% of the app (Mobile/UI) and the VPS only for "Deep Compute" (Vector DBs / Heavy Automation).
