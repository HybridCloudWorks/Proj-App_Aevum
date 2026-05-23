// Simplified benchmark to measure the difference
import { performance } from 'perf_hooks';

// Setup Mock Data
const user = { uid: "user-123" };
const userChanges = Array(100).fill(user).map(u => ({...u})); // Object references

// The simulated React hook rendering
function simulateHookBefore(user) {
    let renders = 0;
    let hookRecreations = 0;

    let prevUser = null;

    // Simulate 100 renders
    for (let i = 0; i < 100; i++) {
        const u = userChanges[i];

        // useCallback dependency array
        if (u !== prevUser) {
            hookRecreations++;
        }

        prevUser = u;
        renders++;
    }

    return { hookRecreations };
}

function simulateHookAfter(user) {
    let renders = 0;
    let hookRecreations = 0;

    let prevUserId = null;

    // Simulate 100 renders
    for (let i = 0; i < 100; i++) {
        const u = userChanges[i];

        const userId = u ? u.uid : null;

        // useCallback dependency array
        if (userId !== prevUserId) {
            hookRecreations++;
        }

        prevUserId = userId;
        renders++;
    }

    return { hookRecreations };
}

console.log("Running Simulation (100 renders)...");

const before = simulateHookBefore();
console.log("Before Optimization:");
console.log(`- Redundant hook recreations: ${before.hookRecreations - 1}`);

const after = simulateHookAfter();
console.log("\nAfter Optimization:");
console.log(`- Redundant hook recreations: ${after.hookRecreations - 1}`);
