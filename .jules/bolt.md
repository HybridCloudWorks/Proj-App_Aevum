## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.
