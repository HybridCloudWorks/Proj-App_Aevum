
## $(date +%Y-%m-%d) - Array Instantiation and Memoization in React
**Learning:** A common performance anti-pattern found in this repository's React frontend (`apps/web/src`) is the creation of static arrays and fallback data objects inside the render function of components (like `featuredMemories` in `MemoriesScreen`). These unmemoized values cause unnecessary re-creation of arrays and force re-renders for any child components receiving them.
**Action:** When reviewing React components for performance, always look for inline data structures or array definitions within the component body. If they are purely static, move them outside the component. If they depend on props or state (e.g., as fallbacks), use `useMemo` to preserve referential equality across renders.
