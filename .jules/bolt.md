## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.

## 2026-05-06 - Deduplicate Concurrent API Calls with Promise Caching
**Learning:** When optimizing N+1 API patterns, caching the resolved value only benefits subsequent calls. If multiple requests occur concurrently, they will all trigger the same API call because the cache is empty until the first resolution.
**Action:** Cache the **Promise** itself. This ensures all concurrent requests for the same resource await the same underlying operation, providing true deduplication and reducing backend load.
