## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.

## 2024-05-18 - Avoid micro-optimizations that sacrifice readability and safety
**Learning:** Mutating an object returned by `doc.data()` from Firebase SDK to avoid spread syntax (e.g., `const data = doc.data(); data.id = doc.id;`) is a micro-optimization that provides zero measurable performance impact, degrades code readability, and relies on unsafe undocumented behavior.
**Action:** Do not implement this mutation-based optimization. Focus on larger performance wins like batching requests, caching, indexing, or reducing re-renders. Avoid modifying `firestore.js` or data mapping functions unless fixing an N+1 query problem.
