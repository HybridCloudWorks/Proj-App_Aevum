## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.
## 2026-04-09 - Optimize binary to string parsing in javascript
**Learning:** Manual character-by-character loops (e.g. `String.fromCharCode`) over large arrays/buffers are surprisingly slow compared to native APIs like `TextDecoder`.
**Action:** Always use `TextDecoder` applied to a typed array view (like `Uint8Array`) when converting binary data (like EXIF ASCII strings) to JavaScript strings. Pay close attention to underlying buffer offsets when working with `DataView` slices.
