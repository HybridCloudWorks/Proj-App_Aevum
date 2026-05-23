## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.

## 2026-05-06 - Deduplicate Concurrent API Calls with Promise Caching
**Learning:** When optimizing N+1 API patterns, caching the resolved value only benefits subsequent calls. If multiple requests occur concurrently, they will all trigger the same API call because the cache is empty until the first resolution.
**Action:** Cache the **Promise** itself. This ensures all concurrent requests for the same resource await the same underlying operation, providing true deduplication and reducing backend load.
## 2024-05-08 - Use functional state updates for subscriptions
**Learning:** In React components with real-time subscriptions, passing state variables directly to handlers or setting state based on current state (like `setCurrentFamily(currentFamily || data[0])`) forces the state variable into the dependency array, causing O(N) redundant unmounts and re-subscriptions.
**Action:** Use functional state updates (e.g., `setFoo(prev => prev || newVal)`) inside `useEffect` subscription callbacks. This allows removing the state variable from the dependency array completely.
## 2024-03-21 - Extract primitives as useEffect dependencies
**Learning:** Extracting primitive values from objects (e.g., `user?.uid`) and using them as `useEffect` dependencies, combined with functional state updates (`setState(prev => prev || val)`), effectively prevents O(N) redundant React unmounts/re-subscriptions when dealing with real-time data sources like Firestore.
**Action:** When working on React components that subscribe to real-time data, always extract necessary primitive IDs before the `useEffect` block and use those primitives instead of full object references as dependencies.
