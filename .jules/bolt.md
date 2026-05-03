## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.
## 2024-05-03 - Prevent redundant Firestore re-subscriptions in hooks
**Learning:** React hooks subscribing to Firestore real-time queries often unnecessarily tear down and recreate subscriptions when the dependency array contains full object references (like `user` or `currentFamily`) instead of their primitive IDs, causing performance issues.
**Action:** Extract primitive IDs (e.g., `const uid = user?.uid`) to use in `useEffect` dependency arrays, and use functional state updates (e.g., `setState(prev => prev ? prev : data[0])`) to avoid depending on state variables inside subscription callbacks.
