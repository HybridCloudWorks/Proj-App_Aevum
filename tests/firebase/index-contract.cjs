const assert = require("node:assert/strict");
const fs = require("node:fs");

const definition = JSON.parse(
  fs.readFileSync("firestore.indexes.json", "utf8"),
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

assert.equal(
  definition.indexes.some((index) => index.collectionGroup === "memories"),
  false,
  "Legacy memories indexes must not return",
);

console.log("Canonical Firestore index contract passed.");
