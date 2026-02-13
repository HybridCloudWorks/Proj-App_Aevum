# 🚀 AEVUM MVP - 2-Week Sprint (Feb 13-27, 2026)

**Status**: 🔴 CRITICAL - MVP Not Ready | Leadership Approved 2-Week Fix Sprint  
**Team**: FED (1.0 FTE), MAD (0.8), GDEF (0.5), CKAD (0.5), CKA (0.3), KCS (0.3)  
**Total Effort**: 252 person-hours | **Goal**: Ship to TestFlight/App Store beta by Feb 27  
**Last Updated**: February 13, 2026 | **Status**: READY FOR SPRINT PLANNING

---

## ⚡ QUICK NAVIGATION

- [Executive Summary](#executive-summary) - 9 blockers and why we need this 2-week fix
- [Phase 1: Critical Fixes (Days 1-5)](#phase-1-critical-fixes-days-1-5) - Navigation, Auth, Firebase
- [Phase 2: Firebase Integration (Days 6-8)](#phase-2-firebase-integration-days-6-8) - Security rules, indexes, functions
- [Phase 3: State Management (Days 9-10)](#phase-3-state-management-days-9-10) - Zustand stores
- [Phase 4: Component Library (Days 11-12)](#phase-4-component-library--design-system-days-11-12) - Reusable components, light mode
- [Phase 5: Error Handling (Day 13)](#phase-5-error-handling--loading-states-day-13) - Loading and error states
- [Pre-Launch Verification (Day 14)](#pre-launch-verification-checklist-day-14) - Final validation
- [Knowledge Bases & Cleanup Plan](#knowledge-bases-and-cleanup-plan) - What to keep, rename, delete

---

## EXECUTIVE SUMMARY

### 🔴 9 Critical Blockers (Why MVP Can't Ship As-Is)

**BLOCKER #1: Navigation is Broken**
- 39 mobile screens defined but only 5-6 are reachable
- Web has 5+ routes referenced but undefined (SettingsScreen → PrivacySecurityScreen path breaks)
- Users cannot navigate 85% of the app
- **Impact**: Users stuck on login or homepage  
- **Fix Effort**: 2 days (FED + MAD)

**BLOCKER #2: Auth System Missing**
- Login form doesn't actually call Firebase auth methods
- No SignUp, SignIn, SignOut, ResetPassword methods in code
- AuthContext is a skeleton with only { user, loading, error, isAuthenticated }
- **Impact**: App cannot authenticate any real users  
- **Fix Effort**: 1 day (FED)

**BLOCKER #3: Firebase Rules Incomplete**
- Only 4 collections have rules (users, members, families, media_items)
- Missing: ai_tasks, search_index, conversations, catalogs, activity_logs
- No composite indexes (only 2, app needs 5+)
- **Impact**: Data loss/corruption, performance queries fail  
- **Fix Effort**: 2 days (GDEF)

**BLOCKER #4: Admin Features Unreachable**
- 13 admin screens exist but no UI path connects to them
- DashboardScreen doesn't link to /admin route
- BottomNav has hardcoded 5 items, no admin option
- **Impact**: Admin controls only accessible to developers  
- **Fix Effort**: 1 day (included in Phase 1 navigation)

**BLOCKER #5: Error Handling Absent**
- One network error = blank white screen (no error boundary)
- No loading states on data-fetching screens
- No error messages (users don't know what went wrong)
- **Impact**: Users think app is broken when servers are down  
- **Fix Effort**: 1 day (FED)

**BLOCKER #6: Component Library Missing**
- 50+ duplicate Button and Card implementations
- Updating styling requires editing 50+ files
- Design inconsistency (4 different "glass blur" values)
- **Impact**: Impossible to maintain visual consistency, slow iterations  
- **Fix Effort**: 1.5 days (FED)

**BLOCKER #7: State Management Ignored**
- Zustand installed in package.json but never imported
- Every screen manages its own useState duplicates data fetches
- No global caching or normalization
- **Impact**: App is slow, battery draining, duplicate API calls  
- **Fix Effort**: 2 days (CKAD)

**BLOCKER #8: Firebase Configuration Incomplete**
- Only 2 Firestore composite indexes (app needs 5+)
- Missing indexes cause queries to fail at scale
- No Cloud Functions for data validation
- **Impact**: Performance degradation as users grow  
- **Fix Effort**: 1 day (GDEF, included in Phase 2)

**BLOCKER #9: Design System Broken**
- Dark mode only; light mode would render white text on white
- No theme toggle
- Design tokens scattered in individual screens
- **Impact**: Can't ship light mode variant, inconsistent design  
- **Fix Effort**: 1 day (FED, included in Phase 4)

### ✅ What Already Works (No Need to Rebuild)

- Firebase project fully configured (auth, firestore, storage)
- React web architecture solid (routing framework good)
- Flutter mobile structure solid (ready for navigation fix)
- Firestore security rules foundation exists (partial)
- 50+ screens designed (HTML/CSS exists, just wired wrong)

### 📊 Cost Analysis

**Why We Must Fix (2 weeks)**:
- Fix cost: ~$15K (3 engineers × 2 weeks)
- **Benefit**: App works, users can log in, data is safe
- **Risk**: Low (all issues well-understood with clear solutions)

**Cost of Delay (per week)**:
- Lost opportunity: $22.5K per week (competitor shipping instead)
- App Store rejection: Will cost $25K+ in rework

**Cost of Shipping Broken**:
- App Store rejection: $5K re-development
- User complaints: $2K support overhead
- Refunds: $0-50K depending on user base
- **Total**: $7K-55K

**Decision**: Approve 2-week sprint (ROI = prevent $25K-55K loss)

---

# PHASE 1: CRITICAL FIXES (Days 1-5)

_**Lead**: FED + MAD | **Effort**: 80 hours | **Blocker**: CRITICAL_

## Sprint 1.1: Web Navigation Fix (FED Lead) — Days 1-2

**Owner**: Frontend & DevOps Engineer | **DailyRate**: 8 hours/day | **Owner**: FED

### Task 1.1.1: Create Route Registry & Fix Missing Routes — 8 hours

**Files to Create/Edit**:
1. **Create** `apps/web/src/routes/routeConfig.js` (NEW FILE)
2. **Edit** `apps/web/src/App.jsx` (ADD lazy imports and <Route> elements)

**Step 1.1.1.1: Create route registry**

File: `apps/web/src/routes/routeConfig.js`
```javascript
/**
 * Centralized route configuration
 * Purpose: Single source of truth for all app routes
 * Updated: Feb 13, 2026
 */

export const ROUTE_CONFIG = {
  // Home & Auth
  HOME: '/',
  AUTH: '/auth',

  // Dashboard & Core Features
  DASHBOARD: '/dashboard',
  FAMILY_TREE: '/family-tree',
  MEMORIES: '/memories',
  MEMORIES_UPLOAD: '/memories/upload',
  MEMORIES_RESTORATION: '/memories/restoration',
  HERITAGE_MAP: '/heritage-map',

  // Settings & User
  SETTINGS: '/settings',
  SETTINGS_PRIVACY: '/settings/privacy',
  SETTINGS_PRIVACY_RULES: '/settings/privacy-rules',
  SETTINGS_PRIVACY_SECURITY: '/settings/privacy-security',  // ← MISSING IN OLD CODE
  SETTINGS_RESTRICTED_PROFILE: '/settings/restricted-profile/:section',  // ← BROKEN IN OLD CODE
  SETTINGS_INFRASTRUCTURE: '/settings/infrastructure',
  SETTINGS_DELEGATION: '/settings/delegation',
  SETTINGS_LEGACY: '/settings/legacy-handover',

  // Admin (post-MVP, but must be accessible)
  ADMIN: '/admin',
};

/**
 * Get route by key
 * Usage: getRoute('MEMORIES_UPLOAD') → '/memories/upload'
 */
export function getRoute(key, params = {}) {
  let route = ROUTE_CONFIG[key];
  if (!route) {
    throw new Error(`Route key not found: ${key}`);
  }
  // Replace route parameters if provided
  Object.entries(params).forEach(([key, value]) => {
    route = route.replace(`:${key}`, value);
  });
  return route;
}
```

**Step 1.1.1.2: Add missing lazy imports to App.jsx**

In `apps/web/src/App.jsx`, after existing lazy imports (around line 30), add:
```jsx
// PRIVACY SCREENS (missing from original code)
const PrivacySecurityScreen = lazy(
  () => import("@screens/settings/privacy/PrivacySecurityScreen"),
);
const RestrictedProfileScreen = lazy(
  () => import("@screens/settings/privacy/RestrictedProfileScreen"),
);
```

**Step 1.1.1.3: Add missing routes in App.jsx**

In `apps/web/src/App.jsx` Routes section (around line 90), add these routes AFTER the existing /settings/privacy-rules route:

```jsx
<Route path="/settings/privacy-security" element={<PrivacySecurityScreen />} />
<Route path="/settings/restricted-profile/:section" element={<RestrictedProfileScreen />} />

// THIS MUST BE LAST (catch-all for 404)
<Route path="*" element={<NotFoundScreen />} />
```

**Step 1.1.1.4: Update SettingsScreen to use route registry**

In `apps/web/src/screens/SettingsScreen.jsx`, update navigation imports and calls:

**Before**:
```jsx
import { useNavigate } from 'react-router-dom';

const navigate = useNavigate();
// Later in component:
onClick={() => navigate("/settings/privacy-rules")}
```

**After**:
```jsx
import { useNavigate } from 'react-router-dom';
import { ROUTE_CONFIG } from '@routes/routeConfig';

const navigate = useNavigate();
// Later in component:
onClick={() => navigate(ROUTE_CONFIG.SETTINGS_PRIVACY_RULES)}
onClick={() => navigate(ROUTE_CONFIG.SETTINGS_PRIVACY_SECURITY)}
onClick={() => navigate(ROUTE_CONFIG.SETTINGS_INFRASTRUCTURE)}
// etc...
```

**Success Criteria for Task 1.1.1**:
- [ ] routeConfig.js file created with all 15+ routes
- [ ] App.jsx has lazy imports for missing screens
- [ ] App.jsx has <Route> elements for both missing routes
- [ ] Manual test: Click "Settings" → "Privacy & Rules" → works
- [ ] Manual test: Click "Settings" → "Privacy & Security" → works
- [ ] Manual test: Click "Settings" → "Restricted Profile" → works
- [ ] Manual test: Navigate to invalid route (e.g., /nonexistent) → shows NotFoundScreen (will be created in 1.1.2)
- [ ] Browser console: No route errors

---

### Task 1.1.2: Create NotFoundScreen & ErrorBoundary — 8 hours

**Files to Create**:
1. `apps/web/src/components/NotFoundScreen.jsx` (NEW)
2. `apps/web/src/components/ErrorBoundary.jsx` (NEW)

**Step 1.1.2.1: Create NotFoundScreen.jsx**

File: `apps/web/src/components/NotFoundScreen.jsx`
```jsx
import { useNavigate } from 'react-router-dom';
import { Button } from '@components/ui/Button';

/**
 * 404 NotFound Screen
 * Shown when user navigates to invalid route
 */
export default function NotFoundScreen() {
  const navigate = useNavigate();

  return (
    <div className="flex flex-col items-center justify-center min-h-screen gap-6 bg-gray-900">
      <div className="text-center">
        <h1 className="text-6xl font-bold text-gray-100 mb-2">404</h1>
        <p className="text-xl text-gray-400 mb-4">Page Not Found</p>
        <p className="text-sm text-gray-500 mb-8">
          The page you're looking for doesn't exist or has been moved.
        </p>
      </div>

      <div className="flex gap-4">
        <Button variant="primary" onClick={() => navigate('/')}>
          Go Home
        </Button>
        <Button variant="secondary" onClick={() => navigate(-1)}>
          Go Back
        </Button>
      </div>

      {/* Optional: Show requested path for debugging */}
      <div className="mt-12 text-xs text-gray-600">
        Requested: {window.location.pathname}
      </div>
    </div>
  );
}
```

**Step 1.1.2.2: Create ErrorBoundary.jsx**

File: `apps/web/src/components/ErrorBoundary.jsx`
```jsx
import React from 'react';
import { Button } from '@components/ui/Button';

/**
 * Error Boundary Component
 * Catches React errors and displays graceful error UI
 * Prevents white screen of death
 */
export class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      hasError: false,
      error: null,
      errorInfo: null,
    };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true };
  }

  componentDidCatch(error, errorInfo) {
    this.setState({
      error,
      errorInfo,
    });
    // Log to error tracking service (Sentry, etc.)
    console.error('Error caught by boundary:', error, errorInfo);
  }

  handleReset = () => {
    this.setState({
      hasError: false,
      error: null,
      errorInfo: null,
    });
  };

  handleReload = () => {
    window.location.reload();
  };

  render() {
    if (this.state.hasError) {
      return (
        <div className="flex flex-col items-center justify-center min-h-screen gap-6 bg-red-900/10 p-6">
          <div className="max-w-lg text-center">
            <h1 className="text-3xl font-bold text-red-400 mb-2">
              Something Went Wrong
            </h1>
            <p className="text-gray-300 mb-4">
              An unexpected error occurred. Our team has been notified.
            </p>

            {/* Show error details in development */}
            {process.env.NODE_ENV === 'development' && (
              <div className="bg-gray-800 rounded p-4 mb-6 text-left">
                <p className="text-xs text-gray-400 font-mono break-words">
                  {this.state.error?.toString()}
                </p>
                {this.state.errorInfo && (
                  <details className="mt-4">
                    <summary className="cursor-pointer text-xs text-gray-500">
                      Stack Trace
                    </summary>
                    <pre className="mt-2 text-xs text-gray-500 overflow-auto max-h-32">
                      {this.state.errorInfo.componentStack}
                    </pre>
                  </details>
                )}
              </div>
            )}

            <div className="flex gap-4 justify-center">
              <Button variant="primary" onClick={this.handleReset}>
                Try Again
              </Button>
              <Button variant="secondary" onClick={this.handleReload}>
                Reload App
              </Button>
            </div>
          </div>
        </div>
      );
    }

    return this.props.children;
  }
}
```

**Step 1.1.2.3: Update App.jsx to use ErrorBoundary and import NotFoundScreen**

In `apps/web/src/App.jsx`, update the imports:
```jsx
import { ErrorBoundary } from '@components/ErrorBoundary';
import NotFoundScreen from '@components/NotFoundScreen';
```

Then wrap the entire app:
```jsx
function App() {
  return (
    <ErrorBoundary>
      <BrowserRouter>
        <Suspense fallback={<LoadingScreen />}>
          <Routes>
            {/* ... existing routes ... */}
            <Route path="*" element={<NotFoundScreen />} />
          </Routes>
        </Suspense>
      </BrowserRouter>
    </ErrorBoundary>
  );
}
```

**Success Criteria for Task 1.1.2**:
- [ ] NotFoundScreen.jsx created and exports default component
- [ ] ErrorBoundary.jsx created and exports class component
- [ ] App.jsx imports both components
- [ ] App.jsx wraps Routes with ErrorBoundary
- [ ] Manual test: Navigate to `/invalid-route` → shows NotFoundScreen
- [ ] Manual test: Trigger a React error (e.g., undefined prop access) → shows ErrorBoundary
- [ ] Manual test: ErrorBoundary has "Try Again" button that clears error
- [ ] Manual test: "Go Back" button on NotFoundScreen uses browser back
- [ ] Browser console: No import errors, no undefined component errors

---

## Sprint 1.2: Mobile Navigation Fix (MAD Lead) — Days 2-3

**Owner**: Mobile App Developer | **Effort**: 32 hours

### Task 1.2.1: Implement GoRouter for Deep Linking — 16 hours

**Files to Create/Edit**:
1. **Create** `apps/mobile/lib/navigation/app_router.dart` (NEW)
2. **Edit** `apps/mobile/lib/main.dart` (USE GoRouter)
3. **Delete** old hardcoded routes from main.dart

**Step 1.2.1.1: Install GoRouter**

```bash
cd apps/mobile
flutter pub add go_router
```

**Step 1.2.1.2: Create app_router.dart**

File: `apps/mobile/lib/navigation/app_router.dart`
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/intro_page_screen.dart';
import '../screens/auth_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/family_tree_explorer_screen.dart';
import '../screens/memories_screen.dart';
import '../screens/heritage_map_screen.dart';
import '../screens/vault_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/admin/admin_dashboard_screen.dart';
import '../screens/admin/admin_ai_engine_screen.dart';
import '../screens/admin/admin_ai_restoration_screen.dart';
import '../screens/admin/admin_spatial_screen.dart';
import '../screens/admin/admin_storage_setup_screen.dart';
import '../screens/admin/admin_roles_screen.dart';
import '../screens/admin/admin_catalog_engine_screen.dart';
import '../screens/admin/admin_alpha_launch_screen.dart';
import '../screens/admin/admin_storage_architecture_screen.dart';
import '../screens/admin/admin_privacy_security_screen.dart';

/**
 * Global GoRouter instance
 * Handles all navigation, deep linking, and state restoration
 */
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  onException: (context, state, exception) {
    // Handle navigation exceptions
    print('Navigation error: $exception');
  },
  routes: [
    // Intro / Auth Flow
    GoRoute(
      path: '/',
      builder: (context, state) => const IntroPageScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),

    // Main Dashboard & Features (post-auth)
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
      routes: [
        // Nested routes within dashboard context
        GoRoute(
          path: 'family-tree',
          pageBuilder: (context, state) => MaterialPage(
            child: const FamilyTreeExplorerScreen(),
          ),
        ),
        GoRoute(
          path: 'memories',
          pageBuilder: (context, state) => MaterialPage(
            child: const MemoriesScreen(),
          ),
        ),
        GoRoute(
          path: 'heritage-map',
          pageBuilder: (context, state) => MaterialPage(
            child: const HeritageMapScreen(),
          ),
        ),
        GoRoute(
          path: 'vault',
          pageBuilder: (context, state) => MaterialPage(
            child: const VaultScreen(),
          ),
        ),
        GoRoute(
          path: 'profile',
          pageBuilder: (context, state) => MaterialPage(
            child: const ProfileScreen(),
          ),
        ),
        GoRoute(
          path: 'settings',
          pageBuilder: (context, state) => MaterialPage(
            child: const SettingsScreen(),
          ),
        ),
      ],
    ),

    // Admin Routes (gated by role check)
    GoRoute(
      path: '/admin',
      redirect: (context, state) async {
        // Check if user is admin before allowing access
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          return '/auth';  // Not authenticated, go to auth
        }
        // TODO: Check Firestore for admin role claim
        final isAdmin = await _checkAdminStatus(user.uid);
        if (!isAdmin) {
          return '/dashboard';  // Not admin, redirect to dashboard
        }
        return null;  // Allow admin access
      },
      builder: (context, state) => const AdminDashboardScreen(),
      routes: [
        GoRoute(
          path: 'ai-engine',
          builder: (context, state) => const AdminAIEngineScreen(),
        ),
        GoRoute(
          path: 'ai-restoration',
          builder: (context, state) => const AdminAIRestorationScreen(),
        ),
        GoRoute(
          path: 'spatial',
          builder: (context, state) => const AdminSpatialScreen(),
        ),
        GoRoute(
          path: 'storage-setup',
          builder: (context, state) => const AdminStorageSetupScreen(),
        ),
        GoRoute(
          path: 'roles',
          builder: (context, state) => const AdminRoleManagementScreen(),
        ),
        GoRoute(
          path: 'catalog-engine',
          builder: (context, state) => const AdminCatalogEngineScreen(),
        ),
        GoRoute(
          path: 'alpha-launch',
          builder: (context, state) => const AdminAlphaLaunchScreen(),
        ),
        GoRoute(
          path: 'storage-architecture',
          builder: (context, state) => const AdminStorageArchitectureScreen(),
        ),
        GoRoute(
          path: 'privacy-security',
          builder: (context, state) => const AdminPrivacySecurityScreen(),
        ),
      ],
    ),
  ],
);

/**
 * Check if user has admin role in Firestore
 * TODO: Implement with Firestore user doc check
 */
Future<bool> _checkAdminStatus(String userId) async {
  // Placeholder - implement with actual Firestore check
  return false;  // Currently all users are non-admin
}
```

**Step 1.2.1.3: Update main.dart to use GoRouter**

File: `apps/mobile/lib/main.dart`

**Before**:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroPageScreen(),
      routes: {
        '/auth': (context) => const AuthScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        // ... 39 hardcoded routes ...
      },
    );
  }
}
```

**After**:
```dart
import 'package:aevum/navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Aevum',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
    );
  }
}
```

**Step 1.2.1.4: Update DashboardScreen to use GoRouter**

In `apps/mobile/lib/screens/dashboard_screen.dart`, update navigation:

**Before**:
```dart
Navigator.pushNamed(context, '/admin');
```

**After**:
```dart
context.push('/admin');
```

Do same for all screen navigation calls in DashboardScreen, MemoriesScreen, etc.

**Success Criteria for Task 1.2.1**:
- [ ] app_router.dart created with GoRouter instance
- [ ] All 39 routes defined in GoRouter (main + nested under /dashboard)
- [ ] Admin routes have redirect guard (checks role)
- [ ] main.dart uses MaterialApp.router with appRouter config
- [ ] Old hardcoded routes removed from main.dart
- [ ] Manual test (emulator): App starts at /
- [ ] Manual test: Click "Sign In" → navigate to /auth
- [ ] Manual test: From /dashboard, click "Family Tree" → navigate to /dashboard/family-tree
- [ ] Manual test: Back button works correctly
- [ ] Manual test: Deep link test via ADB: `adb shell am start -W -a android.intent.action.VIEW -d "aevum://dashboard/family-tree"`
- [ ] Console: No navigation errors, no undefined route errors

---

### Task 1.2.2: Implement Admin Navigation Menu — 8 hours

**Files to Edit**:
1. `apps/mobile/lib/screens/dashboard_screen.dart`
2. `apps/mobile/lib/widgets/admin_menu_button.dart` (NEW)

**Step 1.2.2.1: Create AdminMenuButton widget**

File: `apps/mobile/lib/widgets/admin_menu_button.dart`
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

/**
 * Admin Menu Button
 * Only shows for admin users
 * Redirects to /admin dashboard
 */
class AdminMenuButton extends StatefulWidget {
  const AdminMenuButton({Key? key}) : super(key: key);

  @override
  State<AdminMenuButton> createState() => _AdminMenuButtonState();
}

class _AdminMenuButtonState extends State<AdminMenuButton> {
  bool isAdmin = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAdminStatus();
  }

  Future<void> _checkAdminStatus() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() => isLoading = false);
        return;
      }

      // TODO: Fetch from Firestore user doc
      // final userDoc = await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(user.uid)
      //     .get();
      // final role = userDoc.data()?['role'] as String? ?? 'user';
      
      setState(() {
        isAdmin = false; // Placeholder - update when checking Firestore
        isLoading = false;
      });
    } catch (e) {
      print('Error checking admin status: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || !isAdmin) {
      return const SizedBox.shrink();  // Don't show if not admin
    }

    return FloatingActionButton.extended(
      onPressed: () => context.push('/admin'),
      label: const Text('Admin Panel'),
      icon: const Icon(Icons.admin_panel_settings),
      tooltip: 'Admin Controls',
    );
  }
}
```

**Step 1.2.2.2: Add AdminMenuButton to DashboardScreen**

In `apps/mobile/lib/screens/dashboard_screen.dart`:

```dart
import '../widgets/admin_menu_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: // ... main dashboard content ...
      floatingActionButton: const AdminMenuButton(),  // ← ADD THIS
    );
  }
}
```

**Success Criteria for Task 1.2.2**:
- [ ] AdminMenuButton widget created
- [ ] AdminMenuButton checks admin status on init
- [ ] AdminMenuButton only shows for admin users
- [ ] Non-admin users don't see the button
- [ ] Admin users see button and can click to /admin
- [ ] Manual test (non-admin): No admin button visible
- [ ] Manual test (admin): Admin button visible and clickable
- [ ] Manual test: Clicking admin button navigates to /admin

---

## Sprint 1.3: Auth Context Implementation (FED Lead) — Days 3-4

**Owner**: Frontend & DevOps Engineer | **Effort**: 16 hours

### Task 1.3.1: Implement Missing Auth Methods — 8 hours

**Files to Create/Edit**:
1. `apps/web/src/contexts/AuthContext.jsx` (REPLACE entire file)
2. `apps/mobile/lib/services/auth_service.dart` (CREATE/UPDATE)

**Step 1.3.1.1: Update AuthContext.jsx with all methods**

File: `apps/web/src/contexts/AuthContext.jsx`
```jsx
import React, { createContext, useContext, useState, useEffect } from 'react';
import { 
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  signOut,
  sendPasswordResetEmail,
  onAuthStateChanged,
  updateProfile,
} from 'firebase/auth';
import { auth, db } from '@lib/firebase';
import { doc, setDoc, getDoc } from 'firebase/firestore';

/**
 * AuthContext
 * Provides authentication methods: signUp, signIn, signOut, resetPassword
 * Manages auth state: user, loading, error
 */
const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [userProfile, setUserProfile] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Listen for auth state changes
  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, async (authUser) => {
      try {
        if (authUser) {
          setUser(authUser);
          
          // Fetch user profile from Firestore
          const userDocRef = doc(db, 'users', authUser.uid);
          const userDocSnap = await getDoc(userDocRef);
          const profile = userDocSnap.data() || {};
          
          setUserProfile({
            ...profile,
            uid: authUser.uid,
            email: authUser.email,
            displayName: authUser.displayName,
            photoURL: authUser.photoURL,
          });
        } else {
          setUser(null);
          setUserProfile(null);
        }
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    });

    return () => unsubscribe();
  }, []);

  /**
   * Sign up with email and password
   * Creates Firebase Auth account AND Firestore user document
   */
  const signUp = async (email, password, displayName) => {
    try {
      setError(null);
      
      // Create Firebase Auth account
      const result = await createUserWithEmailAndPassword(auth, email, password);
      const newUser = result.user;

      // Update display name
      await updateProfile(newUser, { displayName });

      // Create Firestore user document
      await setDoc(doc(db, 'users', newUser.uid), {
        uid: newUser.uid,
        email,
        displayName,
        photoURL: null,
        createdAt: new Date(),
        role: 'user',  // Default role
      });

      // Update state
      setUser(newUser);
      setUserProfile({
        uid: newUser.uid,
        email,
        displayName,
        photoURL: null,
        role: 'user',
        createdAt: new Date(),
      });

      return newUser;
    } catch (err) {
      const message = _getAuthErrorMessage(err.code);
      setError(message);
      throw err;
    }
  };

  /**
   * Sign in with email and password
   */
  const signIn = async (email, password) => {
    try {
      setError(null);
      
      const result = await signInWithEmailAndPassword(auth, email, password);
      const authenticatedUser = result.user;

      // Fetch user profile from Firestore
      const userDocSnap = await getDoc(doc(db, 'users', authenticatedUser.uid));
      const profile = userDocSnap.data() || {};

      setUser(authenticatedUser);
      setUserProfile({
        ...profile,
        uid: authenticatedUser.uid,
        email: authenticatedUser.email,
        displayName: authenticatedUser.displayName,
      });

      return authenticatedUser;
    } catch (err) {
      const message = _getAuthErrorMessage(err.code);
      setError(message);
      throw err;
    }
  };

  /**
   * Sign out current user
   */
  const signOutUser = async () => {
    try {
      setError(null);
      await signOut(auth);
      setUser(null);
      setUserProfile(null);
    } catch (err) {
      const message = _getAuthErrorMessage(err.code);
      setError(message);
      throw err;
    }
  };

  /**
   * Send password reset email
   */
  const resetPassword = async (email) => {
    try {
      setError(null);
      await sendPasswordResetEmail(auth, email);
      return true;
    } catch (err) {
      const message = _getAuthErrorMessage(err.code);
      setError(message);
      throw err;
    }
  };

  /**
   * Update user profile in Firestore
   */
  const updateUserProfile = async (updates) => {
    try {
      if (!user) throw new Error('No authenticated user');
      
      setError(null);

      // Update auth profile if needed
      if (updates.displayName || updates.photoURL) {
        await updateProfile(user, {
          displayName: updates.displayName || user.displayName,
          photoURL: updates.photoURL || user.photoURL,
        });
      }

      // Update Firestore document
      await setDoc(
        doc(db, 'users', user.uid),
        { ...updates, updatedAt: new Date() },
        { merge: true }
      );

      // Update local state
      setUserProfile((prev) => ({
        ...prev,
        ...updates,
      }));

      return true;
    } catch (err) {
      const message = _getAuthErrorMessage(err.code);
      setError(message);
      throw err;
    }
  };

  const value = {
    user,
    userProfile,
    loading,
    error,
    isAuthenticated: !!user,
    signUp,
    signIn,
    signOut: signOutUser,
    resetPassword,
    updateUserProfile,
    clearError: () => setError(null),
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

/**
 * Hook to use auth context
 */
export function useAuth() {
  const context = useContext(AuthContext);
  if (context === null) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}

/**
 * Convert Firebase auth error codes to user-friendly messages
 */
function _getAuthErrorMessage(code) {
  const errors = {
    'auth/invalid-email': 'Invalid email address',
    'auth/user-disabled': 'This account has been disabled',
    'auth/user-not-found': 'User not found',
    'auth/wrong-password': 'Incorrect password',
    'auth/email-already-in-use': 'Email already in use',
    'auth/weak-password': 'Password is too weak (min 6 characters)',
    'auth/operation-not-allowed': 'Email/password authentication not enabled',
    'auth/too-many-requests': 'Too many login attempts, try again later',
  };
  return errors[code] || 'Authentication error';
}
```

**Step 1.3.1.2: Create/Update AuthService for mobile**

File: `apps/mobile/lib/services/auth_service.dart`
```dart
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * AuthService
 * Handles Firebase authentication for mobile app
 * Methods: signUp, signIn, signOut, resetPassword
 */
class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /**
   * Sign up with email and password
   */
  Future<firebase_auth.UserCredential?> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      // Create Firebase Auth account
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) return null;

      // Update display name
      await user.updateDisplayName(displayName);

      // Create Firestore user document
      await _db.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': email,
        'displayName': displayName,
        'photoURL': null,
        'createdAt': FieldValue.serverTimestamp(),
        'role': 'user',
      });

      return credential;
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('Sign up error: ${e.code} - ${e.message}');
      rethrow;
    }
  }

  /**
   * Sign in with email and password
   */
  Future<firebase_auth.UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('Sign in error: ${e.code} - ${e.message}');
      rethrow;
    }
  }

  /**
   * Sign out current user
   */
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('Sign out error: ${e.code} - ${e.message}');
      rethrow;
    }
  }

  /**
   * Send password reset email
   */
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('Reset password error: ${e.code} - ${e.message}');
      rethrow;
    }
  }

  /**
   * Get current authenticated user
   */
  firebase_auth.User? getCurrentUser() {
    return _auth.currentUser;
  }

  /**
   * Stream of auth state changes
   */
  Stream<firebase_auth.User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
```

**Success Criteria for Task 1.3.1**:
- [ ] AuthContext.jsx has signUp method (creates auth account + Firestore doc)
- [ ] AuthContext.jsx has signIn method
- [ ] AuthContext.jsx has signOut method
- [ ] AuthContext.jsx has resetPassword method
- [ ] AuthContext.jsx has updateUserProfile method
- [ ] AuthContext.jsx uses Firestore to persist user profile
- [ ] AuthService.dart has all same methods for mobile
- [ ] Manual test: Sign up with new email → user created in Firestore
- [ ] Manual test: Sign in with email/password → user authenticated
- [ ] Manual test: Password reset email sent
- [ ] Manual test: Sign out → user cleared from state

---

### Task 1.3.2: Connect WelcomeScreen to Real Auth — 8 hours

**Files to Edit**:
1. `apps/web/src/screens/WelcomeScreen.jsx`
2. `apps/mobile/lib/screens/auth_screen.dart`

**Step 1.3.2.1: Update WelcomeScreen.jsx**

File: `apps/web/src/screens/WelcomeScreen.jsx`
```jsx
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '@contexts/AuthContext';
import { Input } from '@components/ui/Input';
import { Button } from '@components/ui/Button';
import { ErrorBox } from '@components/ErrorBox';
import { LoadingSpinner } from '@components/LoadingSpinner';

/**
 * Welcome Screen
 * Handles user onboarding: Sign in or Sign up
 */
export default function WelcomeScreen() {
  const navigate = useNavigate();
  const { signIn, signUp, loading: authLoading } = useAuth();
  
  const [mode, setMode] = useState('signin');  // 'signin' or 'signup'
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [displayName, setDisplayName] = useState('');
  const [error, setError] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const handleSignIn = async (e) => {
    e.preventDefault();
    setError('');
    setIsLoading(true);

    try {
      if (!email || !password) {
        throw new Error('Email and password required');
      }

      await signIn(email, password);
      navigate('/dashboard');
    } catch (err) {
      setError(err.message);
    } finally {
      setIsLoading(false);
    }
  };

  const handleSignUp = async (e) => {
    e.preventDefault();
    setError('');
    setIsLoading(true);

    try {
      if (!email || !password || !displayName) {
        throw new Error('All fields required');
      }

      if (password.length < 6) {
        throw new Error('Password must be at least 6 characters');
      }

      await signUp(email, password, displayName);
      navigate('/dashboard');
    } catch (err) {
      setError(err.message);
    } finally {
      setIsLoading(false);
    }
  };

  if (authLoading) {
    return <LoadingSpinner />;
  }

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gray-900 p-4">
      <div className="w-full max-w-md">
        <h1 className="text-4xl font-bold text-white mb-2">Aevum</h1>
        <p className="text-gray-400 mb-8">Preserve your family's heritage</p>

        {error && (
          <ErrorBox 
            error={error} 
            onRetry={() => setError('')}
          />
        )}

        <form onSubmit={mode === 'signin' ? handleSignIn : handleSignUp} className="space-y-4">
          <Input
            type="email"
            placeholder="Email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            disabled={isLoading}
            label="Email Address"
          />

          {mode === 'signup' && (
            <Input
              type="text"
              placeholder="Display Name"
              value={displayName}
              onChange={(e) => setDisplayName(e.target.value)}
              disabled={isLoading}
              label="Full Name"
            />
          )}

          <Input
            type="password"
            placeholder="Password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            disabled={isLoading}
            label="Password"
          />

          <Button
            variant="primary"
            type="submit"
            disabled={isLoading}
            className="w-full"
          >
            {isLoading ? 'Loading...' : mode === 'signin' ? 'Sign In' : 'Sign Up'}
          </Button>
        </form>

        <div className="mt-6 text-center">
          <p className="text-gray-400 text-sm mb-2">
            {mode === 'signin' ? "Don't have an account?" : 'Already have an account?'}
          </p>
          <button
            onClick={() => {
              setMode(mode === 'signin' ? 'signup' : 'signin');
              setError('');
            }}
            className="text-blue-400 hover:text-blue-300 font-semibold"
          >
            {mode === 'signin' ? 'Sign Up' : 'Sign In'}
          </button>
        </div>

        {mode === 'signin' && (
          <div className="mt-6 text-center">
            <button
              onClick={() => {
                // TODO: Implement forgot password flow
                alert('Forgot password flow coming soon');
              }}
              className="text-gray-400 hover:text-gray-300 text-sm"
            >
              Forgot Password?
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
```

**Step 1.3.2.2: Update AuthScreen for mobile**

File: `apps/mobile/lib/screens/auth_screen.dart`
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';
import '../widgets/loading_spinner.dart';
import '../widgets/error_box.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authService = AuthService();
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();
  
  bool _isSignUp = false;
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
        throw Exception('Email and password required');
      }

      await _authService.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (mounted) {
        context.go('/dashboard');
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleSignUp() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      if (_emailController.text.isEmpty || 
          _passwordController.text.isEmpty ||
          _displayNameController.text.isEmpty) {
        throw Exception('All fields required');
      }

      if (_passwordController.text.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      await _authService.signUp(
        email: _emailController.text,
        password: _passwordController.text,
        displayName: _displayNameController.text,
      );

      if (mounted) {
        context.go('/dashboard');
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aevum')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              _isSignUp ? 'Create Account' : 'Sign In',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),

            // Error message
            if (_error != null)
              ErrorBox(
                error: _error!,
                onDismiss: () => setState(() => _error = null),
              ),

            // Email field
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'you@example.com',
              ),
              keyboardType: TextInputType.emailAddress,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),

            // Name field (signup only)
            if (_isSignUp) ...[
              TextField(
                controller: _displayNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'John Doe',
                ),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),
            ],

            // Password field
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: '••••••',
              ),
              obscureText: true,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 24),

            // Sign in / Sign up button
            ElevatedButton(
              onPressed: _isLoading 
                ? null 
                : (_isSignUp ? _handleSignUp : _handleSignIn),
              child: _isLoading 
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(_isSignUp ? 'Sign Up' : 'Sign In'),
            ),
            const SizedBox(height: 16),

            // Toggle sign in / sign up
            TextButton(
              onPressed: _isLoading ? null : () {
                setState(() {
                  _isSignUp = !_isSignUp;
                  _error = null;
                });
              },
              child: Text(
                _isSignUp 
                  ? 'Already have an account? Sign In'
                  : "Don't have an account? Sign Up",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Success Criteria for Task 1.3.2**:
- [ ] WelcomeScreen uses real auth (signIn, signUp methods)
- [ ] WelcomeScreen handleLogin calls useAuth().signIn()
- [ ] WelcomeScreen handleSignUp calls useAuth().signUp()
- [ ] AuthScreen (mobile) uses AuthService similarly
- [ ] Manual test: Sign up with new email → check Firestore for users/{uid} document
- [ ] Manual test: Sign in → redirected to /dashboard
- [ ] Manual test: Sign up → user created with displayName, role=user
- [ ] Manual test: Wrong password → error message shown
- [ ] Manual test: Email already exists → error message shown

---

## Sprint 1.4: Smart Scope Reduction (Days 5 - All Team) — 8 hours

**Owner**: Product Lead + All Team | **Effort**: 8 hours

### Task 1.4.1: Define 8-10 Core MVP Screens — 8 hours

**Files to Edit**:
1. `apps/web/src/App.jsx` (COMMENT OUT non-MVP routes)
2. `apps/web/src/layouts/MainLayout.jsx` (UPDATE BottomNav)
3. `apps/mobile/lib/navigation/app_router.dart` (COMMENT OUT non-MVP routes)
4. `apps/mobile/lib/widgets/heritage_bottom_nav.dart` (UPDATE to 5 items)

**KEEP in App (These 8-10 screens are MVP)**:
1. IntroPageScreen (/ route)
2. AuthScreen (/auth)
3. DashboardScreen (/dashboard)
4. FamilyTreeExplorerScreen (/dashboard/family-tree)
5. MemoriesScreen (/dashboard/memories)
6. UploadScreen (/memories/upload) *if separate*
7. HeritageMapScreen (/dashboard/heritage-map)
8. ProfileScreen (/dashboard/profile)
9. SettingsScreen (/dashboard/settings)
10. (Optional) VaultScreen (/dashboard/vault)

**REMOVE from navigation (but keep code for post-MVP)**:
- All 13 admin screens (move to post-MVP)
- All AI feature screens (SemanticDiscovery, RestoreImage, etc.)
- All messaging screens (MessengerHub, etc.)
- VisionOS spatial features (SpatialMemoryGallery, etc.)
- Any screen not in the list above

**Step 1.4.1.1: Update App.jsx routes**

In `apps/web/src/App.jsx`, comment out all non-MVP routes:

```jsx
// MVP ROUTES (Active)
<Route path="/" element={<WelcomeScreen />} />
<Route path="/auth" element={<AuthScreen />} />
<Route path="/dashboard" element={<DashboardScreen />} />
<Route path="/family-tree" element={<FamilyTreeExplorerScreen />} />
<Route path="/memories" element={<MemoriesScreen />} />
<Route path="/memories/upload" element={<UploadScreen />} />
<Route path="/heritage-map" element={<HeritageMapScreen />} />
<Route path="/profile" element={<ProfileScreen />} />
<Route path="/settings" element={<SettingsScreen />} />
{/* Settings sub-routes */}
<Route path="/settings/privacy-rules" element={<PrivacyRulesScreen />} />
<Route path="/settings/privacy-security" element={<PrivacySecurityScreen />} />
<Route path="/settings/restricted-profile/:section" element={<RestrictedProfileScreen />} />
<Route path="/settings/infrastructure" element={<InfrastructureScreen />} />
<Route path="/settings/delegation" element={<DelegationScreen />} />
<Route path="/settings/legacy-handover" element={<LegacyHandoverScreen />} />

// POST-MVP ROUTES (Commented out for now)
{/* 
<Route path="/admin" element={<AdminDashboardScreen />} />
<Route path="/admin/ai-engine" element={<AdminAIEngineScreen />} />
... more admin routes ...
<Route path="/messaging" element={<MessengerHub />} />
... more AI/messaging routes ...
*/}

<Route path="*" element={<NotFoundScreen />} />
```

**Step 1.4.1.2: Update BottomNav to 5 items**

In `apps/web/src/layouts/MainLayout.jsx` or wherever BottomNav is defined:

```jsx
function BottomNav() {
  const navigate = useNavigate();
  
  return (
    <div className="fixed bottom-0 left-0 right-0 bg-gray-800 border-t border-gray-700 flex justify-around">
      <NavItem 
        icon="🏠" 
        label="Home" 
        onClick={() => navigate('/')}
      />
      <NavItem 
        icon="👨‍👩‍👧" 
        label="Family" 
        onClick={() => navigate('/family-tree')}
      />
      <NavItem 
        icon="📸" 
        label="Memories" 
        onClick={() => navigate('/memories')}
      />
      <NavItem 
        icon="👤" 
        label="Profile" 
        onClick={() => navigate('/profile')}
      />
      <NavItem 
        icon="⚙️" 
        label="Settings" 
        onClick={() => navigate('/settings')}
      />
    </div>
  );
}
```

**Step 1.4.1.3: Update mobile GoRouter similarly**

In `apps/mobile/lib/navigation/app_router.dart`, keep only MVP routes:

```dart
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: ... ),
    GoRoute(path: '/auth', builder: ... ),
    GoRoute(
      path: '/dashboard',
      builder: ...,
      routes: [
        GoRoute(path: 'family-tree', builder: ... ),
        GoRoute(path: 'memories', builder: ... ),
        GoRoute(path: 'heritage-map', builder: ... ),
        GoRoute(path: 'profile', builder: ... ),
        GoRoute(path: 'settings', builder: ... ),
        // Comment out admin routes for now
        // GoRoute(path: 'admin', builder: ... ),
      ],
    ),
    // Admin routes commented out for post-MVP
    // GoRoute(path: '/admin', ...),
  ],
);
```

**Success Criteria for Task 1.4.1**:
- [ ] MVP route list defined (8-10 screens)
- [ ] All non-MVP routes commented out in App.jsx
- [ ] All non-MVP routes commented out in mobile GoRouter
- [ ] BottomNav shows exactly 5 items (Home, Family, Memories, Profile, Settings)
- [ ] Mobile BottomNav shows same 5 items
- [ ] Manual test: Click each BottomNav item → navigates correctly
- [ ] Manual test: Try to navigate to /admin directly → redirects (if guard in place)
- [ ] App is now more focused (8-10 screens instead of 39)

---

## Sprint 1.5: Testing & Bug Fixes (Day 5) — 8 hours

**Owner**: FED + MAD | **Effort**: 8 hours

- [ ] Manual end-to-end test of all navigation flows
- [ ] Manual test of auth flow (sign up → dashboard)
- [ ] Manual test of settings subpages
- [ ] Mobile testing on iOS simulator and/or device
- [ ] Fix any regressions from changes
- [ ] Check browser console for errors
- [ ] Check Xcode/Android console for errors

**Success Criteria for Phase 1**:
- [ ] Web navigation fully functional (no broken routes)
- [ ] Mobile navigation with GoRouter working
- [ ] Auth context has all required methods
- [ ] WelcomeScreen uses real auth
- [ ] Scope reduced to 8-10 MVP screens
- [ ] ErrorBoundary catches React errors
- [ ] NotFoundScreen shows for invalid routes
- [ ] All tests pass
- [ ] Team feels confident to move to Phase 2

---

# PHASE 2: FIREBASE INTEGRATION (Days 6-8)

_**Lead**: GDEF (Firebase Expert) | **Effort**: 48 hours | **Blocker**: HIGH_

## Sprint 2.1: Firestore Collections & Rules (GDEF Lead) — 2 days

**Owner**: Firebase Expert | **Effort**: 32 hours

### Task 2.1.1: Add Missing Collections to Security Rules — 16 hours

**File to Edit**: `firestore.rules`

File: `firestore.rules (COMPLETE REPLACEMENT)`
```codex-rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // ===== HELPER FUNCTIONS =====
    
    function isAuthenticated() {
      return request.auth != null;
    }
    
    function isOwner(resource) {
      return isAuthenticated() && resource.data.userId == request.auth.uid;
    }
    
    function isNewOwner() {
      return isAuthenticated() && request.resource.data.userId == request.auth.uid;
    }
    
    function isAdmin() {
      let userDoc = get(/databases/$(database)/documents/users/$(request.auth.uid));
      return isAuthenticated() && userDoc.data.role == 'admin';
    }
    
    function isFamilyMember(familyId) {
      // Check if user is in the family members list
      let familyDoc = get(/databases/$(database)/documents/families/$(familyId));
      return isAuthenticated() && request.auth.uid in familyDoc.data.members;
    }
    
    function isCollaborator(resource) {
      return isAuthenticated() && request.auth.uid in resource.data.collaborators;
    }
    
    function validMediaData() {
      return request.resource.data.type in ['photo', 'video', 'audio']
        && request.resource.data.familyId != null
        && request.resource.data.uploadedAt != null;
    }
    
    function validAITaskData() {
      return request.resource.data.type != null
        && request.resource.data.status in ['pending', 'processing', 'complete', 'error']
        && request.resource.data.createdAt != null;
    }
    
    // ===== USERS COLLECTION =====
    
    match /users/{userId} {
      allow read: if isAuthenticated() && userId == request.auth.uid;
      allow create: if isNewOwner();
      allow update: if isOwner(resource);
      allow delete: if isOwner(resource);
    }
    
    // ===== FAMILIES COLLECTION =====
    
    match /families/{familyId} {
      allow read: if isAuthenticated() && isFamilyMember(familyId);
      allow create: if isNewOwner();
      allow update: if isOwner(resource) || isAdmin();
      allow delete: if isOwner(resource);
    }
    
    // ===== MEMBERS COLLECTION =====
    
    match /members/{memberId} {
      allow read: if isAuthenticated();
      allow create: if isNewOwner() && isFamilyMember(request.resource.data.familyId);
      allow update: if isOwner(resource) || isAdmin();
      allow delete: if isOwner(resource) || isAdmin();
    }
    
    // ===== MEDIA ITEMS COLLECTION =====
    
    match /media_items/{mediaId} {
      allow read: if isAuthenticated() && isFamilyMember(resource.data.familyId);
      allow create: if isNewOwner() && validMediaData() && isFamilyMember(request.resource.data.familyId);
      allow update: if isOwner(resource) || isAdmin();
      allow delete: if isOwner(resource) || isAdmin();
    }
    
    // ===== AI TASKS COLLECTION =====
    
    match /ai_tasks/{taskId} {
      allow read: if isOwner(resource) || isAdmin();
      allow create: if isNewOwner() && validAITaskData();
      allow update: if isOwner(resource) || isAdmin();
      allow delete: if isOwner(resource) || isAdmin();
    }
    
    // ===== SEARCH INDEX COLLECTION =====
    
    match /search_index/{indexId} {
      allow read: if isAuthenticated();
      allow write: if isAdmin();
    }
    
    // ===== CONVERSATIONS COLLECTION =====
    
    match /conversations/{conversationId} {
      allow read: if isAuthenticated() && isThreadMember();
      allow create: if isAuthenticated();
      allow update: if isThreadMember();
      allow delete: if isThreadMember();
      
      // Messages subcollection
      match /messages/{messageId} {
        allow read: if isAuthenticated() && isThreadMember();
        allow create: if isAuthenticated() && request.resource.data.userId == request.auth.uid;
        allow update: if request.resource.data.userId == request.auth.uid;
        allow delete: if request.resource.data.userId == request.auth.uid || isAdmin();
      }
      
      function isThreadMember() {
        return request.auth.uid in resource.data.participants;
      }
    }
    
    // ===== CATALOGS COLLECTION =====
    
    match /catalogs/{catalogId} {
      allow read: if isAuthenticated();
      allow create: if isNewOwner();
      allow update: if isOwner(resource);
      allow delete: if isOwner(resource) || isAdmin();
    }
    
    // ===== ACTIVITY LOGS COLLECTION =====
    
    match /activity_logs/{logId} {
      allow read: if isOwner(resource) || isAdmin();
      allow create: if isNewOwner();
      allow delete: if isAdmin();
    }
  }
}
```

**Success Criteria for Task 2.1.1**:
- [ ] All 9 collections have security rules
- [ ] Rules validate ownership (userId checks)
- [ ] Rules validate data format (validMediaData, validAITaskData)
- [ ] Admin override works for sensitive operations
- [ ] Family member checks in place
- [ ] Rules file is syntactically correct (no parse errors)

### Task 2.1.2: Add Composite Indexes — 8 hours

**File to Edit/Create**: `firestore.indexes.json`

File: `firestore.indexes.json`
```json
{
  "indexes": [
    {
      "collectionGroup": "members",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "familyId", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "media_items",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "familyId", "order": "ASCENDING" },
        { "fieldPath": "type", "order": "ASCENDING" },
        { "fieldPath": "uploadedAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "media_items",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "familyId", "order": "ASCENDING" },
        { "fieldPath": "uploadedBy", "order": "ASCENDING" },
        { "fieldPath": "uploadedAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "ai_tasks",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "activity_logs",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "familyId", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "search_index",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "familyId", "order": "ASCENDING" },
        { "fieldPath": "vector", "order": "ASCENDING" }
      ]
    }
  ]
}
```

**Step 2.1.2.1: Deploy rules and indexes**

```bash
cd /path/to/project

# Deploy firestore rules
firebase deploy --only firestore:rules

# Deploy indexes
firebase deploy --only firestore:indexes

# Or deploy everything at once
firebase deploy
```

**Success Criteria for Task 2.1.2**:
- [ ] firestore.indexes.json file exists with 6+ indexes
- [ ] Deploy command succeeds
- [ ] Firebase Console shows all indexes as "Building" then "Enabled"
- [ ] Wait for indexes to finish building (may take several minutes)

### Task 2.1.3: Test with Firestore Emulator — 8 hours

**Step 2.1.3.1: Start Firestore emulator**

```bash
cd /path/to/project
firebase emulators:start
```

This starts emulators for:
- Firestore Database
- Realtime Database (if configured)
- Storage
- Authentication
- Cloud Functions
- Pub/Sub
- Hosting (if configured)

**Step 2.1.3.2: Connect app to emulator (development only)**

In `apps/web/src/lib/firebase.js`, update if running locally:
```javascript
import { initializeApp } from 'firebase/app';
import { getFirestore, connectFirestoreEmulator } from 'firebase/firestore';
import { getAuth, connectAuthEmulator } from 'firebase/auth';

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);
const auth = getAuth(app);

// Connect to emulator if in development
if (process.env.NODE_ENV === 'development' && window.location.hostname === 'localhost') {
  connectFirestoreEmulator(db, 'localhost', 8080);
  connectAuthEmulator(auth, 'http://localhost:9099');
}
```

**Step 2.1.3.3: Test rules with Firestore emulator IDE**

Open http://localhost:4000 (Firestore emulator IDE) and test:

1. **Test: User can create their own document**
   - Try to create `/users/{uid}` with userId == current user
   - Should succeed ✅

2. **Test: User cannot create document for another user**
   - Try to create `/users/someone-else's-id`
   - Should fail ❌

3. **Test: Media items require valid type**
   - Try to create `/media_items/{id}` with type='photo' 
   - Should succeed ✅
   - Try with type='pdf'
   - Should fail ❌

4. **Test: Family member queries**
   - User who is family member should read /families/{id}
   - User who is NOT member should get permission denied

5. **Test: Composite index queries work**
   - Query `/media_items` by familyId + type + uploadedAt
   - Should return results (indexes are built)

**Success Criteria for Task 2.1.3**:
- [ ] Firestore emulator starts without errors
- [ ] App connects to emulator (if running locally)
- [ ] Test rule validations in emulator IDE
- [ ] All 6 indexes built successfully
- [ ] Sample queries return correct results
- [ ] Rules enforce permissions correctly

---

## Sprint 2.2: Cloud Functions Stubs (CKAD Lead) — Days 7-8

**Owner**: Application Developer | **Effort**: 16 hours

### Task 2.2.1: Create Functions Directory & Dependencies — 4 hours

**Step 2.2.1.1: Initialize functions**

```bash
cd infrastructure/src/functions
npm init -y
npm install firebase-functions firebase-admin
```

**Create** `infrastructure/src/functions/package.json` (auto-created by npm init):
```json
{
  "name": "functions",
  "description": "Cloud Functions for Aevum MVP",
  "scripts": {
    "serve": "firebase emulators:start --only functions",
    "shell": "firebase functions:shell",
    "start": "npm run shell",
    "deploy": "firebase deploy --only functions",
    "logs": "firebase functions:log"
  },
  "engines": {
    "node": "18"
  },
  "main": "index.js",
  "dependencies": {
    "firebase-admin": "^12.0.0",
    "firebase-functions": "^4.5.0"
  }
}
```

**Success Criteria for Task 2.2.1**:
- [ ] package.json created with firebase-functions and firebase-admin
- [ ] node_modules installed
- [ ] Can run `firebase emulators:start`

### Task 2.2.2: Create Core Function Stubs — 12 hours

**Create** `infrastructure/src/functions/index.js`:
```javascript
const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();
const db = admin.firestore();

// ===== FIRESTORE TRIGGER FUNCTIONS =====

/**
 * Validate Family Membership on Media Upload
 * Triggered when a new media_item is created
 * Ensures user is actually a member of the family
 */
exports.validateFamilyMembership = functions.firestore
  .document('media_items/{mediaId}')
  .onCreate(async (snap, context) => {
    try {
      const data = snap.data();
      const userId = data.uploadedBy;
      const familyId = data.familyId;

      // Check if user is member of family
      const memberSnapshot = await db.collection('members')
        .where('userId', '==', userId)
        .where('familyId', '==', familyId)
        .limit(1)
        .get();

      if (memberSnapshot.empty) {
        console.error(`User ${userId} is not a member of family ${familyId}`);
        // Delete unauthorized upload
        await snap.ref.delete();
        return;
      }

      console.log(`Media item ${context.params.mediaId} validated for user ${userId}`);
    } catch (error) {
      console.error('Error validating family membership:', error);
    }
  });

/**
 * Process AI Task
 * Triggered when a new ai_task is created
 * Updates status to 'processing' and calls ML API
 */
exports.processAITask = functions.firestore
  .document('ai_tasks/{taskId}')
  .onCreate(async (snap, context) => {
    try {
      const task = snap.data();
      const taskId = context.params.taskId;

      // Update status to processing
      await snap.ref.update({
        status: 'processing',
        startedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      console.log(`Processing AI task ${taskId} of type ${task.type}`);

      // TODO: Call actual ML API here based on task.type
      // For now, just mark as complete after 5 seconds
      setTimeout(async () => {
        try {
          await snap.ref.update({
            status: 'complete',
            completedAt: admin.firestore.FieldValue.serverTimestamp(),
            result: {
              message: 'Stub result - replace with actual ML output',
            },
          });
        } catch (error) {
          console.error('Error completing AI task:', error);
        }
      }, 5000);

    } catch (error) {
      console.error('Error processing AI task:', error);
      // Try to update task with error status
      try {
        await snap.ref.update({
          status: 'error',
          error: error.message,
          completedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      } catch {} // Silently fail if update fails
    }
  });

/**
 * Notify User on Event
 * Triggered when notification doc is created
 * Sends email or push notification to user
 */
exports.notifyUser = functions.firestore
  .document('notifications/{notificationId}')
  .onCreate(async (snap, context) => {
    try {
      const notification = snap.data();
      const userId = notification.userId;

      console.log(`Sending notification to user ${userId}: ${notification.title}`);

      // TODO: Send email or push notification
      // For now, just log it
      console.log(`Notification content:`, notification.message);

    } catch (error) {
      console.error('Error sending notification:', error);
    }
  });

/**
 * Cleanup Activity Logs
 * Scheduled to run daily at 2 AM UTC
 * Deletes activity logs older than 90 days
 */
exports.cleanupActivityLogs = functions.pubsub
  .schedule('every day 02:00')
  .timeZone('UTC')
  .onRun(async (context) => {
    try {
      const ninetyDaysAgo = new Date();
      ninetyDaysAgo.setDate(ninetyDaysAgo.getDate() - 90);

      const snapshot = await db.collection('activity_logs')
        .where('createdAt', '<', ninetyDaysAgo)
        .get();

      console.log(`Found ${snapshot.size} old activity logs to delete`);

      const batch = db.batch();
      snapshot.docs.forEach(doc => {
        batch.delete(doc.ref);
      });

      await batch.commit();
      console.log(`Deleted ${snapshot.size} old activity logs`);

    } catch (error) {
      console.error('Error cleaning up activity logs:', error);
    }
  });

// ===== HTTP TRIGGER FUNCTIONS (optional) =====

/**
 * Health Check Endpoint
 * Verify functions are working
 */
exports.healthCheck = functions.https.onRequest((req, res) => {
  res.status(200).json({
    status: 'ok',
    timestamp: new Date().toISOString(),
  });
});
```

**Step 2.2.2.1: Deploy functions**

```bash
cd infrastructure/src/functions
npm run deploy

# Or from project root:
firebase deploy --only functions
```

Watch Firebase Console for deployment status.

**Success Criteria for Task 2.2.2**:
- [ ] index.js created with 5+ function stubs
- [ ] Functions syntax is valid (no parse errors)
- [ ] Deploy succeeds
- [ ] Firebase Console shows all functions deployed
- [ ] Logs visible in Firebase Console
- [ ] Functions trigger on events (for testing, create sample data)

**SUCCESS CRITERIA FOR PHASE 2**:
- [ ] firestore.rules deployed with all 9 collections
- [ ] firestore.indexes.json deployed with 6 indexes
- [ ] All indexes built successfully (check Firebase Console)
- [ ] Cloud Functions deployed
- [ ] Emulator tested locally
- [ ] One test data write succeeds, validation functions execute
- [ ] Team confident to move to Phase 3

---

# PHASE 3: STATE MANAGEMENT (Days 9-10)

_**Lead**: CKAD (App Developer) | **Effort**: 32 hours | **Blocker**: MEDIUM_

## Sprint 3.1: Zustand Store Setup (CKAD Lead)

**Owner**: Application Developer | **Effort**: 32 hours

### Task 3.1.1: Create User Store — 8 hours

**Create** `apps/web/src/store/useUserStore.js`:
```javascript
import { create } from 'zustand';
import { auth, db } from '@lib/firebase';
import { doc, getDoc, updateDoc } from 'firebase/firestore';
import { onAuthStateChanged } from 'firebase/auth';

/**
 * User Store (Zustand)
 * Manages current user's authentication and profile data
 */
export const useUserStore = create((set, get) => ({
  user: null,
  profile: null,
  loading: true,
  error: null,

  /**
   * Initialize user on app load
   * Listen for auth state changes and fetch profile
   */
  initUser: () => {
    onAuthStateChanged(auth, async (authUser) => {
      try {
        if (authUser) {
          set({ user: authUser, loading: false });

          // Fetch profile from Firestore
          const profileDoc = await getDoc(doc(db, 'users', authUser.uid));
          const profileData = profileDoc.data() || {};

          set({
            profile: {
              ...profileData,
              uid: authUser.uid,
              email: authUser.email,
            },
          });
        } else {
          set({ user: null, profile: null, loading: false });
        }
      } catch (err) {
        set({ error: err.message, loading: false });
      }
    });
  },

  /**
   * Update user profile in Firestore and local state
   */
  updateProfile: async (updates) => {
    try {
      const { user } = get();
      if (!user) throw new Error('No authenticated user');

      // Update Firestore
      await updateDoc(doc(db, 'users', user.uid), {
        ...updates,
        updatedAt: new Date(),
      });

      // Update local store
      set((state) => ({
        profile: { ...state.profile, ...updates },
      }));

      return true;
    } catch (err) {
      set({ error: err.message });
      throw err;
    }
  },

  /**
   * Clear error message
   */
  clearError: () => set({ error: null }),
}));
```

**Success Criteria for Task 3.1.1**:
- [ ] useUserStore.js created
- [ ] Store exports zustand hooks correctly
- [ ] Store has initUser, updateProfile, clearError methods
- [ ] No import errors

### Task 3.1.2: Create Family Store — 8 hours

**Create** `apps/web/src/store/useFamilyStore.js`:
```javascript
import { create } from 'zustand';
import { db } from '@lib/firebase';
import {
  collection,
  query,
  where,
  orderBy,
  getDocs,
  addDoc,
  updateDoc,
  deleteDoc,
  doc,
} from 'firebase/firestore';

/**
 * Family Store (Zustand)
 * Manages families and family members data
 */
export const useFamilyStore = create((set, get) => ({
  families: [],
  currentFamilyId: null,
  members: {},  // { familyId: [ members... ] }
  loading: false,
  error: null,

  /**
   * Fetch all families for a user
   */
  fetchFamilies: async (userId) => {
    try {
      set({ loading: true, error: null });

      const q = query(
        collection(db, 'families'),
        where('members', 'array-contains', userId),
        orderBy('createdAt', 'desc')
      );

      const snapshot = await getDocs(q);
      const families = snapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

      set({ families, loading: false });
    } catch (err) {
      set({ error: err.message, loading: false });
    }
  },

  /**
   * Fetch members of a specific family
   */
  fetchMembers: async (familyId) => {
    try {
      set({ loading: true, error: null });

      const q = query(
        collection(db, 'members'),
        where('familyId', '==', familyId),
        orderBy('createdAt', 'desc')
      );

      const snapshot = await getDocs(q);
      const memberList = snapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

      set((state) => ({
        members: {
          ...state.members,
          [familyId]: memberList,
        },
        loading: false,
      }));

      return memberList;
    } catch (err) {
      set({ error: err.message, loading: false });
    }
  },

  /**
   * Set current family context
   */
  setCurrentFamily: (familyId) => {
    set({ currentFamilyId: familyId });
    // Auto-fetch members when family changes
    get().fetchMembers(familyId);
  },

  /**
   * Add new member to family
   */
  addMember: async (familyId, memberData) => {
    try {
      set({ error: null });

      const docRef = await addDoc(collection(db, 'members'), {
        ...memberData,
        familyId,
        createdAt: new Date(),
      });

      // Update local members list
      set((state) => ({
        members: {
          ...state.members,
          [familyId]: [
            { id: docRef.id, ...memberData, familyId, createdAt: new Date() },
            ...(state.members[familyId] || []),
          ],
        },
      }));

      return docRef.id;
    } catch (err) {
      set({ error: err.message });
      throw err;
    }
  },

  /**
   * Clear error message
   */
  clearError: () => set({ error: null }),
}));
```

**Success Criteria for Task 3.1.2**:
- [ ] useFamilyStore.js created
- [ ] Store has fetchFamilies, fetchMembers, setCurrentFamily, addMember
- [ ] Store manages members indexed by familyId
- [ ] No import errors

### Task 3.1.3: Create Media Store — 8 hours

**Create** `apps/web/src/store/useMediaStore.js`:
```javascript
import { create } from 'zustand';
import { db, storage } from '@lib/firebase';
import {
  collection,
  query,
  where,
  orderBy,
  getDocs,
  addDoc,
  deleteDoc,
  doc,
} from 'firebase/firestore';
import { ref, uploadBytes, getDownloadURL } from 'firebase/storage';

/**
 * Media Store (Zustand)
 * Manages media items (photos, videos, audio) for families
 */
export const useMediaStore = create((set, get) => ({
  mediaItems: {},  // { familyId: [ media... ] }
  loading: false,
  error: null,
  uploadProgress: 0,

  /**
   * Fetch media items for a family
   */
  fetchMedia: async (familyId, limit = 50) => {
    try {
      set({ loading: true, error: null });

      const q = query(
        collection(db, 'media_items'),
        where('familyId', '==', familyId),
        orderBy('uploadedAt', 'desc')
      );

      const snapshot = await getDocs(q);
      const items = snapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

      set((state) => ({
        mediaItems: {
          ...state.mediaItems,
          [familyId]: items,
        },
        loading: false,
      }));

      return items;
    } catch (err) {
      set({ error: err.message, loading: false });
    }
  },

  /**
   * Upload media file to Cloud Storage and create media_item doc
   */
  uploadMedia: async (familyId, userId, file, metadata = {}) => {
    try {
      set({ error: null, uploadProgress: 0 });

      // Upload file to Cloud Storage
      const storageRef = ref(
        storage,
        `families/${familyId}/${file.name}-${Date.now()}`
      );

      const snapshot = await uploadBytes(storageRef, file);
      const downloadURL = await getDownloadURL(snapshot.ref);

      // Create Firestore document
      const docRef = await addDoc(collection(db, 'media_items'), {
        familyId,
        uploadedBy: userId,
        fileName: file.name,
        fileSize: file.size,
        mimeType: file.type,
        type: _inferMediaType(file.type),
        url: downloadURL,
        uploadedAt: new Date(),
        ...metadata,
      });

      // Update local store
      set((state) => ({
        mediaItems: {
          ...state.mediaItems,
          [familyId]: [
            {
              id: docRef.id,
              familyId,
              uploadedBy: userId,
              fileName: file.name,
              fileSize: file.size,
              mimeType: file.type,
              type: _inferMediaType(file.type),
              url: downloadURL,
              uploadedAt: new Date(),
              ...metadata,
            },
            ...(state.mediaItems[familyId] || []),
          ],
        },
        uploadProgress: 100,
      }));

      return {
        id: docRef.id,
        url: downloadURL,
      };
    } catch (err) {
      set({ error: err.message });
      throw err;
    }
  },

  /**
   * Delete media item
   */
  deleteMedia: async (familyId, mediaId) => {
    try {
      set({ error: null });

      await deleteDoc(doc(db, 'media_items', mediaId));

      // Update local store
      set((state) => ({
        mediaItems: {
          ...state.mediaItems,
          [familyId]: (state.mediaItems[familyId] || []).filter(
            (item) => item.id !== mediaId
          ),
        },
      }));

      return true;
    } catch (err) {
      set({ error: err.message });
      throw err;
    }
  },

  /**
   * Clear error message
   */
  clearError: () => set({ error: null }),
}));

/**
 * Helper: Infer media type from MIME type
 */
function _inferMediaType(mimeType) {
  if (mimeType.startsWith('image/')) return 'photo';
  if (mimeType.startsWith('video/')) return 'video';
  if (mimeType.startsWith('audio/')) return 'audio';
  return 'other';
}
```

**Success Criteria for Task 3.1.3**:
- [ ] useMediaStore.js created
- [ ] Store has fetchMedia, uploadMedia, deleteMedia methods
- [ ] Media items indexed by familyId
- [ ] No import errors

### Task 3.1.4: Refactor Screens to Use Stores — 8 hours

**Update** `apps/web/src/screens/DashboardScreen.jsx`:

**Before**:
```jsx
const [families, setFamilies] = useState([]);
const [loading, setLoading] = useState(true);

useEffect(() => {
  const fetchFamilies = async () => {
    setLoading(true);
    try {
      const snap = await db.collection('families').get();
      setFamilies(snap.docs.map(doc => ({ id: doc.id, ...doc.data() })));
    } finally {
      setLoading(false);
    }
  };
  fetchFamilies();
}, [user]);
```

**After**:
```jsx
import { useFamilyStore } from '@store/useFamilyStore';
import { useUserStore } from '@store/useUserStore';

const { families, loading, fetchFamilies } = useFamilyStore();
const { user } = useUserStore();

useEffect(() => {
  if (user?.uid) {
    fetchFamilies(user.uid);
  }
}, [user?.uid, fetchFamilies]);
```

**Update** `apps/web/src/screens/MemoriesScreen.jsx`:

**Before**:
```jsx
const [media, setMedia] = useState([]);
useEffect(() => {
  db.collection('media_items')
    .where('familyId', '==', familyId)
    .orderBy('uploadedAt', 'desc')
    .get()
    .then(snap => setMedia(snap.docs.map(...)));
}, [familyId]);
```

**After**:
```jsx
import { useMediaStore } from '@store/useMediaStore';

const { mediaItems, loading, fetchMedia } = useMediaStore();
const media = mediaItems[familyId] || [];

useEffect(() => {
  fetchMedia(familyId);
}, [familyId, fetchMedia]);
```

**Update** `apps/web/src/screens/UploadScreen.jsx` (if separate screen):

```jsx
import { useMediaStore } from '@store/useMediaStore';
import { useUserStore } from '@store/useUserStore';

const { uploadMedia, uploadProgress, error } = useMediaStore();
const { user, profile } = useUserStore();
const { currentFamilyId } = useFamilyStore();

const handleUpload = async (file) => {
  try {
    const result = await uploadMedia(currentFamilyId, user.uid, file);
    console.log('Upload complete:', result);
  } catch (err) {
    console.error('Upload failed:', err);
  }
};
```

**Success Criteria for Task 3.1.4**:
- [ ] DashboardScreen uses useFamilyStore
- [ ] MemoriesScreen uses useMediaStore
- [ ] UploadScreen uses useMediaStore.uploadMedia()
- [ ] FamilyTreeScreen uses useFamilyStore for members
- [ ] ProfileScreen uses useUserStore
- [ ] No prop drilling between screens
- [ ] All screens render without errors
- [ ] Stores persist across screen transitions

**SUCCESS CRITERIA FOR PHASE 3**:
- [ ] 3 Zustand stores created (User, Family, Media)
- [ ] All stores export hooks correctly
- [ ] 5+ screens refactored to use stores
- [ ] No prop drilling
- [ ] No duplicate useState for data
- [ ] Data fetched once, shared across app
- [ ] Team ready to move to Phase 4

---

# PHASE 4: COMPONENT LIBRARY & DESIGN SYSTEM (Days 11-12)

_**Lead**: FED | **Effort**: 32 hours | **Blocker**: MEDIUM_

## Sprint 4.1: Component Library v1 — 1 day

**Owner**: Frontend & DevOps Engineer | **Effort**: 16 hours

### Task 4.1.1: Create Reusable UI Components — 8 hours

**Create** `apps/web/src/components/ui/Button.jsx`:
```jsx
/**
 * Reusable Button Component
 * Variants: primary, secondary, ghost
 * Sizes: sm, md, lg
 */
export function Button({ 
  children, 
  variant = 'primary',
  size = 'md',
  disabled = false,
  className = '',
  ...props 
}) {
  const baseClass = 'rounded font-semibold transition disabled:opacity-50 disabled:cursor-not-allowed';
  
  const variants = {
    primary: 'bg-blue-500 text-white hover:bg-blue-600 active:bg-blue-700',
    secondary: 'bg-gray-700 text-white hover:bg-gray-800 active:bg-gray-900',
    ghost: 'bg-transparent border border-white/30 text-white hover:bg-white/10 active:bg-white/20',
  };
  
  const sizes = {
    sm: 'px-2 py-1 text-sm',
    md: 'px-4 py-2 text-base',
    lg: 'px-6 py-3 text-lg',
  };
  
  const classes = `${baseClass} ${variants[variant]} ${sizes[size]} ${className}`;
  
  return (
    <button 
      className={classes}
      disabled={disabled}
      {...props}
    >
      {children}
    </button>
  );
}
```

**Create** `apps/web/src/components/ui/Card.jsx`:
```jsx
/**
 * Reusable Card Component
 * Simple container with dark background and border
 */
export function Card({ children, className = '', ...props }) {
  return (
    <div 
      className={`bg-gray-800 rounded-lg p-4 border border-gray-700 ${className}`}
      {...props}
    >
      {children}
    </div>
  );
}
```

**Create** `apps/web/src/components/ui/Input.jsx`:
```jsx
/**
 * Reusable Input Component
 * Supports label, error, placeholder, type, disabled
 */
export function Input({ 
  label, 
  error, 
  className = '',
  ...props 
}) {
  return (
    <div className="flex flex-col gap-2">
      {label && (
        <label className="text-sm font-medium text-gray-300">
          {label}
        </label>
      )}
      <input
        className={`bg-gray-800 border border-gray-700 rounded px-3 py-2 text-white 
          focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500/20
          disabled:opacity-50 disabled:cursor-not-allowed
          ${className}`}
        {...props}
      />
      {error && (
        <p className="text-red-400 text-sm">{error}</p>
      )}
    </div>
  );
}
```

**Create** `apps/web/src/components/ui/Modal.jsx`:
```jsx
import { useEffect } from 'react';

/**
 * Reusable Modal Component
 * Display content in overlay with title and close button
 */
export function Modal({ 
  isOpen, 
  onClose, 
  title, 
  children,
  size = 'md',
  closeOnEsc = true,
}) {
  useEffect(() => {
    if (!isOpen || !closeOnEsc) return;

    const handleEsc = (e) => {
      if (e.key === 'Escape') onClose();
    };

    document.addEventListener('keydown', handleEsc);
    return () => document.removeEventListener('keydown', handleEsc);
  }, [isOpen, closeOnEsc, onClose]);

  if (!isOpen) return null;

  const sizes = {
    sm: 'max-w-sm',
    md: 'max-w-md',
    lg: 'max-w-lg',
    xl: 'max-w-2xl',
  };

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <div className={`bg-gray-900 rounded-lg p-6 border border-gray-700 w-full ${sizes[size]}`}>
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-xl font-bold text-white">{title}</h2>
          <button
            onClick={onClose}
            className="text-gray-400 hover:text-white transition text-2xl leading-none"
            aria-label="Close"
          >
            ✕
          </button>
        </div>
        <div className="text-gray-300">
          {children}
        </div>
      </div>
    </div>
  );
}
```

**Create** `apps/web/src/components/ui/Badge.jsx`:
```jsx
/**
 * Reusable Badge Component
 * Small label component for status or tags
 */
export function Badge({ 
  children, 
  variant = 'default',
  className = '',
  ...props 
}) {
  const variants = {
    default: 'bg-gray-700 text-gray-100',
    success: 'bg-green-700 text-green-100',
    error: 'bg-red-700 text-red-100',
    warning: 'bg-yellow-700 text-yellow-100',
    info: 'bg-blue-700 text-blue-100',
  };
  
  return (
    <span 
      className={`px-2 py-1 rounded-full text-xs font-semibold ${variants[variant]} ${className}`}
      {...props}
    >
      {children}
    </span>
  );
}
```

**Create** `apps/web/src/components/ui/index.js`:
```javascript
// Central export for all UI components
export { Button } from './Button';
export { Card } from './Card';
export { Input } from './Input';
export { Modal } from './Modal';
export { Badge } from './Badge';
```

**Success Criteria for Task 4.1.1**:
- [ ] All 5 components created (Button, Card, Input, Modal, Badge)
- [ ] index.js exports all components
- [ ] Components have documentation
- [ ] No import errors when used in screens

### Task 4.1.2: Refactor Screens to Use Components — 8 hours

**Update** `apps/web/src/screens/DashboardScreen.jsx`:

**Replace inline buttons with:**
```jsx
import { Button } from '@components/ui/Button';
import { Card } from '@components/ui/Card';

// Use reusable components:
<Button variant="primary">Add Family</Button>
<Button variant="secondary" size="sm">Edit</Button>

<Card>
  <h3>{family.name}</h3>
  <p>{family.description}</p>
</Card>
```

**Update similar in**:
- MemoriesScreen.jsx (use Card for photo gallery items)
- FamilyTreeScreen.jsx (use Button + Card)
- SettingsScreen.jsx (use Input + Button)
- ProfileScreen.jsx (use Card + Input + Button)

**Success Criteria for Task 4.1.2**:
- [ ] DashboardScreen uses 5+ reuseable components
- [ ] MemoriesScreen uses Card for items
- [ ] SettingsScreen uses Input + Button
- [ ] ProfileScreen uses Card + Input + Button
- [ ] Removed 80%+ of inline button/card styles
- [ ] All screens still render correctly
- [ ] Design is now consistent across app

---

## Sprint 4.2: Light Mode & Theme Toggle — 0.5 day

**Owner**: Frontend & DevOps Engineer | **Effort**: 8 hours

### Task 4.2.1: Implement Theme Toggle in Settings — 4 hours

**Update** `apps/web/src/screens/SettingsScreen.jsx`:

```jsx
import { useEffect, useState } from 'react';
import { Button } from '@components/ui/Button';

export default function SettingsScreen() {
  const [theme, setTheme] = useState(
    () => localStorage.getItem('theme') || 'dark'
  );

  useEffect(() => {
    // Apply theme to document
    const html = document.documentElement;
    if (theme === 'dark') {
      html.classList.add('dark');
    } else {
      html.classList.remove('dark');
    }
    // Persist preference
    localStorage.setItem('theme', theme);
  }, [theme]);

  const toggleTheme = () => {
    setTheme((current) => (current === 'dark' ? 'light' : 'dark'));
  };

  return (
    <div className="settings-container space-y-6">
      <h1 className="text-2xl font-bold">Settings</h1>

      {/* Theme Section */}
      <div className="setting-section">
        <h2 className="text-lg font-semibold mb-4">Appearance</h2>
        <div className="flex items-center justify-between">
          <div>
            <p className="text-sm text-gray-300">Theme</p>
            <p className="text-xs text-gray-500">
              {theme === 'dark' ? '🌙 Dark Mode' : '☀️ Light Mode'}
            </p>
          </div>
          <Button variant="secondary" onClick={toggleTheme}>
            Switch to {theme === 'dark' ? 'Light' : 'Dark'}
          </Button>
        </div>
      </div>

      {/* ... more settings ... */}
    </div>
  );
}
```

**Success Criteria for Task 4.2.1**:
- [ ] Theme toggle button visible in SettingsScreen
- [ ] Clicking toggles between dark and light mode
- [ ] Theme persists in localStorage
- [ ] Theme applies to document root

### Task 4.2.2: Update Tailwind Config for Light Mode — 4 hours

**Update** `apps/web/tailwind.config.js`:

```javascript
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  darkMode: 'class', // Enable dark mode via class
  theme: {
    extend: {
      colors: {
        // Light mode overrides (apply when not in dark mode)
      },
    },
  },
  plugins: [],
};
```

**Update color classes in screens** - Change from:
```jsx
<div className="bg-gray-900 text-white">
```

To support both modes:
```jsx
<div className="bg-white dark:bg-gray-900 text-black dark:text-white">
```

Apply to all major screens:
- DashboardScreen
- MemoriesScreen
- SettingsScreen
- ProfileScreen

**Success Criteria for Task 4.2.2**:
- [ ] tailwind darkMode: 'class' configured
- [ ] All colors updated to support light/dark (bg-white dark:bg-gray-900)
- [ ] Light mode is readable (not white-on-white)
- [ ] Dark mode still looks good
- [ ] Manual test: toggle theme → UI adapts

**SUCCESS CRITERIA FOR PHASE 4**:
- [ ] 5 reusable UI components created
- [ ] 5+ screens refactored to use components
- [ ] Theme toggle in SettingsScreen works
- [ ] Light and dark modes both readable
- [ ] Design is now consistent
- [ ] Team ready to move to Phase 5

---

# PHASE 5: ERROR HANDLING & LOADING STATES (Day 13)

_**Lead**: FED | **Effort**: 16 hours | **Blocker**: MEDIUM_

## Sprint 5.1: Loading & Error Components — 1 day

**Owner**: Frontend & DevOps Engineer | **Effort**: 16 hours

### Task 5.1.1: Create Loading & Error Components — 8 hours

**Create** `apps/web/src/components/LoadingSpinner.jsx`:
```jsx
/**
 * Loading Spinner Component
 * Shows animated spinner while loading
 */
export function LoadingSpinner() {
  return (
    <div className="flex items-center justify-center py-8">
      <div className="relative w-12 h-12">
        <div className="absolute inset-0 rounded-full border-4 border-gray-700"></div>
        <div className="absolute inset-0 rounded-full border-4 border-transparent border-t-blue-500 animate-spin"></div>
      </div>
    </div>
  );
}
```

**Create** `apps/web/src/components/ErrorBox.jsx`:
```jsx
import { Button } from '@components/ui/Button';

/**
 * Error Box Component
 * Shows error message with retry option
 */
export function ErrorBox({ error, onRetry }) {
  return (
    <div className="bg-red-500/20 border border-red-500 border-opacity-30 rounded-lg p-4 my-4">
      <div className="flex items-start gap-4">
        <div className="text-red-500 text-xl leading-none mt-0.5">⚠️</div>
        <div className="flex-1 min-w-0">
          <p className="text-red-200 font-semibold">Error</p>
          <p className="text-red-100 text-sm mt-1 break-words">{error}</p>
        </div>
      </div>
      {onRetry && (
        <div className="mt-4">
          <Button 
            variant="secondary" 
            size="sm"
            onClick={onRetry}
          >
            Try Again
          </Button>
        </div>
      )}
    </div>
  );
}
```

**Success Criteria for Task 5.1.1**:
- [ ] LoadingSpinner.jsx created
- [ ] ErrorBox.jsx created
- [ ] Both components export correctly
- [ ] No import errors

### Task 5.1.2: Update Data-Fetching Screens — 8 hours

**Update** `apps/web/src/screens/MemoriesScreen.jsx`:

```jsx
import { useEffect } from 'react';
import { useMediaStore } from '@store/useMediaStore';
import { useFamilyStore } from '@store/useFamilyStore';
import { LoadingSpinner } from '@components/LoadingSpinner';
import { ErrorBox } from '@components/ErrorBox';
import { Card } from '@components/ui/Card';

export default function MemoriesScreen() {
  const { currentFamilyId } = useFamilyStore();
  const { mediaItems, loading, error, fetchMedia } = useMediaStore();
  
  const media = mediaItems[currentFamilyId] || [];

  useEffect(() => {
    if (currentFamilyId) {
      fetchMedia(currentFamilyId);
    }
  }, [currentFamilyId, fetchMedia]);

  return (
    <div className="memories-screen p-6">
      <h1 className="text-2xl font-bold mb-6">Memories</h1>

      {/* Loading State */}
      {loading && <LoadingSpinner />}

      {/* Error State */}
      {error && !loading && (
        <ErrorBox 
          error={error}
          onRetry={() => fetchMedia(currentFamilyId)}
        />
      )}

      {/* Content State */}
      {!loading && !error && (
        <>
          {media.length === 0 ? (
            <Card>
              <p className="text-gray-400">No memories yet. Upload some photos!</p>
            </Card>
          ) : (
            <div className="grid grid-cols-3 gap-4">
              {media.map((item) => (
                <Card key={item.id} className="cursor-pointer hover:opacity-80">
                  <div className="aspect-square bg-gray-700 rounded mb-2"></div>
                  <p className="text-sm text-gray-300 truncate">{item.fileName}</p>
                </Card>
              ))}
            </div>
          )}
        </>
      )}
    </div>
  );
}
```

**Do same for**:
- FamilyTreeScreen.jsx
- DashboardScreen.jsx
- UploadScreen.jsx
- Any screen that fetches data

**Pattern**:
1. Track `loading` and `error` from store
2. Show LoadingSpinner while loading
3. Show ErrorBox if error (with onRetry)
4. Show content if !loading && !error

**Success Criteria for Task 5.1.2**:
- [ ] MemoriesScreen shows LoadingSpinner while fetching
- [ ] Shows ErrorBox if fetch fails
- [ ] Shows content when fetch succeeds
- [ ] Manual test: Loading states visible
- [ ] Manual test: Error state shows retry button
- [ ] Manual test: No blank screens

**SUCCESS CRITERIA FOR PHASE 5**:
- [ ] LoadingSpinner component created
- [ ] ErrorBox component created
- [ ] 5+ screens updated with error/loading states
- [ ] No more blank screens on errors
- [ ] Team confident in error handling

---

# PRE-LAUNCH VERIFICATION CHECKLIST (Day 14)

_**All Team** | **Effort**: 24 hours_

## Functionality Verification

### Auth Flow
- [ ] **Sign Up**: Create account → user appears in Firestore → can log in
- [ ] **Sign In**: Email + password works
- [ ] **Sign Out**: User cleared from state
- [ ] **Password Reset**: Email sent (check Firestore emulator logs)
- [ ] **Error Messages**: Show when email exists, password weak, etc.

### Navigation
- [ ] **BottomNav**: All 5 items clickable
- [ ] **Settings**:  All 6 subpages reachable
  - [ ] /settings/privacy-rules — works
  - [ ] /settings/privacy-security — works
  - [ ] /settings/restricted-profile/demo — works
  - [ ] /settings/infrastructure — works
  - [ ] /settings/delegation — works
  - [ ] /settings/legacy-handover — works
- [ ] **Back Button**: Works on all screens
- [ ] **404 Page**: Shows for invalid routes
- [ ] **Deep Links**: `aevum://dashboard/memories` opens correct screen

### Data Persistence
- [ ] **Sign Up**: User doc created in Firestore
- [ ] **Upload Photo**: File in Cloud Storage, doc in Firestore
- [ ] **Add Member**: Member appears in family
- [ ] **Reload App**: Data still present (persisted)
- [ ] **Multi-device**: Data syncs across browsers

### Error Handling
- [ ] **Network Error**: Shows error message (not blank)
- [ ] **Retry Button**: Clicking retries the request
- [ ] **React Error**: Caught by ErrorBoundary (not white screen)
- [ ] **Invalid Route**: Shows NotFoundScreen

### Firebase
- [ ] **Rules Deployed**: firestore rules show in Console
- [ ] **Indexes Deployed**: All 6 indexes built (watch Console)
- [ ] **Functions Deployed**: All functions in Console
- [ ] **Emulator Tested**: Local emulator works, queries succeed

### Performance
- [ ] **Lighthouse**: Run audit on each screen
  - [ ] DashboardScreen: >80 score
  - [ ] MemoriesScreen: >80 score
  - [ ] SettingsScreen: >80 score
- [ ] **Load Time**: App starts in <3 seconds
- [ ] **Images**: Optimized (use webp where possible)
- [ ] **Bundle Size**: Check with `npm run build` + analyzer

### Accessibility
- [ ] **Light Mode**: Text readable in light mode
- [ ] **Contrast**: Colors meet WCAG AA (use contrast checker)
- [ ] **Keyboard Navigation**: Tab through inputs works
- [ ] **Screen Reader**: Basic VoiceOver/NVDA test

### Security
- [ ] **No Credentials**: No API keys in code
- [ ] **Firebase Rules**: Tested for injection attacks
- [ ] **HTTPS**: Production URL uses HTTPS
- [ ] **Environment Variables**: Configured via .env

---

## Sign-Off Checklist

- [ ] All 5 phases complete
- [ ] All tasks tested and working
- [ ] All team members sign-off on quality
- [ ] No critical bugs remaining
- [ ] Documentation updated
- [ ] Ready for TestFlight/App Store submission

---

# KNOWLEDGE BASES & CLEANUP PLAN

## Knowledge Bases to KEEP (Rename with 3-word strict convention)

| Current Name | New Name | Purpose |
|---|---|---|
| FVM.md | Flutter-Version-Management | Setup guide for Flutter 3.41.0 |
| AGENTS.md | AI-Agents-Personas | Persona reference (FED, MAD, GDEF, CKAD, CKA, KCS) |
| design-spec.md | Design-System-Specification | UI/UX standards, colors, typography |
| walkthrough.md | Feature-Walkthrough-Guide | User feature documentation |
| implementation_plan.md | Implementation-Planning-Reference | Architecture overview |

**Action**: Rename these 5 files in docs/ with strict AREA-SPECIALTY-PURPOSE pattern

## Documents to DELETE (After consolidation proven working)

After TODO.md is active and team is executing tasks, delete:

- [ ] docs/REAL_FINDINGS.md (all content in TODO Background)
- [ ] docs/MVP-ACTION-PLAN.md (all phases in TODO Phases 1-5)
- [ ] docs/PERSONA-ASSIGNMENTS.md (all tasks in TODO tasks)
- [ ] docs/BROKEN-LINKS-REFERENCE.md (all fixes in TODO Phase 1)
- [ ] docs/LEADERSHIP-SUMMARY.md (all metrics in TODO end)
- [ ] docs/AUDIT-REPORT-INDEX.md (superseded by this TODO)

**Timeline**: Delete after Feb 20 standup (end of Week 1, once critical fixes proven)

## Documents to MOVE to Root (Unclear next steps)

User review and decide fate of each:

- [ ] docs/ARCH-PIVOT-HOSTED.md (obsolete architectural decision?)
- [ ] docs/FRAMEWORK-PIVOT-FLUTTER.md (framework choice documented?)
- [ ] docs/STRATEGY-STORAGE-AI.md (post-MVP AI strategy, keep for reference)
- [ ] docs/MIGRATION-LOG.md (historical migration notes, archive?)
- [ ] docs/APP-FLOW-AUDIT.md (superseded by phase verification?)
- [ ] docs/task.md (original task doc, consolidate or delete?)
- [ ] docs/FINDINGS.md (previous team's findings, keep for comparison?)
- [ ] docs/screens-inventory.md (reference doc, update or delete?)
- [ ] docs/mapping.md (architecture mapping, still relevant?)
- [ ] docs/user-flow.md (product spec, update or reference?)
- [ ] docs/stitch-export-workflow.md (Stitch integration post-MVP)

**Timeline**: Move to root by Feb 15 for user review

## Baselines to KEEP

✅ Keep all `docs/baselines/` subdirectories:
- admin/
- ai-features/
- auth/
- catalog/
- family-tree/
- heritage-map/
- identity/
- memories/
- onboarding/
- other/
- settings/

These are design reference assets, not action documents.

---

## SUCCESS METRICS — END OF 2-WEEK SPRINT (Feb 27)

### By End of Week 1 (Feb 20) ✅

- [ ] Phase 1 complete: Navigation fixed (web + mobile)
- [ ] No broken routes, 404 page shows
- [ ] Auth works: sign up, sign in, sign out
- [ ] MVP scope: 8-10 screens only
- [ ] ErrorBoundary catches React errors
- [ ] Firebase rules deployed
- [ ] Daily standup held (4x)

### By End of Week 2 (Feb 27) ✅

- [ ] Phase 2 complete: Firebase fully integrated
- [ ] All collections have rules, all indexes built
- [ ] Cloud Functions deployed
- [ ] Phase 3 complete: Zustand stores working
- [ ] 5+ screens using global state (no prop drilling)
- [ ] Phase 4 complete: Component library + light mode
- [ ] Phase 5 complete: Error/loading states on all screens
- [ ] Pre-launch verification: All checklist items pass
- [ ] ReadyforTestFlight (iOS) / App Store Beta (Android)
- [ ] Team sign-off: MVP is ready to ship

### Success Means

✅ **Users can sign up and log in**  
✅ **Users can navigate all 8-10 core screens**  
✅ **Users can upload and view photos**  
✅ **Data persists in Firestore**  
✅ **Errors show messages (no blank screens)**  
✅ **App works in light and dark modes**  
✅ **Performance acceptable (Lighthouse >80)**  
✅ **Ready for public beta**

---

# TEAM EXECUTION GUIDE

## Daily Standup (9 AM PST)

**Agenda**: 15 minutes, all 6 personas
- **Each person** (2 min): Completed yesterday, in progress today, blockers
- **Blocker triage** (5 min): Resolve if possible, escalate if not
- **Plan day** (3 min): Confirm today's tasks, assign leads

**Format**:
```
[FED]: Yesterday - Task X done.review ready. Today - Task Y start. Blocker - Need GDEF to deploy rules.
[MAD]: Yesterday - GoRouter 50% done. Today - Finish GoRouter, start deep linking. No blockers.
[GDEF]: Yesterday - Nothing yet (day 6). Today - Start firestore rules. No blockers.
... etc
```

## Sprint Reviews (Friday 4 PM PST)

**End of Week 1 (Feb 20)**: Phase 1 review
- Demo new routes working
- Demo auth flow
- Demo ErrorBoundary
- Celebrate wins
- Plan Week 2 adjustments

**End of Week 2 (Feb 27)**: MVP launch prep
- Demo all 8-10 screens
- Demo Firebase integration
- Demo light mode
- Demo error handling
- Sign-off on quality
- Plan post-MVP roadmap

---

**Document Version**: 2.0  
**Last Updated**: February 13, 2026  
**Status**: PRODUCTION READY - Team ready to execute  
**Next Step**: Daily standup at 9 AM PST tomorrow (Feb 14)

---

_Consolidated from MVP-ACTION-PLAN.md, PERSONA-ASSIGNMENTS.md, BROKEN-LINKS-REFERENCE.md, REAL_FINDINGS.md, LEADERSHIP-SUMMARY.md, AUDIT-REPORT-INDEX.md. This document is the single source of truth for the 2-week MVP sprint. All other docs are reference only and will be cleaned up after consolidation confirmed._
