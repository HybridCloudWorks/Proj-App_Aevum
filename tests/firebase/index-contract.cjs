const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");

const indexesPath = path.resolve(__dirname, "..", "..", "firestore.indexes.json");
const definition = JSON.parse(
  fs.readFileSync(indexesPath, "utf8"),
);

function signature(index) {
  return [
    index.collectionGroup,
    index.queryScope,
    ...index.fields.map((field) =>
      [
        field.fieldPath,
        field.order || field.arrayConfig,
      ].join(":"),
    ),
  ].join("|");
}

const actual = new Set(definition.indexes.map(signature));
const required = [
  "families|COLLECTION|collaboratorIds:CONTAINS|updatedAt:DESCENDING",
  "families|COLLECTION|ownerId:ASCENDING|updatedAt:DESCENDING",
  "media_items|COLLECTION|familyId:ASCENDING|createdAt:DESCENDING",
  "ai_tasks|COLLECTION|userId:ASCENDING|createdAt:DESCENDING",
  "ai_tasks|COLLECTION|userId:ASCENDING|status:ASCENDING|createdAt:DESCENDING",
  "albums|COLLECTION|familyId:ASCENDING|updatedAt:DESCENDING",
];

for (const expected of required) {
  assert.ok(actual.has(expected), `Missing canonical index: ${expected}`);
}

const configuredIndexes = [
  ...(definition.indexes || []),
  ...(definition.fieldOverrides || []),
];

assert.equal(
  configuredIndexes.some((entry) =>
    entry.collectionGroup === "memories" || entry.collectionId === "memories"
  ),
  false,
  "Legacy memories indexes or field overrides must not return",
);

console.log("Canonical Firestore index contract passed.");
