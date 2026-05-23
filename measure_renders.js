// A simple simulation to demonstrate the unmounts/resubscribes
let unmountsBefore = 0;
let resubscribesBefore = 0;

let unmountsAfter = 0;
let resubscribesAfter = 0;

function simulateBefore(userChanges, currentFamilyChanges) {
    let currentFamily = null;
    let prevUser = null;
    let prevFamily = null;

    for (let i = 0; i < 100; i++) {
        const user = userChanges[i];
        const fam = currentFamilyChanges[i];

        if (user !== prevUser || fam !== prevFamily) {
            if (prevUser || prevFamily) unmountsBefore++;
            resubscribesBefore++;
        }
        prevUser = user;
        prevFamily = fam;
    }
}

function simulateAfter(userChanges, currentFamilyChanges) {
    let currentFamily = null;
    let prevUserId = null;

    for (let i = 0; i < 100; i++) {
        const user = userChanges[i];
        const userId = user ? user.uid : null;

        if (userId !== prevUserId) {
            if (prevUserId) unmountsAfter++;
            resubscribesAfter++;
        }
        prevUserId = userId;
    }
}

const users = Array(100).fill({ uid: '123' }).map(u => ({...u})); // new object references
const families = Array(100).fill({ id: 'abc' }).map(f => ({...f})); // new object references

simulateBefore(users, families);
simulateAfter(users, families);

console.log(`Before optimization - Redundant resubscribes: ${resubscribesBefore - 1}`);
console.log(`After optimization - Redundant resubscribes: ${resubscribesAfter - 1}`);
