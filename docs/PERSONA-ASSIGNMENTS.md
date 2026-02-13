# PERSONA ASSIGNMENTS & RESPONSIBILITIES

**Purpose**: Clear ownership and accountability for MVP fixes  
**Status**: Ready for assignment  
**Duration**: 2 weeks (Feb 13-27, 2026)  

---

## 👨‍💻 FED (Frontend & DevOps Engineer) - LEAD

**Total Effort**: 1.0 FTE (80 hours)  
**Primary Owner**: Web Application Architecture  
**Secondary**: CI/CD, monitoring, deployment  

### Week 1 Tasks

#### Day 1: Router Fix (8 hours)
- [ ] Create route registry (`applications/web/src/routes/routeConfig.js`)
- [ ] Add missing routes to App.jsx:
  - `/settings/privacy-security`
  - `/settings/restricted-profile/:section`
  - Any others referenced but not defined
- [ ] Create NotFoundScreen component
- [ ] Deploy changes and test locally
- **Deliverable**: All SettingsScreen buttons navigate successfully

#### Day 2: Error Handling (8 hours)
- [ ] Create ErrorBoundary component
- [ ] Create LoadingSpinner component
- [ ] Create ErrorBox component
- [ ] Wrap App.jsx with ErrorBoundary
- [ ] Update App.jsx Suspense to use custom loading screen
- [ ] Test that errors show helpful messages (not crashes)
- **Deliverable**: App stays functional on network errors

#### Day 3: Auth Implementation (8 hours)
- [ ] Review existing AuthContext implementation
- [ ] Add these methods:
  ```javascript
  signUp(email, password, displayName)
  signIn(email, password)
  signOut()
  resetPassword(email)
  updateProfile(displayName, photoURL)
  ```
- [ ] Wire up WelcomeScreen to real auth flow
- [ ] Add proper error messages
- [ ] Test complete auth lifecycle
- **Deliverable**: Users can sign up, sign in, reset password

#### Day 4-5: Admin Navigation (8 hours)
- [ ] Create AdminNav component (sidebar or menu)
- [ ] Add role check (admin/non-admin)
- [ ] Show admin option in DashboardScreen only for admins
- [ ] Link to `/admin` route
- [ ] Test permission checks
- **Deliverable**: Non-admins don't see admin menu

#### Day 5: Testing & Review (4 hours)
- [ ] Manual testing of all web routes
- [ ] Check for regressions
- [ ] Code review with teammates
- [ ] Document any remaining issues

### Week 2 Tasks

#### Day 6: Component Library v1 (8 hours)
- [ ] Create Button.jsx, Card.jsx, Input.jsx, Modal.jsx
- [ ] Update 5-10 screens to use new components
- [ ] Verify design consistency
- [ ] Document component API
- **Deliverable**: Reusable components in place

#### Day 7: Light Mode (8 hours)
- [ ] Create theme toggle in SettingsScreen
- [ ] Add Tailwind light mode colors
- [ ] Update all screens to support both modes
- [ ] Test readability in both modes
- **Deliverable**: App works in light and dark modes

#### Day 8: Zustand Integration (8 hours)
- [ ] Set up Zustand store for user state
- [ ] Set up Zustand store for family data
- [ ] Set up Zustand store for UI state
- [ ] Remove duplicate useState from screens
- [ ] Test data persistence
- **Deliverable**: No prop drilling, centralized state

#### Day 9: Final Testing & Optimization (8 hours)
- [ ] Run Lighthouse audit
- [ ] Optimize images and assets
- [ ] Check performance (bundle size, load time)
- [ ] Fix any accessibility violations
- [ ] Create testing checklist

#### Day 10: Documentation & Handoff (4 hours)
- [ ] Document all changes
- [ ] Create README for new components
- [ ] Create setup guide for new developers
- [ ] Prepare for TestFlight submission

---

### Daily Standup Report Template

```markdown
## FED Daily Report (Initials: ___)

**Date**: Feb __, 2026

### Completed Yesterday
- [ ] Task 1
- [ ] Task 2

### In Progress Today
- [ ] Task 1
- [ ] Task 2

### Blockers
- [ ] Blocker 1 (impact, mitigation)

### On Track? YES / NO / AT-RISK
- Reason: ...
```

---

## 📱 MAD (Mobile App Developer) - PARTNER

**Total Effort**: 0.8 FTE (64 hours)  
**Primary Owner**: Mobile Navigation & Deep Linking  
**Secondary**: State management, testing  

### Week 1 Tasks

#### Day 1-2: GoRouter Migration (16 hours)
- [ ] Install GoRouter package
- [ ] Create `lib/navigation/app_router.dart` with:
  - Top-level routes (auth, dashboard, etc.)
  - Nested routes (dashboard → tree, memories, etc.)
  - Admin subroutes with role guards
  - Deep link handlers
- [ ] Replace all `Navigator.pushNamed()` with `context.push()`
- [ ] Test all 39 routes are reachable
- [ ] Verify back button works on all screens
- **Deliverable**: GoRouter fully implemented

#### Day 3: Deep Linking Setup (8 hours)
- [ ] Configure AndroidManifest.xml:
  ```xml
  <activity android:name=".MainActivity">
    <intent-filter>
      <action android:name="android.intent.action.VIEW" />
      <category android:name="android.intent.category.DEFAULT" />
      <category android:name="android.intent.category.BROWSABLE" />
      <data android:scheme="aevum" android:host="app" />
    </intent-filter>
  </activity>
  ```
- [ ] Configure iOS Associated Domains (apple-app-site-association)
- [ ] Test deep links with ADB:
  ```bash
  adb shell am start -W -a android.intent.action.VIEW \
    -d "aevum://dashboard/family-tree" com.aevum.app
  ```
- **Deliverable**: Can open app to specific screens via deep links

#### Day 4-5: Admin & Role Guards (8 hours)
- [ ] Create `_adminGuard()` function checking Firebase auth claims
- [ ] Gate all admin routes (redirect non-admins to dashboard)
- [ ] Test permission checks
- [ ] Update DashboardScreen to show admin option for admins
- **Deliverable**: Admin screens only accessible to admins

#### Day 5: Testing & Optimization (4 hours)
- [ ] Manual testing on emulator and physical device
- [ ] Check for memory leaks (flutter analyze)
- [ ] Profile startup time
- [ ] Check app size

### Week 2 Tasks

#### Day 6-7: State Management Integration (16 hours)
- [ ] Review Zustand stores created by FED (via git)
- [ ] Add mobile state management if needed (Bloc or Riverpod)
- [ ] Wire screens to use shared state instead of local
- [ ] Test data persistence across app restarts
- **Deliverable**: Screens use shared state

#### Day 8: Safe Area & Platform Fixes (8 hours)
- [ ] Replace hardcoded padding with `MediaQuery.of(context).padding.bottom`
- [ ] Add WillPopScope for Android back button handling
- [ ] Fix iOS notch/home indicator spacing
- [ ] Add platform-specific UI adjustments
- **Deliverable**: App looks correct on all devices

#### Day 9-10: Final Testing & Optimization (8 hours)
- [ ] Run on iOS device (if available)
- [ ] Run on Android device (if available)
- [ ] Test all 8 core screens end-to-end
- [ ] Check accessibility (Text size, contrast)
- [ ] Prepare for TestFlight/App Store submission

---

## 🔥 GDEF (Firebase Expert) - INFRASTRUCTURE

**Total Effort**: 0.5 FTE (40 hours)  
**Primary Owner**: Firebase Configuration  
**Secondary**: Cloud Functions, security  

### Week 1 Tasks

#### Day 1-2: Firestore Setup (16 hours)
- [ ] Review current firestore.rules
- [ ] Add security rules for missing collections:
  ```
  - ai_tasks (for restoration, identity data)
  - search_index (vector search)
  - conversations (messaging)
  - catalogs (heritage catalog)
  - activity_logs (audit)
  ```
- [ ] Create comprehensive function helpers:
  ```codex-rules
  function isCollaborator(resource) { ... }
  function isAdmin() { ... }
  function validAITaskData() { ... }
  function validMediaData() { ... }
  ```
- [ ] Test rules with emulator
  ```bash
  firebase emulators:start
  ```
- **Deliverable**: All 8 collections have rules

#### Day 2-3: Firestore Indexes (8 hours)
- [ ] Analyze query patterns across app
- [ ] Create composite indexes for:
  - `ai_tasks(userId, status, createdAt)`
  - `media_items(familyId, type, uploadedAt)`
  - `members(familyId, createdAt)`
  - `search_index(embedding, createdAt)`
  - Others as needed
- [ ] Update firestore.indexes.json
- [ ] Deploy indexes:
  ```bash
  firebase deploy --only firestore:indexes
  ```
- **Deliverable**: Indexes deployed (watch Firebase Console for build completion)

#### Day 3: Storage Rules Review (4 hours)
- [ ] Review storage.rules for completeness
- [ ] Ensure file type validation is strict
- [ ] Add size limits per file type
- [ ] Test with actual uploads
- **Deliverable**: Storage rules validated

#### Day 4-5: Cloud Functions Stubs (8 hours)
- [ ] Create `infrastructure/src/functions/` directory
- [ ] Initialize npm + Firebase functions
- [ ] Create stubs for:
  - `validateFamilyMembership()` - triggered on media upload
  - `processAITask()` - triggered on ai_task creation
  - `notifyUser()` - send notifications
  - `aggregateMetrics()` - compute stats
- [ ] Deploy functions:
  ```bash
  firebase deploy --only functions
  ```
- [ ] Monitor deployment in Firebase Console
- **Deliverable**: Functions deployed (even if stubs)

#### Day 5: Testing & Emulator (4 hours)
- [ ] Start Firebase emulator suite
- [ ] Test all rules with sample data
- [ ] Test that queries work (indexes loaded)
- [ ] Test functions trigger correctly
- [ ] Create emulator test script for future use

### Week 2 Tasks

#### Day 6-7: Monitoring & Logging (8 hours)
- [ ] Set up Firestore monitoring alerts
- [ ] Set up Cloud Storage monitoring
- [ ] Configure error logging (Sentry or Firebase Crashlytics)
- [ ] Set up billing alerts
- [ ] Create runbook for common issues
- **Deliverable**: Team can monitor app health

#### Day 8-10: Documentation & Support (8 hours)
- [ ] Document all Firestore collections (schema)
- [ ] Document all Cloud Functions (API)
- [ ] Create troubleshooting guide
- [ ] Prepare for scale (capacity planning)
- [ ] Support FED/MAD with Firebase integration questions

---

## ⚙️ CKAD (Application Developer) - SUPPORT

**Total Effort**: 0.5 FTE (40 hours)  
**Primary Owner**: State Management, Component Library  
**Backup**: Help FED/MAD with urgent issues  

### Week 1 Tasks

#### Day 1-2: Zustand Stores (16 hours)
- [ ] Create `/apps/web/src/store/` directory
- [ ] Implement stores:
  - `useUserStore.js` - current user, auth status
  - `useFamilyStore.js` - family data, current family
  - `useMediaStore.js` - photos, videos, current item
  - `useUIStore.js` - modals, loading states, filters
- [ ] Add localStorage persistence to stores
- [ ] Test stores independently with console logs
- **Deliverable**: All stores working

#### Day 3-5: Integration (16 hours)
- [ ] Update DashboardScreen to use stores
- [ ] Update MemoriesScreen to use stores
- [ ] Update FamilyTreeScreen to use stores
- [ ] Remove old useState calls
- [ ] Test data flows end-to-end
- [ ] Check for memory leaks (no dangling subscriptions)

#### Day 5: Documentation (4 hours)
- [ ] Document store structure and usage
- [ ] Create examples for new developers
- [ ] Comment code with intent

### Week 2 Tasks

#### Day 6-7: Component Library Support (8 hours)
- [ ] Help FED implement reusable components
- [ ] Create stories for Storybook
- [ ] Test components across screens
- [ ] Edit screens that had custom implementations

#### Day 8-10: Testing & Bug Fixes (8 hours)
- [ ] Write unit tests for stores
- [ ] Test error scenarios (offline, API failure)
- [ ] Performance testing (render times)
- [ ] Bug fix support

---

## 🏛️ CKA (Kubernetes Admin) - DEVOPS SUPPORT

**Total Effort**: 0.3 FTE (24 hours)  
**Primary Owner**: CI/CD, Monitoring, Deployment  
**Responsibility**: Ensure infrastructure readiness  

### Week 1 Tasks

#### Day 1 (4 hours)
- [ ] Review current CI/CD setup
- [ ] Set up GitHub Actions for:
  - Web build & test
  - Mobile build & test
  - Automated deployments
- [ ] Create pre-launch checklist

#### Day 2-3 (8 hours)
- [ ] Set up monitoring (Sentry, Firebase Crashlytics)
- [ ] Configure error tracking
- [ ] Set up alerts for critical issues
- [ ] Create runbooks for common incidents

#### Day 4-5 (8 hours)
- [ ] Performance monitoring (APM - Application Performance Monitoring)
- [ ] Set up Firebase emulator for local dev
- [ ] Create Docker files (optional, for local dev consistency)
- [ ] Prepare deployment scripts

### Week 2 Tasks

#### Day 6-7 (4 hours)
- [ ] Support deployment to TestFlight/App Store
- [ ] Create deployment runbook
- [ ] Monitor builds during submission

#### Day 8-10 (4 hours)
- [ ] Standby for issues
- [ ] Performance optimization support
- [ ] Documentation of infrastructure

---

## 📊 KCS (Knowledge Manager) - DOCUMENTATION

**Total Effort**: 0.3 FTE (24 hours)  
**Owner**: Documentation & Knowledge Transfer  

### Ongoing (Throughout Both Weeks)

#### Daily (2 hours/day)
- [ ] Update project CHANGELOG
- [ ] Document decisions made in daily standups
- [ ] Keep team wiki updated
- [ ] Capture known issues

#### Weekly (4 hours per week)

**Week 1**:
- [ ] Create "Navigation Architecture" doc
- [ ] Create "Auth Flow" diagram
- [ ] Create "Firestore Schema" reference
- [ ] Document all new routes and screens

**Week 2**:
- [ ] Create "Component Library" reference
- [ ] Create "State Management" guide
- [ ] Create "Deployment Process" runbook
- [ ] Create "Troubleshooting" guide

#### End of Week 2

- [ ] Create "MVP Launch" checklist
- [ ] Create "Post-Launch" support guide
- [ ] Onboard new team members (if any)
- [ ] Create training materials

---

## 📅 DAILY STANDUP TEMPLATE

**Time**: 10:00 AM Daily (15 min)  
**Format**: Round-robin by persona  

```
## STANDUP: Feb __, 2026

### FED (Frontend)
Yesterday: [✅ Router fix, ✅ ErrorBoundary]
Today: [🔄 Auth context, Auth UI]
Blockers: None

### MAD (Mobile)
Yesterday: [✅ GoRouter setup, 🔄 Route migration half done]
Today: [🔄 Complete route migration, Deep linking]
Blockers: ⚠️ Need FED to finalize auth logic first

### GDEF (Firebase)
Yesterday: [✅ Firestore rules review, 🔄 Composite indexes]
Today: [🔄 Deploy indexes, Cloud Functions stubs]
Blockers: None

### CKAD (App Dev)
Yesterday: [🔄 Zustand store design]
Today: [✅ Zustand stores, 🔄 Integration]
Blockers: Need store schema from FED

### CKA (DevOps)
Yesterday: [✅ CI/CD review, 🔄 Monitoring setup]
Today: [🔄 Sentry integration, Alerts]
Blockers: None

### KCS (Docs)
Yesterday: [✅ Project history, 🔄 Route docs]
Today: [🔄 Auth flow diagram, Architecture docs]
Blockers: None

---
**Issues to Escalate**: None yet
**On Track**: YES
```

---

## Post-Sprint Retrospective Template

**Scheduled**: Feb 28, 2026 (day after MVP target)

```markdown
## RETROSPECTIVE: What Went Well, What Didn't, What's Next

### What Went Well
- [ ] Feature 1
- [ ] Feature 2

### What Didn't Go Well
- [ ] Issue 1 (how we fixed it)
- [ ] Issue 2 (how we fixed it)

### What We'll Do Different Next Sprint
- [ ] Change 1
- [ ] Change 2

### Metrics
- Build time: X minutes
- Bugs found: Y in testing, Z after launch
- Code review time: X hours
- Deployment time: Y minutes

### Team Feedback
- FED: "..."
- MAD: "..."
- GDEF: "..."
- CKAD: "..."
- CKA: "..."
- KCS: "..."
```

---

## Success Celebation Plan

**Upon MVP Launch**:
1. ✅ Announce in #general Slack channel
2. ✅ Share metrics (app size, load time, feature count)
3. ✅ Thank the team publicly
4. ✅ Plan post-launch support schedule
5. ✅ Schedule retrospective dinner/outing

---

**Document Version**: 1.0  
**Last Updated**: February 13, 2026  
**Status**: Ready for Assignment
