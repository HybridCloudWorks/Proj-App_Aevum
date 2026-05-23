// Simplified benchmark to measure the difference
import { performance } from 'perf_hooks';

// Setup Mock Data
const user = { uid: "user-123" };
const userChanges = Array(100).fill(user).map(u => ({...u})); // Object references
const currentFamily = { id: "family-abc" };
const currentFamilyChanges = Array(100).fill(currentFamily).map(f => ({...f})); // Object references

// The simulated React hook rendering
function simulateHookBefore(user, currentFamily) {
    let renders = 0;
    let resubscribesFamilies = 0;
    let resubscribesMembers = 0;

    let prevUser = null;
    let prevCurrentFamily = null;

    // Simulate 100 renders
    for (let i = 0; i < 100; i++) {
        const u = userChanges[i];
        const f = currentFamilyChanges[i];

        // useEffect 1: Subscribe to user's families
        if (u !== prevUser || f !== prevCurrentFamily) {
            resubscribesFamilies++;
        }

        // useEffect 2: Subscribe to current family's members
        if (f !== prevCurrentFamily) {
            resubscribesMembers++;
        }

        prevUser = u;
        prevCurrentFamily = f;
        renders++;
    }

    return { resubscribesFamilies, resubscribesMembers };
}

function simulateHookAfter(user, currentFamily) {
    let renders = 0;
    let resubscribesFamilies = 0;
    let resubscribesMembers = 0;

    let prevUserId = null;
    let prevCurrentFamilyId = null;

    // Simulate 100 renders
    for (let i = 0; i < 100; i++) {
        const u = userChanges[i];
        const f = currentFamilyChanges[i];

        const userId = u ? u.uid : null;
        const currentFamilyId = f ? f.id : null;

        // useEffect 1: Subscribe to user's families
        if (userId !== prevUserId || currentFamilyId !== prevCurrentFamilyId) {
            resubscribesFamilies++;
        }

        // useEffect 2: Subscribe to current family's members
        if (currentFamilyId !== prevCurrentFamilyId) {
            resubscribesMembers++;
        }

        prevUserId = userId;
        prevCurrentFamilyId = currentFamilyId;
        renders++;
    }

    return { resubscribesFamilies, resubscribesMembers };
}

console.log("Running Simulation (100 renders)...");

const before = simulateHookBefore();
console.log("Before Optimization:");
console.log(`- Redundant Resubscriptions (Families): ${before.resubscribesFamilies - 1}`);
console.log(`- Redundant Resubscriptions (Members): ${before.resubscribesMembers - 1}`);

const after = simulateHookAfter();
console.log("\nAfter Optimization:");
console.log(`- Redundant Resubscriptions (Families): ${after.resubscribesFamilies - 1}`);
console.log(`- Redundant Resubscriptions (Members): ${after.resubscribesMembers - 1}`);
