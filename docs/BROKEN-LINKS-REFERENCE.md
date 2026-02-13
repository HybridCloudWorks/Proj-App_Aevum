# 🔗 BROKEN LINKS & ROUTE MISMATCHES - Quick Reference

**Purpose**: Exact locations and fixes for all broken navigation paths  
**Updated**: February 13, 2026  

---

## 🔴 CRITICAL ROUTE MISMATCHES (Production Crashes)

### 1. SettingsScreen → PrivacyRulesScreen → RestrictedProfileScreen

**Problem**: Click chain leads to undefined route.

```
SOURCE FILE: apps/web/src/screens/settings/SettingsScreen.jsx
┌─────────────────────────────────────────────────────────┐
│ Line 52: onClick={() => navigate("/settings/privacy-rules")}  ✅ VALID
│ Line 73: onClick={() => navigate("/settings/delegation")}     ✅ VALID
│ Line 97: onClick={() => navigate("/settings/legacy-handover")} ✅ VALID
│ Line 121: onClick={() => navigate("/settings/infrastructure")} ✅ VALID
│ Line 173: onClick={() => navigate("/settings/privacy-security")} ❌ UNDEFINED
└─────────────────────────────────────────────────────────┘

NEXT FILE: apps/web/src/screens/settings/privacy/PrivacyRulesScreen.jsx
┌─────────────────────────────────────────────────────────┐
│ Line 207: onClick={() => navigate("/settings/privacy-security")} ❌ UNDEFINED
└─────────────────────────────────────────────────────────┘

NEXT FILE: apps/web/src/screens/settings/privacy/PrivacySecurityScreen.jsx
┌─────────────────────────────────────────────────────────┐
│ Line 284: onClick={() => navigate("/settings/restricted-profile/demo")} ❌ BROKEN
│           (No :section parameter in route definition)
└─────────────────────────────────────────────────────────┘

RESULT: App.jsx
┌─────────────────────────────────────────────────────────┐
│ ✅ Route for /settings/privacy-rules EXISTS
│ ✅ Route for /settings/delegation EXISTS
│ ✅ Route for /settings/legacy-handover EXISTS
│ ✅ Route for /settings/infrastructure EXISTS
│ ❌ Route for /settings/privacy-security MISSING (line 76)
│ ❌ Route for /settings/restricted-profile/:section MISSING
│   (exists as /settings/privacy/RestrictedProfileScreen without param)
└─────────────────────────────────────────────────────────┘
```

**Fix**:
```jsx
// In apps/web/src/App.jsx, add these routes:

// Line ~110 (after SettingsScreen definition)
const PrivacySecurityScreen = lazy(
  () => import("@screens/settings/privacy/PrivacySecurityScreen"),
);

// Line ~130 (in Routes)
<Route path="/settings/privacy-security" element={<PrivacySecurityScreen />} />
<Route path="/settings/restricted-profile/:section" element={<RestrictedProfileScreen />} />
```

**Verification**:
```bash
# After fix, all these should work:
/settings/privacy-rules
/settings/privacy-security
/settings/restricted-profile/demo
/settings/delegation
/settings/infrastructure
/settings/legacy-handover
```

---

### 2. AdminScreen Unreachable from Main Navigation

**Problem**: 13 admin screens exist but no UI path to reach them.

```
SOURCE: apps/mobile/lib/main.dart
┌─────────────────────────────────────────────────────────┐
│ Lines 47-77: All admin screens defined in routes:
│ '/admin-ai-engine': (context) => const AdminAIEngineScreen(),
│ '/admin-ai-restoration': (context) => const AdminAIRestorationScreen(),
│ ... 11 more admin routes...
│
│ ✅ Routes defined (technically accessible)
│ ❌ No navigation to them
│   - DashboardScreen._buildBentoGrid() doesn't link to admin
│   - HeritageBottomNav (5 items) doesn't include admin
│   - User must manually type route in dev mode
└─────────────────────────────────────────────────────────┘

SAME ISSUE ON WEB:
apps/web/src/App.jsx
┌─────────────────────────────────────────────────────────┐
│ ✅ AdminScreen route exists at line 110
│ ❌ MainLayout BottomNav doesn't link to /admin
│ ❌ DashboardScreen has no admin menu option
│ ❌ Only reachable via direct URL or development tools
└─────────────────────────────────────────────────────────┘
```

**Fix (Mobile with GoRouter)**:
```dart
// apps/mobile/lib/navigation/app_router.dart
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
      routes: [
        GoRoute(
          path: 'admin',
          redirect: (context, state) async {
            // Check if user is admin
            final isAdmin = await _checkAdminRole(context);
            if (!isAdmin) return '/dashboard';
            return null;
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
            // ... more admin routes
          ],
        ),
      ],
    ),
  ],
);
```

**Fix (Web)**:
```jsx
// apps/web/src/layouts/AdminNav.jsx - Create admin navigation sidebar
export function AdminNav() {
  const { user } = useAuth();
  const [isAdmin, setIsAdmin] = useState(false);
  
  useEffect(() => {
    checkAdminStatus(user.uid).then(setIsAdmin);
  }, [user]);
  
  if (!isAdmin) return null;
  
  return (
    <div className="admin-sidebar">
      <Link to="/admin/ai-engine">AI Engine</Link>
      <Link to="/admin/ai-restoration">AI Restoration</Link>
      {/* ... */}
    </div>
  );
}

// Then in DashboardScreen, conditionally show admin link
const { user } = useAuth();
{user?.isAdmin && <button onClick={() => navigate('/admin')}>Admin Panel</button>}
```

**Verification**:
```bash
# After fix:
# 1. Non-admin users: no admin menu visible
# 2. Admin users: see admin option in dashboard
# 3. Clicking admin → safe navigation to admin panel
# 4. Deep link: /admin redirects to auth if not admin
```

---

## 🟠 BROKEN COMPONENT IMPORTS

### 3. Storybook Not Configured

**Problem**: `package.json` has Storybook dependency but it's not set up.

```
FILE: apps/web/package.json
┌─────────────────────────────────────────────────────────┐
│ "storybook": "storybook dev -p 6006"  <- Script exists
│ BUT no .storybook/main.js configuration
│ BUT no stories/ directory
│ RESULT: `npm run storybook` fails
└─────────────────────────────────────────────────────────┘
```

**Fix**:
```bash
cd apps/web
npx storybook init

# Creates:
# .storybook/main.js
# .storybook/preview.js
```

Then create stories:
```jsx
// apps/web/src/components/ui/Button.stories.jsx
import { Button } from './Button';

export default {
  title: 'Components/Button',
  component: Button,
};

export const Primary = () => <Button variant="primary">Click me</Button>;
export const Secondary = () => <Button variant="secondary">Click me</Button>;
```

---

### 4. Import Path Not Found ("@screens/*")

**Problem**: Multiple screens use `@screens/` alias that may not be configured.

```
SOURCE: apps/web/src/screens/ScreenGallery.jsx
┌─────────────────────────────────────────────────────────┐
│ Line 112: href={`/src/stitch-screens/${selectedScreen}/code.html`}
│           ❌ Relative path won't work after build
│           ✅ Should be: /stitch-screens/${selectedScreen}/code.html
└─────────────────────────────────────────────────────────┘
```

**Check Vite config**:
```javascript
// apps/web/vite.config.js
export default {
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
      '@screens': path.resolve(__dirname, './src/screens'),
      '@lib': path.resolve(__dirname, './src/lib'),
      // ... more aliases
    },
  },
};
```

**Fix**: Ensure all aliases are defined. If not:
```javascript
// vite.config.js
import path from 'path';

export default {
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
      '@screens': path.resolve(__dirname, './src/screens'),
      '@components': path.resolve(__dirname, './src/components'),
      '@lib': path.resolve(__dirname, './src/lib'),
      '@contexts': path.resolve(__dirname, './src/contexts'),
      '@hooks': path.resolve(__dirname, './src/hooks'),
      '@layouts': path.resolve(__dirname, './src/layouts'),
      '@styles': path.resolve(__dirname, './src/styles'),
    },
  },
};
```

---

## 🟡 NAVIGATION ISSUES (Non-Blocking But Bad UX)

### 5. No "Back to Previous Screen" Strategy

**Problem**: Multiple screens use `navigate(-1)` which fails on direct links.

```
SOURCE: apps/web/src/screens/stories/FamilyStoryScreen.jsx
┌─────────────────────────────────────────────────────────┐
│ Line 16: onClick={() => navigate(-1)}
│ ISSUE: If user:
│   1. Bookmarks /stories/my-story
│   2. Opens app fresh and navigates to URL directly
│   3. Clicks "Back" button
│   4. navigate(-1) has nowhere to go → stays on screen
│           or jumps to home (unpredictable)
└─────────────────────────────────────────────────────────┘
```

**Fix**: Use location state to track origin:
```jsx
// FamilyStoryScreen.jsx
const navigate = useNavigate();
const location = useLocation();

const handleBack = () => {
  // If user came from a previous screen, go back
  // Otherwise, go to stories list
  if (location.state?.from) {
    navigate(location.state.from);
  } else {
    navigate('/stories');
  }
};

// And when linking TO this screen:
<Link 
  to="/stories/my-story" 
  state={{ from: location.pathname }}
>
  View Story
</Link>
```

---

### 6. Modal/Dialog Not Properly Stacked

**Problem**: Settings screens open modals but there's no Z-index strategy.

```
Scenario:
1. User opens SettingsScreen
2. User clicks "Change Privacy Rules" → PrivacyRulesScreen
3. User clicks "View Restricted Demo" → Modal opens
4. Modal is behind previous screen's elements
5. User can't interact with modal

SOURCE: apps/web/src/screens/settings/infrastructure/VaultHealthScreen.jsx
┌─────────────────────────────────────────────────────────┐
│ No modal component visible in code
│ Just text: "pb-28", "pb-6", "pb-20" padding hacks
│ Suggests modals are not implemented
└─────────────────────────────────────────────────────────┘
```

**Fix**: Create reusable Modal component:
```jsx
// apps/web/src/components/ui/Modal.jsx
export function Modal({ isOpen, onClose, children }) {
  if (!isOpen) return null;
  
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      {/* Backdrop */}
      <div 
        className="absolute inset-0 bg-black/50"
        onClick={onClose}
      />
      
      {/* Modal content */}
      <div className="relative bg-white dark:bg-gray-900 rounded-lg p-6 max-w-md shadow-xl">
        <button 
          onClick={onClose}
          className="absolute top-4 right-4"
        >
          ✕
        </button>
        {children}
      </div>
    </div>
  );
}
```

Then use consistently across all screens.

---

## 📱 MOBILE-SPECIFIC BROKEN LINKS

### 7. Deep Links Not Handled

**Current State**:
```dart
// apps/mobile/lib/main.dart
'dev-menu': (context) => const DevMenuScreen(),

// ✅ Can navigate programmatically: Navigator.pushNamed(context, '/dev-menu')
// ❌ Cannot open from external link: aevum://dev-menu
```

**Fix with GoRouter**:
```dart
// Firebase Dynamic Links or Deeplink handling
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const IntroPageScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
      routes: [
        GoRoute(
          path: 'family-tree/:familyId',
          builder: (context, state) => FamilyTreeScreen(
            familyId: state.pathParameters['familyId']!,
          ),
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    // Handle Firebase Dynamic Links
    // if (state.uri.host == 'myapp.page.link') ...
  },
);
```

---

## 🔧 QUICK FIX CHECKLIST

Print this and check off as you fix:

### Web App
- [ ] Add PrivacySecurityScreen route to App.jsx
- [ ] Add RestrictedProfileScreen with :section param
- [ ] Update all `navigate(-1)` to use location state
- [ ] Create NotFoundScreen (shows on /nonexistent)
- [ ] Add ErrorBoundary wrapper in App.jsx
- [ ] Create admin nav (link from dashboard if user.isAdmin)
- [ ] Test all routes in BottomNav (5 items all work)
- [ ] Fix storybook config (npm run storybook works)
- [ ] Verify path aliases in vite.config.js

### Mobile App
- [ ] Replace all `Navigator.pushNamed()` with GoRouter
- [ ] Implement deep link handler for notifications
- [ ] Add android.intent-filter for deep linking (AndroidManifest.xml)
- [ ] Add associated domains for deep linking (iOS)
- [ ] Test all 39 routes are reachable (even if hidden)
- [ ] Admin screens gated by role check

### Firebase
- [ ] Deploy updated firestore.rules
- [ ] Add missing collections to rules (ai_tasks, search_index, etc.)
- [ ] Deploy updated storage.rules
- [ ] Add composite indexes (firestore.indexes.json)
- [ ] Test with emulator locally

---

## 🧪 Testing Commands

```bash
# Test web routing
cd apps/web
npm run dev
# Manually visit each route:
# http://localhost:5173/
# http://localhost:5173/dashboard
# http://localhost:5173/family-tree
# http://localhost:5173/memories
# http://localhost:5173/settings
# http://localhost:5173/settings/privacy-rules
# http://localhost:5173/settings/privacy-security (after fix)
# http://localhost:5173/settings/restricted-profile/demo (after fix)

# Test mobile routing
cd apps/mobile
flutter run
# Use Android emulator to test deep links:
adb shell am start -W -a android.intent.action.VIEW -d "aevum://dashboard" com.aevum.app

# Test Firebase Rules
firebase emulators:start
firebase login
firebase emulators:start
# In another terminal:
npm run test:emulator
```

---

**Last Updated**: February 13, 2026  
**Status**: Implementation Guide Ready  
**Next Step**: Assign each section to responsible engineer
