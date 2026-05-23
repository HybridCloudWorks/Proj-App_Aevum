## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.

## 2026-04-22 - Incremental Progress Tracking in uploadMultiplePhotos
**Learning:** Recalculating totals from an array using `.reduce()` inside frequently firing callbacks (like progress events) leads to (N)$ complexity per event, resulting in (N^2)$ overall complexity for multiple concurrent tasks. Incremental updates with a running sum reduce this to (1)$ per event.
**Action:** Always prefer incremental updates for aggregate values in high-frequency event listeners.
