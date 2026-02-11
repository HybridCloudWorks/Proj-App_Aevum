const fs = require("fs");
const path = require("path");
const https = require("https");

const screensData = JSON.parse(
  fs.readFileSync(
    "C:/Users/saulp/.gemini/antigravity/brain/66aeacf9-1e21-4c5f-8617-c24484cb4191/.system_generated/steps/35/output.txt",
    "utf8",
  ),
);
const inventory = fs.readFileSync(
  "c:/Users/saulp/AppData/Workspace/MVP-Aevum/screens-inventory.md",
  "utf8",
);

const idToCategory = {};
const lines = inventory.split("\n");
lines.forEach((line) => {
  const match = line.match(/`([a-f0-9]+)`\s*\|\s*([^|]+)\|\s*([^| \n\r]+)/);
  if (match) {
    idToCategory[match[1]] = match[3].trim();
  }
});

const categoryMap = {
  welcome: "onboarding",
  auth: "auth",
  "family-tree": "family-tree",
  memories: "memories",
  "heritage-map": "heritage-map",
  "ai-features": "ai-features",
  identity: "identity",
  onboarding: "onboarding",
  admin: "admin",
  catalog: "catalog",
  firebase: "firebase",
  settings: "settings",
  "design-system": "design-system",
  launch: "launch",
};

async function download(url, dest) {
  return new Promise((resolve, reject) => {
    const file = fs.createWriteStream(dest);
    https
      .get(url, (response) => {
        response.pipe(file);
        file.on("finish", () => {
          file.close(resolve);
        });
      })
      .on("error", (err) => {
        fs.unlink(dest, () => reject(err));
      });
  });
}

async function run() {
  for (const screen of screensData.screens) {
    const id = screen.name.split("/").pop();
    const categoryKey = idToCategory[id] || "other";
    const category = categoryMap[categoryKey] || "other";
    const dir = path.join(
      "c:/Users/saulp/AppData/Workspace/MVP-Aevum/docs/baselines",
      category,
    );

    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }

    const filename = `${id}_${screen.title.replace(/[^a-z0-9]/gi, "_").toLowerCase()}.png`;
    const dest = path.join(dir, filename);

    console.log(`Downloading ${screen.title} to ${dest}...`);
    try {
      await download(screen.screenshot.downloadUrl, dest);
    } catch (err) {
      console.error(`Failed to download ${screen.title}: ${err.message}`);
    }
  }
  console.log("Done.");
}

run();
