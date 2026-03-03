1. **Optimize DashboardScreen.jsx Hooks**:
   - Refactor the single `useEffect` in `apps/web/src/screens/onboarding/DashboardScreen.jsx` into three distinct `useEffect` hooks.
   - The first hook handles `subscribeToFamilies` and `subscribeToAITasks` dependent on `user.uid`.
   - The second hook handles `subscribeToFamilyMembers` dependent on `families[0]?.id`.
   - The third hook handles `subscribeToMediaItems` dependent on `families[0]?.id`.
   - This ensures clean unsubscription whenever the dependencies change, preventing memory leaks, stale data, and excessive re-subscriptions when `families` updates.

2. **Pre-commit Steps**:
   - Run linter (`npm run lint` or `eslint`).
   - Run tests if applicable (`npm test`).
   - Format code using Prettier (`npm run format`).

3. **Submit PR**:
   - Title: "⚡ Bolt: [Refactor Dashboard Hooks for Performance & Memory Cleanup]"
   - Description with:
     * 💡 What: Split single `useEffect` into three distinct hooks.
     * 🎯 Why: Solves potential memory leaks and redundant re-subscriptions caused by bundling multiple subscriptions into one effect that fires whenever `families` updates.
     * 📊 Impact: Cleaner unsubscription handling, better performance, fewer unnecessary network requests when `families` array length changes.
     * 🔬 Measurement: Verify dashboard loads correctly and subscriptions correctly unmount when leaving the screen.
