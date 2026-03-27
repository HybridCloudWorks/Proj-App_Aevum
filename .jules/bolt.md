## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.

## 2024-03-27 - Fast binary-to-string conversion in browser
**Learning:** `for` loops converting bytes to characters via `String.fromCharCode` and concatenating strings (`+=`) can create severe $O(n)$ allocation penalties when extracting metadata (like EXIF) from binary streams like `ArrayBuffer` or `DataView`.
**Action:** Use native `TextDecoder` (e.g., `new TextDecoder().decode(uint8Array)`) which relies on optimized C++/Rust implementations and skips intermediate JS string allocations. Be careful to apply `byteOffset` when constructing a `Uint8Array` view from a `DataView`'s underlying buffer.
