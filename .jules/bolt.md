## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.

## 2024-05-09 - Deduplicate getDownloadURL promises in Storage listings
**Learning:** Functions like `listFamilyPhotos` execute `getDownloadURL` on an array of references, resulting in N+1 network calls. Modifying the return signature to lazy-load these URLs constitutes a breaking change.
**Action:** Instead of altering the public API, wrap `getDownloadURL` calls with an internal cache (`downloadUrlCache`) that memoizes the returning *Promises* (not just the resolved strings) bounded by a FIFO Map. This satisfies the N+1 problem by deduplicating overlapping calls without breaking backward compatibility.
