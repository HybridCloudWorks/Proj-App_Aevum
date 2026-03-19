## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.

## 2024-03-21 - Optimize inline arrays in functional components
**Learning:** A common performance anti-pattern in the `apps/web` React codebase is the inline instantiation of static arrays, fallback data, and unmemoized lists within functional components, which should be moved outside the component or wrapped in `useMemo`.
**Action:** Extract inline arrays into constants outside the component or use `useMemo` when rendering mapped components to prevent recreating identical array instances on every render.
