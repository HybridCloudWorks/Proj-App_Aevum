## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.

## 2024-05-08 - Use functional state updates for subscriptions
**Learning:** In React components with real-time subscriptions, passing state variables directly to handlers or setting state based on current state (like `setCurrentFamily(currentFamily || data[0])`) forces the state variable into the dependency array, causing O(N) redundant unmounts and re-subscriptions.
**Action:** Use functional state updates (e.g., `setFoo(prev => prev || newVal)`) inside `useEffect` subscription callbacks. This allows removing the state variable from the dependency array completely.
