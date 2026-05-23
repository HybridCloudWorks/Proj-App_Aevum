## 2025-04-08 - Redundant Firestore Re-subscriptions on Object Reference Changes
**Learning:** React `useEffect` hooks that subscribe to Firestore data often mistakenly include full object references (like `user` or `currentFamily`) in their dependency arrays. This causes the hook to unnecessarily tear down and recreate the Firestore listener every time any property on the object changes, even if the relevant ID (`uid` or `familyId`) remains identical.
**Action:** Always extract the primitive ID variables (e.g., `const userId = user?.uid; const currentFamilyId = currentFamily?.id;`) and use those primitives in the `useEffect` dependency arrays. Additionally, avoid placing state variables in the dependency array by utilizing functional state updates (e.g., `setCurrentFamily((prev) => prev ? prev : data[0])`) within the listener callbacks.
## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.

## 2024-04-15 - Fast EXIF binary-to-string parsing
**Learning:** Manual string concatenation using `String.fromCharCode` on a DataView character by character is extremely slow (~500ms for 10k iterations of 1k length strings) due to JS string immutability and memory allocation overhead.
**Action:** Use a global `TextDecoder` instance coupled with `TextDecoder.decode()` on a `Uint8Array` view of the `DataView` instead. This is nearly 25x faster (~20ms for the same load) and eliminates significant JS string instantiation overhead.
## 2024-04-17 - Optimize EXIF string decoding performance
**Learning:** Manual string concatenation (`str += String.fromCharCode(...)`) over a `DataView` is significantly slower than using a `TextDecoder` initialized with the "ascii" encoding on a `Uint8Array` view, especially when extracting numerous EXIF tags.
**Action:** When performing binary-to-string conversions (e.g. metadata extraction), always leverage `TextDecoder` operating directly on typed array views to avoid garbage collection pressure from string concatenation inside loops. Remember to create a single global `TextDecoder` instance rather than instantiating it per invocation to maximize performance gains.
## 2026-05-06 - Deduplicate Concurrent API Calls with Promise Caching
**Learning:** When optimizing N+1 API patterns, caching the resolved value only benefits subsequent calls. If multiple requests occur concurrently, they will all trigger the same API call because the cache is empty until the first resolution.
**Action:** Cache the **Promise** itself. This ensures all concurrent requests for the same resource await the same underlying operation, providing true deduplication and reducing backend load.
## 2024-05-08 - Use functional state updates for subscriptions
**Learning:** In React components with real-time subscriptions, passing state variables directly to handlers or setting state based on current state (like `setCurrentFamily(currentFamily || data[0])`) forces the state variable into the dependency array, causing O(N) redundant unmounts and re-subscriptions.
**Action:** Use functional state updates (e.g., `setFoo(prev => prev || newVal)`) inside `useEffect` subscription callbacks. This allows removing the state variable from the dependency array completely.
## 2024-03-21 - Extract primitives as useEffect dependencies
**Learning:** Extracting primitive values from objects (e.g., `user?.uid`) and using them as `useEffect` dependencies, combined with functional state updates (`setState(prev => prev || val)`), effectively prevents O(N) redundant React unmounts/re-subscriptions when dealing with real-time data sources like Firestore.
**Action:** When working on React components that subscribe to real-time data, always extract necessary primitive IDs before the `useEffect` block and use those primitives instead of full object references as dependencies.
