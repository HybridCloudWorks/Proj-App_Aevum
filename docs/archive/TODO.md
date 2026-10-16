# 🚀 AEVUM MVP - 2-WEEK SPRINT (Feb 13-27, 2026)

**Status**: 🔴 CRITICAL - MVP Not Ready | Leadership Approved 2-Week Fix Sprint  
**Team**: FED (1.0 FTE), MAD (0.8), GDEF (0.5), CKAD (0.5), CKA (0.3), KCS (0.3)  
**Total Effort**: 252 person-hours | **Goal**: Ship to TestFlight/App Store beta by Feb 27  
**Last Updated**: February 13, 2026 | **Status**: READY FOR SPRINT PLANNING

---

## ⚡ QUICK NAVIGATION

- [Executive Summary](#executive-summary) - 9 blockers and why we need this 2-week fix
- [Phase 1: Critical Fixes (Days 1-5)](#phase-1--critical-fixes-days-1-5) - Navigation, Auth, Firebase
- [Phase 2: Firebase Integration (Days 6-8)](#phase-2--firebase-integration-days-6-8) - Security rules, indexes, functions
- [Phase 3: State Management (Days 9-10)](#phase-3--state-management-days-9-10) - Zustand stores
- [Phase 4: Component Library (Days 11-12)](#phase-4--component-library--design-system-days-11-12) - Reusable components, light mode
- [Phase 5: Error Handling (Day 13)](#phase-5--error-handling--loading-states-day-13) - Loading and error states
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
- **Code Location**: apps/web/src/App.jsx (needs route registry), apps/mobile/lib/main.dart (needs GoRouter)

**BLOCKER #2: Auth System Missing**
- Login form doesn't actually call Firebase auth methods
- No SignUp, SignIn, SignOut, ResetPassword methods in code
- AuthContext is a skeleton with only { user, loading, error, isAuthenticated }
- **Impact**: App cannot authenticate any real users
- **Fix Effort**: 1 day (FED)
- **Code Location**: apps/web/src/contexts/AuthContext.jsx (needs full implementation)

**BLOCKER #3: Firebase Rules Incomplete**
- Only 4 collections have rules (users, members, families, media_items)
- Missing: ai_tasks, search_index, conversations, catalogs, activity_logs
- No composite indexes (only 2, app needs 5+)
- **Impact**: Data loss/corruption, performance queries fail
- **Fix Effort**: 2 days (GDEF)
- **Code Location**: firestore.rules, firestore.indexes.json

**BLOCKER #4: Admin Features Unreachable**
- 13 admin screens exist but no UI path connects to them
- DashboardScreen doesn't link to /admin route
- BottomNav has hardcoded 5 items, no admin option
- **Impact**: Admin controls only accessible to developers
- **Fix Effort**: 1 day (included in Phase 1 navigation)
- **Code Location**: apps/web/src/layouts/MainLayout.jsx (BottomNav), apps/mobile/lib/widgets/

**BLOCKER #5: Error Handling Absent**
- One network error = blank white screen (no error boundary)
- No loading states on data-fetching screens
- No error messages (users don't know what went wrong)
- **Impact**: Users think app is broken when servers are down
- **Fix Effort**: 1 day (FED)
- **Code Location**: apps/web/src/components/ (needs ErrorBoundary, LoadingSpinner), app wrapper

**BLOCKER #6: Component Library Missing**
- 50+ duplicate Button and Card implementations
- Updating styling requires editing 50+ files
- Design inconsistency (4 different "glass blur" values)
- **Impact**: Impossible to maintain visual consistency, slow iterations
- **Fix Effort**: 1.5 days (FED)
- **Code Location**: apps/web/src/components/ui/ (needs central component lib)

**BLOCKER #7: State Management Ignored**
- Zustand installed in package.json but never imported
- Every screen manages its own useState duplicates data fetches
- No global caching or normalization
- **Impact**: App is slow, battery draining, duplicate API calls
- **Fix Effort**: 2 days (CKAD)
- **Code Location**: apps/web/src/store/ (needs useUserStore, useFamilyStore, useMediaStore)

**BLOCKER #8: Firebase Configuration Incomplete**
- Only 2 Firestore composite indexes (app needs 5+)
- Missing indexes cause queries to fail at scale
- No Cloud Functions for data validation
- **Impact**: Performance degradation as users grow
- **Fix Effort**: 1 day (GDEF, included in Phase 2)
- **Code Location**: firestore.indexes.json, infrastructure/src/functions/

**BLOCKER #9: Design System Broken**
- Dark mode only; light mode would render white text on white
- No theme toggle
- Design tokens scattered in individual screens
- **Impact**: Can't ship light mode variant, inconsistent design
- **Fix Effort**: 1 day (FED, included in Phase 4)
- **Code Location**: apps/web/src/screens/, tailwind.config.js

---

# PHASE 1 — CRITICAL FIXES (Days 1-5)

_Goal: Solidify the core UI framework, accessibility, and cross-browser stability._

- [x] **CSS Compatibility (Critical)**
  - [x] Fix `backdrop-filter` vendor prefixing and property order globally.
  - [x] Standardize scrollbar hiding using `tailwind-scrollbar-hide` plugin.
  - [x] Remove local CSS hacks in favor of global utilities.
- [x] **Collection Standardization**
  - [x] Consolidate `family_members` (mobile) into top-level `members`.
  - [x] Consolidate `memories` into `media_items`.
- [x] **Light Mode Foundation**
  - [x] Locked "Summer Garden Party" visual style for Light Mode.
- [ ] **Mobile Safe Area (Urgent)**
  - [ ] Implement `pb-safe` utility leveraging `env(safe-area-inset-bottom)`.
  - [ ] Standardize bottom padding across `VaultHealth`, `Settings`, and `Infrastructure`.
- [ ] **Navigation & Layout Architecture**
  - [ ] Create `FocusLayout` for immersive routes (Settings, Spatial) to prevent user flow "traps".
  - [ ] Create `NotFoundScreen` (404) to replace silent redirects to Home.
  - [ ] Extract `BottomNav` to a reusable component in `apps/web/src/components/Navigation/`.
- [ ] **Component Library (Eliminate Starvation)**
  - [ ] Extract `GlassCard` (dark/light variants) to `/components/ui/`.
  - [ ] Extract `Button` (primary/secondary/glass variants) to `/components/ui/`.
  - [ ] General audit of repetitive UI patterns (headers, list items) for componentization.
- [ ] **Light Mode Audit**
  - [ ] Audit `mesh-bg` keyframes in `index.css` to adapt to light themes (currently dark hex values).
  - [ ] Audit legacy screens (`MessengerHub`, `FamilyTree`, `AuthScreen`) for color contrast compliance.

### PHASE 1 DETAILED SPRINT (Days 1-5, FED 40hrs / MAD 16hrs / GDEF 8hrs)

#### **DAY 1: Navigation Foundation (FED Lead)**
- **Task 1.1**: Define Route Registry
  - Create `apps/web/src/lib/routes.ts` with complete route mapping
  - Include 40+ screen paths with metadata (role, protected, layout)
  - ```typescript
    export const ROUTES = {
      HOME: '/',
      LOGIN: '/login',
      SETTINGS: '/settings',
      FAMILY_TREE: '/family-tree',
      MEMORIES: '/memories',
      ADMIN: {
        DASHBOARD: '/admin/dashboard',
        USERS: '/admin/users',
      },
    };
    ```
  - **Owner**: FED | **Hours**: 2 | **Status**: Not Started
  
- **Task 1.2**: Fix App.jsx Routes (Web)
  - Update `apps/web/src/App.jsx` to use route registry
  - Implement React Router with lazy code-splitting
  - Add loading fallback for all lazy screens
  - ```jsx
    const FamilyTreeScreen = lazy(() => import('./screens/FamilyTreeScreen'));
    const MemoriesScreen = lazy(() => import('./screens/MemoriesScreen'));
    
    export default function App() {
      return (
        <Routes>
          <Route path={ROUTES.HOME} element={<Navigate to={ROUTES.FAMILY_TREE} />} />
          <Route path={ROUTES.FAMILY_TREE} element={<Suspense fallback={<LoadingSpinner />}><FamilyTreeScreen /></Suspense>} />
          {/* ... 38 more routes */}
        </Routes>
      );
    }
    ```
  - **Owner**: FED | **Hours**: 4 | **Status**: Not Started
  - **Test**: Navigate to all 40 screens without errors
  
- **Task 1.3**: Fix main.dart GoRouter (Mobile)
  - Update `apps/mobile/lib/main.dart` to use GoRouter with proper navigation stack
  - Define 39 routes with correct builders
  - Add error handler for undefined routes
  - ```dart
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
        GoRoute(path: '/family-tree', builder: (context, state) => FamilyTreeScreen()),
        // ... 37 more routes
      ],
      errorBuilder: (context, state) => ErrorScreen(error: state.error),
    );
    ```
  - **Owner**: MAD | **Hours**: 4 | **Status**: Not Started
  - **Test**: All 39 routes resolve without "undefined page" errors

- **Blocker Resolution**: #1 Navigation (50% fixed)
- **Definition of Done**: All 40+ screens reachable from home and Settings via navigation menu

---

#### **DAY 2: Authentication System (FED Lead)**
- **Task 2.1**: Implement AuthContext (Web)
  - Update `apps/web/src/contexts/AuthContext.jsx` with full methods:
    - `signUp(email, password)` → Firebase createUserWithEmailAndPassword
    - `signIn(email, password)` → Firebase signInWithEmailAndPassword
    - `resetPassword(email)` → Firebase sendPasswordResetEmail
    - `signOut()` → Firebase signOut
    - `getCurrentUser()` → Firebase onAuthStateChanged
  - Add error handling with specific error messages
  - ```jsx
    export const AuthContext = createContext();
    
    export function AuthProvider({ children }) {
      const [user, setUser] = useState(null);
      const [loading, setLoading] = useState(true);
      const [error, setError] = useState(null);
    
      useEffect(() => {
        const unsubscribe = onAuthStateChanged(firebaseAuth, (user) => {
          setUser(user);
          setLoading(false);
        });
        return unsubscribe;
      }, []);
    
      const signUp = async (email, password) => {
        try {
          const result = await createUserWithEmailAndPassword(firebaseAuth, email, password);
          return result.user;
        } catch (err) {
          setError(err.message);
          throw err;
        }
      };
    
      const signIn = async (email, password) => {
        try {
          const result = await signInWithEmailAndPassword(firebaseAuth, email, password);
          return result.user;
        } catch (err) {
          setError(err.message);
          throw err;
        }
      };
    
      return (
        <AuthContext.Provider value={{ user, loading, error, signUp, signIn, signOut, resetPassword }}>
          {children}
        </AuthContext.Provider>
      );
    }
    ```
  - **Owner**: FED | **Hours**: 6 | **Status**: Not Started
  - **Test**: Sign up → verify user in Firestore → Sign in → Sign out flow works
  
- **Task 2.2**: Update LoginScreen (Web)
  - Modify `apps/web/src/screens/auth/LoginScreen.jsx`:
    - Add form validation (email format, password strength)
    - Call `signIn()` from AuthContext on submit
    - Show error messages from auth errors
    - Redirect to /family-tree on success
    - Add "Sign Up" link to SignUpScreen
    - Add "Reset Password" link to ResetPasswordScreen
  - ```jsx
    export default function LoginScreen() {
      const { signIn } = useContext(AuthContext);
      const [email, setEmail] = useState('');
      const [password, setPassword] = useState('');
      const [loading, setLoading] = useState(false);
      const [error, setError] = useState(null);
      const navigate = useNavigate();
    
      const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        try {
          await signIn(email, password);
          navigate('/family-tree');
        } catch (err) {
          setError(err.message);
        } finally {
          setLoading(false);
        }
      };
    
      return (
        <form onSubmit={handleSubmit}>
          <input value={email} onChange={(e) => setEmail(e.target.value)} type="email" placeholder="Email" />
          <input value={password} onChange={(e) => setPassword(e.target.value)} type="password" placeholder="Password" />
          {error && <p style={{ color: 'red' }}>{error}</p>}
          <button disabled={loading}>{loading ? 'Signing in...' : 'Sign In'}</button>
          <a href="/signup">Don't have an account?</a>
        </form>
      );
    }
    ```
  - **Owner**: FED | **Hours**: 4 | **Status**: Not Started
  - **Test**: Valid login → Redirects to /family-tree; Invalid → Shows error

- **Blocker Resolution**: #2 Auth System (100% fixed)
- **Definition of Done**: Users can sign up, sign in, and reset password with full Firebase integration

---

#### **DAY 3: Admin Routing & Access Control (FED Lead)**
- **Task 3.1**: Implement Admin Role Check
  - Add `isAdmin()` function to AuthContext
    - Query Firestore `users` collection for `role: 'admin'` claim
  - Create custom hook `useAdminRequired()` that redirects non-admins to /home
  - ```jsx
    export function useAdminRequired() {
      const { user } = useContext(AuthContext);
      const navigate = useNavigate();
      const [isAdmin, setIsAdmin] = useState(false);
      const [loading, setLoading] = useState(true);
    
      useEffect(() => {
        if (!user) {
          navigate('/login');
          return;
        }
        
        const checkAdmin = async () => {
          const userDoc = await getDoc(doc(firebaseDb, 'users', user.uid));
          const isUserAdmin = userDoc.data()?.role === 'admin';
          setIsAdmin(isUserAdmin);
          setLoading(false);
          
          if (!isUserAdmin) {
            navigate('/');
          }
        };
        
        checkAdmin();
      }, [user]);
    
      return { isAdmin, loading };
    }
    ```
  - **Owner**: FED | **Hours**: 3 | **Status**: Not Started

- **Task 3.2**: Add Admin Routes
  - Add to `apps/web/src/lib/routes.ts`:
    ```javascript
    ADMIN: {
      DASHBOARD: '/admin/dashboard',
      USERS: '/admin/users',
      ANALYTICS: '/admin/analytics',
      SETTINGS: '/admin/settings',
    }
    ```
  - Add to `apps/web/src/App.jsx`:
    ```jsx
    <Route path={ROUTES.ADMIN.DASHBOARD} element={<AdminProtectedRoute><AdminDashboard /></AdminProtectedRoute>} />
    <Route path={ROUTES.ADMIN.USERS} element={<AdminProtectedRoute><ManageUsers /></AdminProtectedRoute>} />
    {/* ... other admin routes */}
    ```
  - **Owner**: FED | **Hours**: 2 | **Status**: Not Started

- **Task 3.3**: Update BottomNav & MainLayout
  - Modify `apps/web/src/layouts/MainLayout.jsx` BottomNav to include Admin link
  - Show "Admin" option only if `useAdminRequired().isAdmin === true`
  - ```jsx
    function BottomNav() {
      const { isAdmin } = useAdminRequired();
      
      return (
        <nav className="flex gap-4">
          <a href="/">Home</a>
          <a href="/family-tree">Family</a>
          <a href="/memories">Memories</a>
          <a href="/settings">Settings</a>
          {isAdmin && <a href="/admin/dashboard">Admin</a>}
        </nav>
      );
    }
    ```
  - **Owner**: FED | **Hours**: 2 | **Status**: Not Started
  - **Test**: Non-admin user doesn't see Admin link; Admin user can access /admin routes

- **Blocker Resolution**: #4 Admin Features (100% fixed)
- **Definition of Done**: 13 admin screens accessible via /admin/* routes with proper access control

---

#### **DAY 4: Firebase Rules & Security Setup (GDEF Lead)**
- **Task 4.1**: Write Comprehensive Firestore Rules
  - Update `firestore.rules` to include rules for all 9 collections:
    ```rules
    rules_version = '2';
    service cloud.firestore {
      match /databases/{database}/documents {
        // Collections with per-doc rules
        match /users/{userId} {
          allow read: if request.auth.uid == userId;
          allow create: if request.auth.uid == resource.data.uid;
          allow update: if request.auth.uid == userId;
        }
        
        match /families/{familyId} {
          allow read: if request.auth.uid in resource.data.members;
          allow write: if request.auth.uid == resource.data.owner;
        }
        
        match /members/{memberId} {
          allow read: if request.auth.uid in get(/databases/$(database)/documents/families/$(resource.data.familyId)).data.members;
          allow write: if request.auth.uid == get(/databases/$(database)/documents/families/$(resource.data.familyId)).data.owner;
        }
        
        match /media_items/{mediaId} {
          allow read: if request.auth.uid in get(/databases/$(database)/documents/families/$(resource.data.familyId)).data.members;
          allow write: if request.auth.uid == resource.data.uploadedBy;
        }
        
        match /ai_tasks/{taskId} {
          allow read, write: if request.auth.uid == resource.data.userId;
        }
        
        match /search_index/{docId} {
          allow read: if request.auth.uid in resource.data.visibleTo;
          allow write: if request.auth != null;
        }
        
        match /conversations/{convId} {
          allow read, write: if request.auth.uid in resource.data.participants;
        }
        
        match /catalogs/{catalogId} {
          allow read: if request.auth.uid in resource.data.visibleTo;
          allow write: if request.auth.uid == resource.data.owner;
        }
        
        match /activity_logs/{logId} {
          allow read: if request.auth.uid in get(/databases/$(database)/documents/families/$(resource.data.familyId)).data.members;
          allow write: if request.auth != null;
        }
      }
    }
    ```
  - **Owner**: GDEF | **Hours**: 4 | **Status**: Not Started
  - **Test**: Use Firestore Emulator to verify rules for each collection

- **Task 4.2**: Define Composite Indexes
  - Update `firestore.indexes.json` with 6 required indexes:
    ```json
    {
      "indexes": [
        {
          "collectionGroup": "families",
          "queryScope": "COLLECTION",
          "fields": [
            { "fieldPath": "owner", "order": "ASCENDING" },
            { "fieldPath": "createdAt", "order": "DESCENDING" }
          ]
        },
        {
          "collectionGroup": "members",
          "queryScope": "COLLECTION",
          "fields": [
            { "fieldPath": "familyId", "order": "ASCENDING" },
            { "fieldPath": "name", "order": "ASCENDING" }
          ]
        },
        {
          "collectionGroup": "media_items",
          "queryScope": "COLLECTION",
          "fields": [
            { "fieldPath": "familyId", "order": "ASCENDING" },
            { "fieldPath": "dateUploaded", "order": "DESCENDING" }
          ]
        },
        {
          "collectionGroup": "media_items",
          "queryScope": "COLLECTION",
          "fields": [
            { "fieldPath": "familyId", "order": "ASCENDING" },
            { "fieldPath": "tags", "order": "ASCENDING" },
            { "fieldPath": "dateUploaded", "order": "DESCENDING" }
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
            { "fieldPath": "timestamp", "order": "DESCENDING" }
          ]
        }
      ]
    }
    ```
  - **Owner**: GDEF | **Hours**: 2 | **Status**: Not Started
  - **Test**: Deploy to Firebase console and verify indexes build successfully

- **Blocker Resolution**: #3 Firebase Rules (#8 Firebase Config Index (50% fixed)
- **Definition of Done**: All 9 collections have security rules; 6 composite indexes configured

---

#### **DAY 5: Error Handling & Design System Start (FED Lead)**
- **Task 5.1**: Create Error Boundary Component
  - Create `apps/web/src/components/ErrorBoundary.jsx`:
    ```jsx
    export class ErrorBoundary extends React.Component {
      constructor(props) {
        super(props);
        this.state = { hasError: false, error: null };
      }
    
      static getDerivedStateFromError(error) {
        return { hasError: true, error };
      }
    
      componentDidCatch(error, errorInfo) {
        console.error('Error caught:', error, errorInfo);
      }
    
      render() {
        if (this.state.hasError) {
          return (
            <div className="flex flex-col items-center justify-center h-screen bg-red-50">
              <h1 className="text-2xl font-bold text-red-600">Something went wrong</h1>
              <p className="text-gray-600 mt-2">{this.state.error?.message}</p>
              <button 
                onClick={() => window.location.reload()}
                className="mt-4 px-4 py-2 bg-red-600 text-white rounded"
              >
                Reload Page
              </button>
            </div>
          );
        }
    
        return this.props.children;
      }
    }
    ```
  - Wrap root App with `<ErrorBoundary>` in `main.jsx`
  - **Owner**: FED | **Hours**: 2 | **Status**: Not Started

- **Task 5.2**: Create Loading Spinner Component
  - Create `apps/web/src/components/LoadingSpinner.jsx`:
    ```jsx
    export default function LoadingSpinner({ message = 'Loading...' }) {
      return (
        <div className="flex flex-col items-center justify-center h-screen">
          <div className="animate-spin">
            <svg className="w-12 h-12 text-blue-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
              <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
              <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
          </div>
          <p className="mt-4 text-gray-600">{message}</p>
        </div>
      );
    }
    ```
  - **Owner**: FED | **Hours**: 1 | **Status**: Not Started

- **Task 5.3**: Extract GlassCard Component (Light/Dark Variants)
  - Create `apps/web/src/components/ui/GlassCard.jsx`:
    ```jsx
    export default function GlassCard({ children, variant = 'dark', className = '' }) {
      const baseStyles = 'backdrop-blur-lg rounded-xl border p-6';
      const variants = {
        dark: 'bg-white/10 border-white/20',
        light: 'bg-black/5 border-black/10',
      };
    
      return (
        <div className={`${baseStyles} ${variants[variant]} ${className}`}>
          {children}
        </div>
      );
    }
    ```
  - Add to tailwind.config.js:
    ```javascript
    theme: {
      extend: {
        backdropFilter: {
          lg: 'blur(16px)',
        },
      },
    }
    ```
  - **Owner**: FED | **Hours**: 2 | **Status**: Not Started

- **Task 5.4**: Extract Button Component (Variants)
  - Create `apps/web/src/components/ui/Button.jsx`:
    ```jsx
    export default function Button({ children, variant = 'primary', ...props }) {
      const baseStyles = 'px-4 py-2 rounded-lg font-semibold transition-all';
      const variants = {
        primary: 'bg-blue-600 text-white hover:bg-blue-700',
        secondary: 'bg-gray-200 text-gray-800 hover:bg-gray-300',
        glass: 'bg-white/10 text-white border border-white/20 hover:bg-white/20',
      };
    
      return (
        <button className={`${baseStyles} ${variants[variant]}`} {...props}>
          {children}
        </button>
      );
    }
    ```
  - **Owner**: FED | **Hours**: 1.5 | **Status**: Not Started

- **Blocker Resolution**: #5 Error Handling (#6 Component Library (50% fixed))
- **Definition of Done**: All error screens show helpful messages; ErrorBoundary catches crashes; Loading states appear during data fetches

---

### PHASE 2 DETAILED SPRINT (Days 6-8, GDEF 24hrs / FED 16hrs)

#### **DAY 6: Firestore Integration & Cloud Functions (GDEF Lead)**
- **Task 6.1**: Create Cloud Function for User Setup
  - Create `infrastructure/src/functions/user-setup/index.js`:
    ```javascript
    const functions = require('firebase-functions');
    const admin = require('firebase-admin');
    
    admin.initializeApp();
    const db = admin.firestore();
    
    exports.createUserProfile = functions.auth.user().onCreate(async (user) => {
      const newUserDoc = {
        uid: user.uid,
        email: user.email,
        displayName: user.displayName || '',
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        role: 'user',
        preferences: {
          theme: 'dark',
          notifications: true,
        },
      };
      
      await db.collection('users').doc(user.uid).set(newUserDoc);
      return { status: 'success' };
    });
    ```
  - Deploy to Firebase: `firebase deploy --only functions`
  - **Owner**: GDEF | **Hours**: 2 | **Status**: Not Started

- **Task 6.2**: Set Up Firestore Indexes & Deploy
  - Run Firebase Emulator to test all indexes locally:
    ```bash
    firebase emulators:start --only firestore
    ```
  - Deploy indexes to production:
    ```bash
    firebase deploy --only firestore:indexes
    ```
  - **Owner**: GDEF | **Hours**: 1.5 | **Status**: Not Started
  - **Test**: Query media_items by familyId + tag + dateUploaded succeeds at scale

- **Task 6.3**: Implement Data Isolation Hooks (Web)
  - Create `apps/web/src/hooks/useUserData.js`:
    ```javascript
    import { useContext, useEffect, useState } from 'react';
    import { AuthContext } from '../contexts/AuthContext';
    import { collection, query, where, getDocs } from 'firebase/firestore';
    import { firebaseDb } from '../config/firebase';
    
    export function useUserData() {
      const { user } = useContext(AuthContext);
      const [userDoc, setUserDoc] = useState(null);
      const [loading, setLoading] = useState(true);
    
      useEffect(() => {
        if (!user) return;
    
        const fetchUserData = async () => {
          const q = query(collection(firebaseDb, 'users'), where('uid', '==', user.uid));
          const querySnapshot = await getDocs(q);
          setUserDoc(querySnapshot.docs[0]?.data());
          setLoading(false);
        };
    
        fetchUserData();
      }, [user]);
    
      return { userDoc, loading };
    }
    ```
  - Create `apps/web/src/hooks/useFamilyData.js` (similar pattern for families)
  - **Owner**: FED | **Hours**: 3 | **Status**: Not Started

- **Blocker Resolution**: #3 Firebase Rules (#8 Firebase Config (75% fixed)
- **Definition of Done**: Cloud Functions auto-create user profiles; All 6 indexes active; Data isolation hooks working

---

#### **DAY 7: Stitch Integration & Collection Standardization (FED Lead)**
- **Task 7.1**: Integrate Stitch-Generated Family Tree
  - Review `scripts/stitch-export-workflow.md` for export process
  - Import Stitch HTML/CSS from `welcome_code.html` into FamilyTreeScreen
  - Adjust viewport to fit responsive layout
  - ```jsx
    import { useState, useEffect } from 'react';
    
    export default function FamilyTreeScreen() {
      const [stitchHtml, setStitchHtml] = useState('');
    
      useEffect(() => {
        fetch('/stitch-exports/family-tree.html')
          .then(res => res.text())
          .then(html => setStitchHtml(html));
      }, []);
    
      return (
        <div className="flex flex-col h-screen">
          <h1 className="text-2xl font-bold p-4">Family Tree Explorer</h1>
          <div className="flex-1 overflow-auto" dangerouslySetInnerHTML={{ __html: stitchHtml }} />
        </div>
      );
    }
    ```
  - **Owner**: FED | **Hours**: 4 | **Status**: Not Started

- **Task 7.2**: Consolidate Collections (`family_members` → `members`)
  - Create migration Cloud Function:
    ```javascript
    // Moves family_members docs to new members collection
    async function migrateData() {
      const old = await db.collection('family_members').getDocs();
      const batch = db.batch();
      
      old.forEach(doc => {
        const newRef = db.collection('members').doc(doc.id);
        batch.set(newRef, doc.data());
      });
      
      await batch.commit();
      // Verify, then delete old collection
    }
    ```
  - Update all queries to use new `members` collection
  - **Owner**: GDEF | **Hours**: 3 | **Status**: Not Started

- **Task 7.3**: Consolidate `memories` into `media_items`
  - Similar migration pattern for memories → media_items
  - Add `type: 'memory'` field to distinguish
  - Update all queries accordingly
  - **Owner**: GDEF | **Hours**: 2 | **Status**: Not Started

- **Blocker Resolution**: #2 MVP Features (Collection Standardization 100% fixed)
- **Definition of Done**: Family Tree HTML renders in FamilyTreeScreen; Collections consolidated; All queries use new names

---

#### **DAY 8: Settings & Personalization Flow (FED Lead)**
- **Task 8.1**: Implement Settings Screen Layout
  - Build `apps/web/src/screens/settings/SettingsScreen.jsx` with sections:
    - Profile (Name, Email, Avatar)
    - Preferences (Theme, Language, Notifications)
    - Privacy (Data sharing, Download data)
    - Danger Zone (Delete account)
  - ```jsx
    export default function SettingsScreen() {
      const { user } = useContext(AuthContext);
      const { userDoc } = useUserData();
    
      return (
        <div className="max-w-2xl mx-auto p-6">
          <h1 className="text-2xl font-bold mb-6">Settings</h1>
          
          <section className="mb-8">
            <h2 className="text-lg font-semibold mb-4">Profile</h2>
            <div className="space-y-4">
              <input type="text" placeholder="Display Name" value={userDoc?.displayName} />
              <input type="email" placeholder="Email" value={user?.email} disabled />
              <input type="file" accept="image/*" onChange={handleAvatarUpload} />
            </div>
          </section>
          
          <section className="mb-8">
            <h2 className="text-lg font-semibold mb-4">Preferences</h2>
            <label className="flex items-center">
              <input type="checkbox" checked={userDoc?.preferences?.notifications} />
              <span className="ml-2">Enable notifications</span>
            </label>
          </section>
          
          <section>
            <h2 className="text-lg font-semibold mb-4 text-red-600">Danger Zone</h2>
            <button onClick={handleDeleteAccount} className="px-4 py-2 bg-red-600 text-white rounded">
              Delete Account
            </button>
          </section>
        </div>
      );
    }
    ```
  - **Owner**: FED | **Hours**: 4 | **Status**: Not Started

- **Task 8.2**: Hook Up Settings Forms to Firestore
  - Create `apps/web/src/hooks/useSettingsUpdate.js`:
    ```javascript
    export function useSettingsUpdate() {
      const { user } = useContext(AuthContext);
    
      const updateProfile = async (updates) => {
        if (!user) return;
        await updateDoc(doc(firebaseDb, 'users', user.uid), updates);
      };
    
      const updatePreferences = async (preferences) => {
        if (!user) return;
        await updateDoc(doc(firebaseDb, 'users', user.uid), { preferences });
      };
    
      return { updateProfile, updatePreferences };
    }
    ```
  - **Owner**: FED | **Hours**: 2 | **Status**: Not Started

- **Blocker Resolution**: #4 Admin Features (BottomNav now includes Settings)
- **Definition of Done**: Users can update profile, preferences, and see privacy controls; All changes saved to Firestore

---

### PHASE 3 DETAILED SPRINT (Days 9-10, CKAD 40hrs / FED 24hrs / CKA 24hrs)

#### **DAY 9: Zustand Store Architecture (CKAD Lead)**
- **Task 9.1**: Create User Store
  - Create `apps/web/src/store/userStore.js`:
    ```javascript
    import { create } from 'zustand';
    import { devtools, subscribeWithSelector } from 'zustand/middleware';
    
    export const useUserStore = create(
      devtools(
        subscribeWithSelector((set) => ({
          user: null,
          profile: null,
          preferences: {},
          loading: false,
          error: null,
    
          setUser: (user) => set({ user }),
          setProfile: (profile) => set({ profile }),
          setPreferences: (preferences) => set({ preferences }),
          setLoading: (loading) => set({ loading }),
          setError: (error) => set({ error }),
    
          // Computed selectors
          isAuthenticated: (state) => !!state.user,
          hasAdminRole: (state) => state.profile?.role === 'admin',
        }))
      )
    );
    ```
  - Update AuthContext to dispatch to store when user logs in/out
  - **Owner**: CKAD | **Hours**: 4 | **Status**: Not Started

- **Task 9.2**: Create Family Store
  - Create `apps/web/src/store/familyStore.js`:
    ```javascript
    export const useFamilyStore = create(
      devtools(
        subscribeWithSelector((set) => ({
          families: [],
          currentFamily: null,
          members: [],
          loading: false,
    
          setFamilies: (families) => set({ families }),
          setCurrentFamily: (family) => set({ currentFamily: family }),
          setMembers: (members) => set({ members }),
          setLoading: (loading) => set({ loading }),
    
          // Selectors
          getFamilyById: (state) => (id) => state.families.find(f => f.id === id),
          getMembersByFamily: (state) => (familyId) => state.members.filter(m => m.familyId === familyId),
          getTotalMembers: (state) => state.members.length,
        }))
      )
    );
    ```
  - **Owner**: CKAD | **Hours**: 3 | **Status**: Not Started

- **Task 9.3**: Create Media Store
  - Create `apps/web/src/store/mediaStore.js`:
    ```javascript
    export const useMediaStore = create(
      devtools(
        subscribeWithSelector((set) => ({
          mediaItems: [],
          filteredMedia: [],
          selectedTags: [],
          loading: false,
    
          setMediaItems: (items) => set({ mediaItems: items }),
          setSelectedTags: (tags) => set({ selectedTags: tags }),
          setLoading: (loading) => set({ loading }),
    
          // Selectors
          getMediaByTag: (state) => (tag) => state.mediaItems.filter(m => m.tags?.includes(tag)),
          getMediaByDateRange: (state) => (start, end) => {
            return state.mediaItems.filter(m => m.dateUploaded >= start && m.dateUploaded <= end);
          },
        }))
      )
    );
    ```
  - **Owner**: CKAD | **Hours**: 3 | **Status**: Not Started

- **Task 9.4**: Replace useState with Zustand in FamilyTreeScreen
  - Update `apps/web/src/screens/FamilyTreeScreen.jsx`:
    ```jsx
    import { useFamilyStore } from '../store/familyStore';
    
    export default function FamilyTreeScreen() {
      const { currentFamily, members, setMembers, setLoading } = useFamilyStore();
      // Remove useState calls, use store instead
      
      useEffect(() => {
        setLoading(true);
        fetchMembers(currentFamily.id).then(setMembers);
      }, [currentFamily.id]);
    }
    ```
  - Repeat for MemoriesScreen, SettingsScreen, other data-driven screens
  - **Owner**: FED | **Hours**: 6 | **Status**: Not Started

- **Blocker Resolution**: #7 State Management (100% fixed)
- **Definition of Done**: All data fetches use Zustand; No useState for shared data; Zustand DevTools shows store actions

---

#### **DAY 10: AI & Vector Search Setup (CKA Lead)**
- **Task 10.1**: Set Up Vector Storage Solution
  - Decision: Use Firestore Vector Search (cloud-hosted option)
  - Create `apps/web/src/services/vectorService.js`:
    ```javascript
    import { RecursiveCharacterTextSplitter } from 'langchain/text_splitter';
    import { OpenAIEmbeddings } from 'langchain/embeddings/openai';
    
    const embeddings = new OpenAIEmbeddings({ apiKey: process.env.REACT_APP_OPENAI_KEY });
    
    export async function generateEmbedding(text) {
      const embedding = await embeddings.embedQuery(text);
      return embedding;
    }
    
    export async function storeVectorInFirestore(collectionPath, docId, vector, metadata) {
      await setDoc(doc(firebaseDb, collectionPath, docId), {
        vector, // Store as array of 1536 numbers for OpenAI embeddings
        metadata,
        timestamp: serverTimestamp(),
      });
    }
    ```
  - **Owner**: CKA | **Hours**: 3 | **Status**: Not Started

- **Task 10.2**: Create AI Identity Matching Service
  - Create `infrastructure/src/functions/ai-identity-matcher/index.js`:
    - Triggers on new `media_items` upload
    - Extracts face embeddings using ML Kit or similar
    - Compares against stored face vectors
    - Suggests matches with confidence scores
    ```javascript
    exports.matchFaceIdentities = functions.firestore
      .document('media_items/{mediaId}')
      .onCreate(async (snap, context) => {
        const media = snap.data();
        if (!media.imageUrl) return;
    
        // 1. Extract faces using ML Kit
        const faces = await extractFaces(media.imageUrl);
    
        // 2. Generate embeddings for each face
        const embeddings = await Promise.all(
          faces.map(face => generateEmbedding(face))
        );
    
        // 3. Query Firestore for similar face vectors
        const matches = await findSimilarFaces(embeddings);
    
        // 4. Store matches in ai_tasks collection
        await db.collection('ai_tasks').add({
          userId: media.uploadedBy,
          type: 'face_matching',
          status: 'pending_approval',
          suggestions: matches,
          mediaId: context.params.mediaId,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      });
    ```
  - **Owner**: CKA | **Hours**: 5 | **Status**: Not Started

- **Task 10.3**: Create Approval Hub UI
  - Create `apps/web/src/screens/ai/ApprovalHubScreen.jsx`:
    ```jsx
    export default function ApprovalHubScreen() {
      const { user } = useContext(AuthContext);
      const [tasks, setTasks] = useState([]);
    
      useEffect(() => {
        const q = query(
          collection(firebaseDb, 'ai_tasks'),
          where('userId', '==', user.uid),
          where('status', '==', 'pending_approval')
        );
        onSnapshot(q, (snap) => setTasks(snap.docs.map(d => d.data())));
      }, [user]);
    
      return (
        <div className="p-6">
          <h1 className="text-2xl font-bold mb-6">AI Suggestions</h1>
          {tasks.map(task => (
            <div key={task.id} className="border rounded p-4 mb-4">
              <h3 className="font-semibold">{task.type}</h3>
              <p className="text-sm text-gray-600">{task.suggestions.length} matches found</p>
              <button onClick={() => handleApprove(task.id)} className="mt-2 px-3 py-1 bg-green-600 text-white rounded">
                Approve
              </button>
              <button onClick={() => handleReject(task.id)} className="mt-2 ml-2 px-3 py-1 bg-red-600 text-white rounded">
                Reject
              </button>
            </div>
          ))}
        </div>
      );
    }
    ```
  - **Owner**: FED | **Hours**: 4 | **Status**: Not Started

- **Blocker Resolution**: None directly; AI Foundation laid for Phase 3
- **Definition of Done**: Face embeddings stored; AI tasks created; Approval hub displays pending suggestions

---

### PHASE 4 DETAILED SPRINT (Days 11-12, FED 16hrs)

#### **DAY 11: Component Library Standardization (FED Lead)**
- **Task 11.1**: Extract Remaining UI Components
  - Create central component library in `apps/web/src/components/ui/`:
    - `Badge.jsx` - Tags, labels
    - `Modal.jsx` - Reusable modal wrapper
    - `Dropdown.jsx` - Menu dropdowns
    - `Tabs.jsx` - Tab navigation
  - Each component supports light/dark mode variants
  - **Owner**: FED | **Hours**: 6 | **Status**: Not Started

- **Task 11.2**: Update Design Tokens
  - Create `apps/web/src/styles/tokens.js`:
    ```javascript
    export const tokens = {
      colors: {
        primary: {
          light: '#3b82f6',
          dark: '#1e40af',
        },
        background: {
          light: '#ffffff',
          dark: '#0f172a',
        },
        text: {
          light: '#1f2937',
          dark: '#f3f4f6',
        },
      },
      spacing: {
        xs: '4px',
        sm: '8px',
        md: '16px',
        lg: '24px',
        xl: '32px',
      },
      borderRadius: {
        sm: '4px',
        md: '8px',
        lg: '12px',
        xl: '16px',
      },
    };
    ```
  - Reference tokens in all component classes
  - **Owner**: FED | **Hours**: 2 | **Status**: Not Started

- **Task 11.3**: Implement Theme Toggle
  - Update `apps/web/src/App.jsx`:
    ```jsx
    const [theme, setTheme] = useState('dark');
    
    return (
      <div className={theme === 'light' ? 'light-theme' : 'dark-theme'}>
        <ThemeToggle current={theme} onChange={setTheme} />
        <App />
      </div>
    );
    ```
  - Add CSS for light-theme and dark-theme classes
  - Store preference in Zustand + localStorage
  - **Owner**: FED | **Hours**: 1.5 | **Status**: Not Started

- **Blocker Resolution**: #6 Component Library (#9 Design System (90% fixed)
- **Definition of Done**: All buttons, cards, inputs use shared components; Theme toggle works; Light mode renders correctly

---

#### **DAY 12: Responsive Design & Cross-Browser Testing (FED Lead)**
- **Task 12.1**: Audit Responsive Breakpoints
  - Test all screens on:
    - Mobile: 375px (iPhone SE), 414px (iPhone 12), 390px (Pixel 6)
    - Tablet: 768px, 834px
    - Desktop: 1024px, 1440px
  - Use Tailwind responsive prefixes: `sm:`, `md:`, `lg:`, `xl:`
  - **Owner**: FED | **Hours**: 4 | **Status**: Not Started

- **Task 12.2**: Cross-Browser Testing
  - Test on:
    - Chrome (latest)
    - Safari (latest)
    - Firefox (latest)
    - Edge (latest)
  - Check for vendor prefix issues, CSS Grid/Flex display issues
  - **Owner**: FED | **Hours**: 2 | **Status**: Not Started

- **Task 12.3**: Accessibility Audit (A11y)
  - Run axe accessibility scanner on all screens
  - Fix contrast issues (WCAG AA minimum)
  - Add ARIA labels to interactive elements
  - Test keyboard navigation (Tab, Enter, Escape)
  - **Owner**: FED | **Hours**: 2 | **Status**: Not Started

- **Blocker Resolution**: #9 Design System (100% fixed)
- **Definition of Done**: All screens responsive on mobile/tablet/desktop; 0 axe violations; Keyboard navigation works

---

### PHASE 5 DETAILED SPRINT (Day 13, Testing & QA, All Teams)

#### **DAY 13: Pre-Launch Verification & Bug Fixes (All Teams)**

**Verification Checklist**:

✅ **Navigation** (FED)
- [ ] All 40 routes resolve without 404
- [ ] BottomNav links work on mobile and web
- [ ] Back button history works correctly
- [ ] Admin routes only accessible by admins

✅ **Authentication** (FED)
- [ ] Sign up creates new user in Firestore
- [ ] Sign in redirects to /family-tree
- [ ] Sign out clears auth state
- [ ] Password reset email sends
- [ ] Session persists on page reload

✅ **Firebase Integration** (GDEF)
- [ ] Firestore rules allow authenticated reads/writes
- [ ] Cloud Functions trigger on expected events
- [ ] Media uploads to Cloud Storage
- [ ] Composite indexes build successfully
- [ ] No Firestore quota errors

✅ **State Management** (CKAD)
- [ ] Zustand stores persist on page reload
- [ ] DevTools middleware shows all actions
- [ ] No duplicate data fetches
- [ ] Selectors return correct values

✅ **UI/UX** (FED)
- [ ] Error boundaries catch crashes
- [ ] Loading spinners appear during fetches
- [ ] Light mode and dark mode toggle
- [ ] All components responsive
- [ ] No console errors

✅ **Performance** (All)
- [ ] Lighthouse score > 80
- [ ] Core Web Vitals pass
- [ ] No memory leaks
- [ ] Time to interactive < 3s

✅ **iOS Build** (MAD)
- [ ] Build compiles without errors
- [ ] All routes accessible
- [ ] Firebase auth works
- [ ] Camera permissions requested
- [ ] Ready for TestFlight

✅ **Android Build** (MAD)
- [ ] APK builds successfully
- [ ] All routes accessible
- [ ] Firebase auth works
- [ ] Camera permissions requested
- [ ] Ready for Google Play Beta

---

### KNOWLEDGE BASES & CLEANUP PLAN

After completing Phase 5, perform documentation cleanup:

**Files to Rename** (3-word convention):
- `FVM.md` → `Flutter-Version-Management.md`
- `AGENTS.md` → `AI-Agents-Personas.md`
- `design-spec.md` → `Design-System-Specification.md`
- `walkthrough.md` → `Feature-Walkthrough-Guide.md`
- `implementation_plan.md` → `Implementation-Planning-Reference.md`

**Files to Move to Root** (unclear next steps - review for keep/delete/archive):
- ARCH-PIVOT-HOSTED.md
- FRAMEWORK-PIVOT-FLUTTER.md
- STRATEGY-STORAGE-AI.md
- MIGRATION-LOG.md
- APP-FLOW-AUDIT.md
- task.md
- FINDINGS.md
- screens-inventory.md
- mapping.md
- user-flow.md
- stitch-export-workflow.md

**Files to Delete** (after verification no active references):
- `FINDINGS.md` (outdated comparison)
- Any old migration guides that reference deleted code

---

### SUCCESS METRICS & COMPLETION CRITERIA

**MVP Launch Success When**:

✅ **Functional**
- [ ] Users can sign up, log in, reset password
- [ ] 40+ screens navigable without errors
- [ ] Firebase data persists and syncs
- [ ] Admin dashboard accessible to admins only

✅ **Quality**
- [ ] 0 console errors on any screen
- [ ] Lighthouse score ≥ 80
- [ ] Core Web Vitals all green
- [ ] Zero accessibility violations (WCAG AA)
- [ ] All 40 routes tested manually

✅ **Performance**
- [ ] Time to interactive < 3 seconds
- [ ] No memory leaks (Chrome DevTools)
- [ ] No unused JavaScript > 200KB
- [ ] Images optimized (WebP format when possible)

✅ **Deployment**
- [ ] Web deployed to Firebase Hosting
- [ ] iOS build in TestFlight
- [ ] Android build in Google Play Console Beta
- [ ] All environment variables configured

✅ **Documentation**
- [ ] Deployment runbook updated
- [ ] Known issues documented
- [ ] Future work prioritized in ROADMAP.md
- [ ] Team handoff notes completed

---

### Team Assignment Summary

**FED (Frontend) - 80 hours**
- Days 1-5: Navigation, Auth, Error Handling, Component Library start
- Days 6-8: Settings, Stitch Integration, remaining components
- Days 11-14: Responsive design, accessibility, QA

**MAD (Mobile/Android) - 64 hours**
- Days 1-5: GoRouter setup, navigation fixes, Firebase config
- Days 6-8: Collection standardization, Stitch integration
- Days 11-13: iOS/Android builds, TestFlight/Play Beta
- Day 14: Launch delivery

**GDEF (Database/DevOps) - 40 hours**
- Days 4-8: Firestore rules, indexes, Cloud Functions
- Days 9-10: Deployment automation, monitoring setup
- Day 13: Production verification

**CKAD (AI/State) - 40 hours**
- Days 9-10: Zustand stores, Vector search setup
- Days 11-12: AI matching service, refinements
- Day 13: AI feature verification

**CKA (Backend/Infrastructure) - 24 hours**
- Days 9-10: Cloud Functions, Vector embeddings
- Days 11-13: Monitoring, alerting setup

**KCS (QA/Documentation) - 12 hours**
- Days 11-14: Testing plan, bug documentation
- Deployment readiness checklist

---

### How to Use This Plan

1. **Print this file** or open in split-view editor
2. **Check off tasks** as team completes them
3. **Update time estimates** as actual work progresses
4. **Track blockers** weekly in sprint standup
5. **Post to GitHub Discussions** for async questions
6. **Deploy to Firebase** on Day 14 EOD
7. **Archive this file** to `/docs/SPRINT-FEBRUARY-2026-FINAL.md` after completion

Good luck! 🚀
