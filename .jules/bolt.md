## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.
## 2025-04-04 - [Use TextDecoder for EXIF ASCII strings]
**Learning:** Manual string concatenation using `String.fromCharCode` in a `for` loop over a `DataView` is an O(n) memory allocation bottleneck, particularly when parsing EXIF data from binary array buffers.
**Action:** Use `TextDecoder` with a `Uint8Array` view of the underlying `ArrayBuffer` (accounting for `dataView.byteOffset`) to decode ASCII/UTF-8 strings efficiently, pushing the decoding down to native bindings without extra allocations.
