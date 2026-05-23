## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.
## 2024-03-21 - Extract primitives as useEffect dependencies
**Learning:** Extracting primitive values from objects (e.g., `user?.uid`) and using them as `useEffect` dependencies, combined with functional state updates (`setState(prev => prev || val)`), effectively prevents O(N) redundant React unmounts/re-subscriptions when dealing with real-time data sources like Firestore.
**Action:** When working on React components that subscribe to real-time data, always extract necessary primitive IDs before the `useEffect` block and use those primitives instead of full object references as dependencies.
