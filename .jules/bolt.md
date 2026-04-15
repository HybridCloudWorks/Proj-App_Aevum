## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.

## 2024-04-15 - Fast EXIF binary-to-string parsing
**Learning:** Manual string concatenation using `String.fromCharCode` on a DataView character by character is extremely slow (~500ms for 10k iterations of 1k length strings) due to JS string immutability and memory allocation overhead.
**Action:** Use a global `TextDecoder` instance coupled with `TextDecoder.decode()` on a `Uint8Array` view of the `DataView` instead. This is nearly 25x faster (~20ms for the same load) and eliminates significant JS string instantiation overhead.
