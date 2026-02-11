import type { CapacitorConfig } from "@capacitor/cli";

const config: CapacitorConfig = {
  appId: "app.aevum.heritage",
  appName: "Aevum",
  webDir: "dist",
  server: {
    androidScheme: "https",
  },
  plugins: {
    StatusBar: {
      style: "dark",
      backgroundColor: "#0f151b",
    },
    SplashScreen: {
      launchShowDuration: 2000,
      launchAutoHide: true,
      backgroundColor: "#0f151b",
      androidScaleType: "CENTER_CROP",
      showSpinner: false,
    },
    Camera: {
      permissions: ["camera", "photos"],
    },
    Keyboard: {
      resize: "body",
      style: "dark",
      resizeOnFullScreen: true,
    },
    Haptics: {},
  },
  ios: {
    contentInset: "automatic",
    preferredContentMode: "mobile",
  },
  android: {
    backgroundColor: "#0f151b",
    allowMixedContent: true,
  },
};

export default config;
