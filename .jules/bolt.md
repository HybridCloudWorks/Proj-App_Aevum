## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.

## 2024-05-12 - Eliminate N+1 Firebase Storage `getDownloadURL` fetching
**Learning:** Functions that map over an array of Firebase Storage references (e.g., `listAll` results) and call `getDownloadURL` on each item concurrently can easily trigger N+1 API calls. Subsequent requests for the same paths can cause redundant network overhead.
**Action:** Use an in-memory `Map`-based cache with a fixed size limit and FIFO eviction to store the Promises returned by `getDownloadURL`. This not only caches the resulting URLs but also deduplicates concurrent in-flight requests for the same path.
