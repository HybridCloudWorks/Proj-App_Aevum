# MVP CRITICAL FIXES - Action Plan

**Priority**: 🔴 CRITICAL  
**Timeline**: 2 Weeks to Shipping Readiness  
**Personas Assigned**: FED, MAD, GDEF, CKAD, CKA  

---

## Phase 1: Navigation & Routing (Days 1-3)

### Sprint 1.1: Mobile Navigation Fix (MAD Lead)

**Person**: Mobile App Developer  
**Effort**: 2 days  
**Blockers**: None  

#### Tasks
- [ ] Install GoRouter package
  ```bash
  cd apps/mobile
  flutter pub add go_router
  ```
- [ ] Create `lib/navigation/app_router.dart`
  ```dart
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const IntroPageScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
        routes: [
          GoRoute(
            path: 'family-tree',
            builder: (context, state) => const FamilyTreeExplorerScreen(),
          ),
          // More routes...
        ],
      ),
      // Admin routes (gated by role check)
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminShellScreen(),
        redirect: (context, state) => _adminGuard(context),
        routes: [
          GoRoute(
            path: 'ai-engine',
            builder: (context, state) => const AdminAIEngineScreen(),
          ),
          // More admin routes...
        ],
      ),
    ],
  );
  ```

- [ ] Remove hardcoded routes from `main.dart`
- [ ] Update DashboardScreen to use GoRouter push/go instead of `Navigator.pushNamed`
- [ ] Implement deep link handler (handle notification taps)

#### Success Criteria
- ✅ All 39 routes are reachable via GoRouter
- ✅ Can deep link to any screen: `aevum://dashboard/family-tree`
- ✅ Admin screens are only accessible to admin users
- ✅ Back button works correctly on all screens

---

### Sprint 1.2: Web Router Fix (FED Lead)

**Person**: Frontend & DevOps Engineer  
**Effort**: 1.5 days  
**Blockers**: None  

#### Tasks
- [ ] Create route registry in `apps/web/src/routes/routeConfig.js`
  ```javascript
  export const ROUTE_CONFIG = {
    HOME: '/',
    AUTH: '/auth',
    DASHBOARD: '/dashboard',
    FAMILY_TREE: '/family-tree',
    MEMORIES: '/memories',
    MEMORIES_UPLOAD: '/memories/upload',
    MEMORIES_RESTORATION: '/memories/restoration',
    HERITAGE_MAP: '/heritage-map',
    SETTINGS: '/settings',
    SETTINGS_PRIVACY: '/settings/privacy',
    SETTINGS_PRIVACY_RULES: '/settings/privacy-rules',
    SETTINGS_PRIVACY_SECURITY: '/settings/privacy-security',
    SETTINGS_RESTRICTED_PROFILE: '/settings/restricted-profile/:section',
    SETTINGS_INFRASTRUCTURE: '/settings/infrastructure',
    SETTINGS_DELEGATION: '/settings/delegation',
    SETTINGS_LEGACY: '/settings/legacy-handover',
    // ... all routes
  };
  ```

- [ ] Create `components/NotFoundScreen.jsx`
  ```jsx
  export default function NotFoundScreen() {
    const navigate = useNavigate();
    return (
      <div className="flex flex-col items-center justify-center min-h-screen gap-4">
        <h1 className="text-4xl font-bold">404</h1>
        <p>This page doesn't exist.</p>
        <button onClick={() => navigate('/')}>Go Home</button>
      </div>
    );
  }
  ```

- [ ] Create `components/ErrorBoundary.jsx`
  ```jsx
  export class ErrorBoundary extends React.Component {
    state = { hasError: false, error: null };
    
    static getDerivedStateFromError(error) {
      return { hasError: true, error };
    }
    
    render() {
      if (this.state.hasError) {
        return (
          <div className="flex flex-col items-center justify-center min-h-screen gap-4">
            <h1>Something went wrong</h1>
            <pre>{this.state.error?.message}</pre>
            <button onClick={() => this.setState({ hasError: false })}>
              Retry
            </button>
          </div>
        );
      }
      return this.props.children;
    }
  }
  ```

- [ ] Update `App.jsx`:
  ```jsx
  <ErrorBoundary>
    <BrowserRouter>
      <Suspense fallback={<LoadingScreen />}>
        <Routes>
          {/* All routes */}
          <Route path="*" element={<NotFoundScreen />} />
        </Routes>
      </Suspense>
    </BrowserRouter>
  </ErrorBoundary>
  ```

- [ ] Add all missing routes:
  - `/settings/privacy-security`
  - `/settings/restricted-profile/:section`
  - Any other referenced but missing routes

#### Success Criteria
- ✅ All routes in SettingsScreen are defined in App.jsx
- ✅ Clicking any navigation button works
- ✅ Broken routes show NotFoundScreen (not silent redirect)
- ✅ React errors show ErrorBoundary (not blank screen)

---

## Phase 2: Firebase Integration (Days 4-6)

### Sprint 2.1: Firestore Collections & Rules (GDEF Lead)

**Person**: Firebase Expert  
**Effort**: 2 days  
**Blockers**: None  

#### Tasks
- [ ] Create missing Firestore collections in security rules:
  ```codex-rules
  // ADD after existing collections:
  
  // AI Tasks (for restoration, identity matching, etc.)
  match /ai_tasks/{taskId} {
    allow read: if isOwner(resource);
    allow create: if isNewOwner() && validAITaskData();
    allow update: if isOwner(resource);
    allow delete: if isOwner(resource);
  }
  
  // Search/Semantic Index
  match /search_index/{indexId} {
    allow read: if isAuthenticated();
    allow write: if isAdmin();
  }
  
  // Messaging
  match /conversations/{conversationId} {
    allow read: if isThreadMember(resource);
    allow create: if isThreadMember(request.resource.data);
  }
  match /conversations/{conversationId}/messages/{messageId} {
    allow read: if isThreadMember(parent(parent(resource)));
    allow create: if isThreadMember(parent(parent(request.resource.data)));
  }
  
  // Catalog/Workflows
  match /catalogs/{catalogId} {
    allow read: if isAuthenticated();
    allow write: if isOwner(resource);
  }
  ```

- [ ] Add composite indexes in `firestore.indexes.json`:
  ```json
  {
    "indexes": [
      // Existing...
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
        "collectionGroup": "media_items",
        "queryScope": "COLLECTION",
        "fields": [
          { "fieldPath": "familyId", "order": "ASCENDING" },
          { "fieldPath": "type", "order": "ASCENDING" },
          { "fieldPath": "uploadedAt", "order": "DESCENDING" }
        ]
      },
      // More indexes as needed...
    ]
  }
  ```

- [ ] Deploy rules:
  ```bash
  firebase deploy --only firestore:rules
  ```

#### Success Criteria
- ✅ All collections have security rules
- ✅ Indexes are deployed (check Firebase Console)
- ✅ Test with Firestore emulator:
  ```bash
  firebase emulators:start
  ```

---

### Sprint 2.2: Cloud Functions Stubs (CKAD Lead)

**Person**: Application Developer  
**Effort**: 2 days  
**Blockers**: Completion depends on backend API design  

#### Tasks
- [ ] Create `infrastructure/src/functions/index.js` stubs:
  ```javascript
  const functions = require('firebase-functions');
  const admin = require('firebase-admin');
  
  admin.initializeApp();
  
  // Validate family membership on storage upload
  exports.validateFamilyMembership = functions.firestore
    .document('media_items/{mediaId}')
    .onCreate(async (snap, context) => {
      const data = snap.data();
      const userId = data.uploadedBy;
      const familyId = data.familyId;
      
      // Check if user is member of family
      const memberRef = await admin.firestore()
        .collection('family_members')
        .where('userId', '==', userId)
        .where('familyId', '==', familyId)
        .limit(1)
        .get();
      
      if (memberRef.empty) {
        // Delete unauthorized upload
        await snap.ref.delete();
        throw new Error('User not a member of this family');
      }
    });
  
  // Process AI tasks
  exports.processAITask = functions.firestore
    .document('ai_tasks/{taskId}')
    .onCreate(async (snap, context) => {
      const task = snap.data();
      
      // Call ML API (placeholder)
      // const result = await callMLAPI(task);
      
      // Update task status
      await snap.ref.update({
        status: 'processing',
        startedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });
  ```

- [ ] Initialize functions directory:
  ```bash
  cd infrastructure/src/functions
  npm init
  npm install firebase-functions firebase-admin
  ```

#### Success Criteria
- ✅ Functions deploy without errors:
  ```bash
  firebase deploy --only functions
  ```

---

## Phase 3: State Management (Days 7-8)

### Sprint 3.1: Zustand Setup (CKAD Lead)

**Person**: Application Developer  
**Effort**: 1.5 days  
**Blockers**: None  

#### Tasks
- [ ] Create `apps/web/src/store/useUserStore.js`:
  ```javascript
  import create from 'zustand';
  import { getCurrentUser } from '@lib/auth';
  
  export const useUserStore = create((set) => ({
    user: null,
    loading: true,
    error: null,
    
    initUser: async () => {
      try {
        const user = await getCurrentUser();
        set({ user, loading: false });
      } catch (error) {
        set({ error: error.message, loading: false });
      }
    },
    
    setUser: (user) => set({ user }),
    clearUser: () => set({ user: null }),
  }));
  ```

- [ ] Create `apps/web/src/store/useFamilyStore.js`:
  ```javascript
  import create from 'zustand';
  import { db } from '@lib/firebase';
  
  export const useFamilyStore = create((set) => ({
    families: [],
    currentFamilyId: null,
    loading: false,
    
    fetchFamilies: async (userId) => {
      set({ loading: true });
      try {
        const snap = await db.collection('families')
          .where('userId', '==', userId)
          .get();
        set({ families: snap.docs.map(d => ({ id: d.id, ...d.data() })), loading: false });
      } catch (error) {
        set({ loading: false });
      }
    },
    
    setCurrentFamily: (familyId) => set({ currentFamilyId: familyId }),
  }));
  ```

- [ ] Create `apps/web/src/store/useMediaStore.js` (similar pattern)

- [ ] Update screens to use stores instead of useState:
  ```jsx
  // Before:
  const [families, setFamilies] = useState([]);
  useEffect(() => { fetchFamilies(); }, []);
  
  // After:
  const { families, fetchFamilies } = useFamilyStore();
  useEffect(() => { fetchFamilies(user.uid); }, [user]);
  ```

#### Success Criteria
- ✅ Zustand stores created for all major state
- ✅ No more prop drilling
- ✅ App renders without errors

---

## Phase 4: Auth Implementation (Days 9-10)

### Sprint 4.1: Complete AuthContext (FED Lead)

**Person**: Frontend & DevOps Engineer  
**Effort**: 1 day  
**Blockers**: None  

#### Tasks
- [ ] Update `apps/web/src/contexts/AuthContext.jsx`:
  ```jsx
  export function AuthProvider({ children }) {
    const [user, setUser] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    
    const signUp = async (email, password, displayName) => {
      try {
        const result = await firebase.auth().createUserWithEmailAndPassword(email, password);
        await result.user.updateProfile({ displayName });
        setUser(result.user);
        return result.user;
      } catch (err) {
        setError(err.message);
        throw err;
      }
    };
    
    const signIn = async (email, password) => {
      try {
        const result = await firebase.auth().signInWithEmailAndPassword(email, password);
        setUser(result.user);
        return result.user;
      } catch (err) {
        setError(err.message);
        throw err;
      }
    };
    
    const signOut = async () => {
      try {
        await firebase.auth().signOut();
        setUser(null);
      } catch (err) {
        setError(err.message);
        throw err;
      }
    };
    
    const resetPassword = async (email) => {
      try {
        await firebase.auth().sendPasswordResetEmail(email);
      } catch (err) {
        setError(err.message);
        throw err;
      }
    };
    
    const value = {
      user,
      loading,
      error,
      isAuthenticated: !!user,
      signUp,
      signIn,
      signOut,
      resetPassword,
    };
    
    return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
  }
  ```

- [ ] Update `WelcomeScreen.jsx` to use real auth:
  ```jsx
  const { signIn } = useAuth();
  
  const handleLogin = async (email, password) => {
    try {
      await signIn(email, password);
      navigate('/dashboard');
    } catch (err) {
      setError(err.message);
    }
  };
  ```

#### Success Criteria
- ✅ Users can sign up
- ✅ Users can sign in
- ✅ Users can reset password
- ✅ Auth flow redirects to dashboard on success
- ✅ Error messages display properly

---

## Phase 5: Error Handling & Loading (Days 11-12)

### Sprint 5.1: Loading & Error States (FED Lead)

**Person**: Frontend & DevOps Engineer  
**Effort**: 1.5 days  
**Blockers**: None  

#### Tasks
- [ ] Create `apps/web/src/components/LoadingSpinner.jsx`:
  ```jsx
  export function LoadingSpinner() {
    return (
      <div className="flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-white"></div>
      </div>
    );
  }
  ```

- [ ] Create `apps/web/src/components/ErrorBox.jsx`:
  ```jsx
  export function ErrorBox({ error, onRetry }) {
    return (
      <div className="bg-red-500/20 border border-red-500 rounded p-4">
        <p className="text-red-200">{error}</p>
        {onRetry && <button onClick={onRetry}>Retry</button>}
      </div>
    );
  }
  ```

- [ ] Update all data-fetching screens to use LoadingSpinner and ErrorBox

#### Success Criteria
- ✅ Loading states show spinner
- ✅ Errors show message (not blank screen)
- ✅ Retry button visible on errors

---

## Phase 6: Design System (Days 13-14)

### Sprint 6.1: Component Library Scaffold (FED Lead)

**Person**: Frontend & DevOps Engineer  
**Effort**: 1.5 days  
**Blockers**: None  

#### Tasks
- [ ] Create `apps/web/src/components/ui/Button.jsx`:
  ```jsx
  export function Button({ children, variant = 'primary', ...props }) {
    const baseClass = 'px-4 py-2 rounded font-semibold transition';
    const variants = {
      primary: 'bg-blue-500 text-white hover:bg-blue-600',
      secondary: 'bg-gray-700 text-white hover:bg-gray-800',
      ghost: 'bg-transparent border border-white/30 text-white hover:bg-white/10',
    };
    
    return (
      <button className={`${baseClass} ${variants[variant]}`} {...props}>
        {children}
      </button>
    );
  }
  ```

- [ ] Create similar component files for:
  - `Card.jsx`
  - `Input.jsx`
  - `Modal.jsx`
  - `Badge.jsx`

- [ ] Update all screens to import from `@components/ui/` instead of inline styles

- [ ] Implement light/dark mode toggle in `SettingsScreen`:
  ```jsx
  const [theme, setTheme] = useState(localStorage.getItem('theme') || 'dark');
  
  useEffect(() => {
    document.documentElement.classList.toggle('dark', theme === 'dark');
    localStorage.setItem('theme', theme);
  }, [theme]);
  ```

#### Success Criteria
- ✅ All UI elements use reusable components
- ✅ Light mode toggle works
- ✅ Design tokens are centralized in Tailwind config

---

## Phase 7: Scope Reduction (Day 14)

### Sprint 7.1: MVP Screen Prioritization (Product Lead + Team)

**TODO LIST FOR MVP (CRITICAL)**:

| Screen | Priority | Status | Notes |
|--------|----------|--------|-------|
| IntroPageScreen | 🔴 MUST | TODO | Intro sequence |
| AuthScreen | 🔴 MUST | TODO | Sign up/in/forgot password |
| DashboardScreen | 🔴 MUST | PARTIAL | Family overview |
| FamilyTreeScreen | 🔴 MUST | PARTIAL | Add/view members |
| MemoriesScreen | 🔴 MUST | PARTIAL | Photo gallery |
| UploadScreen | 🔴 MUST | PARTIAL | Upload photos |
| ProfileScreen | 🔴 MUST | PARTIAL | User settings |
| SettingsScreen | 🟡 SHOULD | PARTIAL | General settings |

**Remove from MVP**:
- [ ] All 13 admin screens (post-MVP)
- [ ] All AI feature screens (post-MVP)
- [ ] All messaging screens (post-MVP)
- [ ] VisionOS spatial features (post-MVP)
- [ ] RestorationScreen (post-MVP)
- [ ] ExplorerScreen (post-MVP)
- [ ] Multiple other screens not listed above

#### Success Criteria
- ✅ App has 8-10 core screens
- ✅ All core screens are fully functional
- ✅ Routes removed from main nav
- ✅ App is launchable as MVP

---

## Pre-Launch Verification Checklist

### Functionality
- [ ] Sign up flow works end-to-end
- [ ] Sign in flow works end-to-end
- [ ] Password reset works
- [ ] All 8 core screens are reachable
- [ ] Data persists in Firestore
- [ ] Photos are stored in Cloud Storage
- [ ] Errors show helpful messages (not blank screens)
- [ ] Loading states work

### Navigation
- [ ] BottomNav has correct 5 items
- [ ] All buttons navigate to correct screens
- [ ] Back button works
- [ ] Deep links work (test with QR code)

### Firebase
- [ ] Rules deployed and tested
- [ ] Indexes deployed
- [ ] Functions deployed (stubs okay)
- [ ] Emulator works locally:
  ```bash
  firebase emulators:start
  ```

### Performance
- [ ] Lighthouse score > 80
- [ ] First Contentful Paint < 2s
- [ ] Images optimized (webp, responsive sizes)

### Accessibility
- [ ] Light mode works
- [ ] High contrast mode works
- [ ] Screen reader compatible (basic test)
- [ ] Colors meet WCAG AA standards

### Security
- [ ] No hardcoded credentials
- [ ] Firebase rules tested for injection attacks
- [ ] No broken external image links
- [ ] HTTPS enforced

---

## Team Assignment

| Phase | Lead Persona | Team |
|-------|--------------|------|
| Phase 1 (Navigation) | FED + MAD | Frontend + Mobile |
| Phase 2 (Firebase) | GDEF | Backend |
| Phase 3 (State) | CKAD | Frontend |
| Phase 4 (Auth) | FED | Frontend |
| Phase 5 (Error Handling) | FED + CKA | Frontend + DevOps |
| Phase 6 (Design System) | FED | Frontend |
| Phase 7 (Scope) | Product Lead | All |

---

## Success Metrics

### By End of Week 1
- ✅ Navigation fixed on web and mobile
- ✅ Routing issues resolved
- ✅ App doesn't crash on broken routes
- ✅ Auth context has basic methods

### By End of Week 2
- ✅ Firebase integration complete
- ✅ State management with Zustand
- ✅ Component library v1 done
- ✅ MVP scope defined (8-10 screens)
- ✅ App is shippable to TestFlight/App Store beta

---

## Post-MVP Roadmap

### Week 3-4: Polish
- Performance optimization
- Additional screens (admin, AI features)
- Analytics integration
- Crash reporting (Sentry/Crashlytics)

### Week 5-6: Features
- Messaging/collaboration
- AI restoration
- Identity matching
- Advanced search

### Month 2+: Scale
- Multi-workspace support
- API documentation
- Migration tools from competitors
- visionOS integration

---

**Document Version**: 1.0  
**Last Updated**: February 13, 2026  
**Status**: Ready for Sprint Planning
