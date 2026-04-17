## 2024-03-20 - Prevent redundant Firestore re-subscriptions
**Learning:** React components subscribing to real-time data sources (like Firestore or WebSockets) often unnecessarily tear down and recreate their subscriptions when arrays or objects are used directly as `useEffect` dependencies.
**Action:** When a subscription requires an ID from an array (e.g., `families[0].id`), extract the specific primitive ID into a variable and use *that primitive* as the `useEffect` dependency, rather than the entire array reference.

## 2024-04-17 - Optimize EXIF string decoding performance
**Learning:** Manual string concatenation (`str += String.fromCharCode(...)`) over a `DataView` is significantly slower than using a `TextDecoder` initialized with the "ascii" encoding on a `Uint8Array` view, especially when extracting numerous EXIF tags.
**Action:** When performing binary-to-string conversions (e.g. metadata extraction), always leverage `TextDecoder` operating directly on typed array views to avoid garbage collection pressure from string concatenation inside loops. Remember to create a single global `TextDecoder` instance rather than instantiating it per invocation to maximize performance gains.
