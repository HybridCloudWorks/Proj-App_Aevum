## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.
## 2024-03-24 - Prevent O(N) recalculations on progress updates
**Learning:** Functions that track overall progress across multiple concurrent tasks (like `uploadMultiplePhotos`) can suffer from severe performance degradation if they recalculate the total using `.reduce()` on every single individual progress event, effectively making it an O(N) operation per event.
**Action:** Use an incremental running sum variable to keep track of the total progress. Subtract the previous individual progress and add the new one to update the total progress in O(1) time.
