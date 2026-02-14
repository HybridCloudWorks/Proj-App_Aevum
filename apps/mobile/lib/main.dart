import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aevum_native/screens/invite_member_screen.dart';
import 'package:aevum_native/screens/heritage_map_screen.dart';
import 'package:aevum_native/screens/heritage_upload_screen.dart';
import 'package:aevum_native/screens/heritage_messenger_screen.dart';
import 'package:aevum_native/screens/restoration_screen.dart';
import 'package:aevum_native/screens/member_memories_screen.dart';
import 'package:aevum_native/screens/ai_identity_matcher_screen.dart';
import 'package:aevum_native/screens/ai_family_chronicles_screen.dart';
import 'package:aevum_native/screens/family_tree_explorer_screen.dart';
import 'package:aevum_native/screens/identify_grow_tree_screen.dart';
import 'package:aevum_native/screens/admin_sync_conflict_screen.dart';
import 'package:aevum_native/screens/admin_delegation_screen.dart';
import 'package:aevum_native/screens/admin_infrastructure_control_screen.dart';
import 'package:aevum_native/screens/admin_final_audit_screen.dart';
import 'package:aevum_native/screens/legacy_handover_screen.dart';
import 'package:aevum_native/screens/admin_ai_engine_screen.dart';
import 'package:aevum_native/screens/admin_ai_restoration_screen.dart';
import 'package:aevum_native/screens/admin_spatial_explorer_screen.dart';
import 'package:aevum_native/screens/admin_storage_setup_screen.dart';
import 'package:aevum_native/screens/admin_role_management_screen.dart';
import 'package:aevum_native/screens/admin_catalog_engine_screen.dart';
import 'package:aevum_native/screens/admin_alpha_launch_screen.dart';
import 'package:aevum_native/screens/admin_storage_architecture_screen.dart';
import 'package:aevum_native/screens/admin_privacy_security_screen.dart';
import 'package:aevum_native/screens/onboarding_journey_screen.dart';
import 'package:aevum_native/screens/heritage_search_screen.dart';
import 'package:aevum_native/screens/restricted_profile_screen.dart';
import 'package:aevum_native/screens/media_detail_screen.dart';
import 'package:aevum_native/screens/dev_menu_screen.dart';
import 'package:aevum_native/screens/intro_page_screen.dart';
import 'package:aevum_native/screens/auth_screen.dart';
import 'package:aevum_native/screens/profile_screen.dart';
import 'package:aevum_native/screens/dashboard_screen.dart';
import 'package:aevum_native/screens/plant_branch_screen.dart';
import 'package:aevum_native/screens/family_branch_navigator_screen.dart';
import 'package:aevum_native/screens/semantic_discovery_screen.dart';
import 'package:aevum_native/screens/vault_sync_health_screen.dart';
import 'package:aevum_native/screens/cloud_redundancy_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AevumApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(child: Text('Page not found: ${state.uri}')),
  ),
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const IntroPageScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/dev-menu',
      name: 'dev-menu',
      builder: (context, state) => const DevMenuScreen(),
    ),
    GoRoute(
      path: '/profile-main',
      name: 'profile-main',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/restoration',
      name: 'restoration',
      builder: (context, state) => const RestorationScreen(),
    ),
    GoRoute(
      path: '/memories',
      name: 'memories',
      builder: (context, state) => const MemberMemoriesScreen(),
    ),
    GoRoute(
      path: '/invite',
      name: 'invite',
      builder: (context, state) => const InviteMemberScreen(),
    ),
    GoRoute(
      path: '/map',
      name: 'map',
      builder: (context, state) => const HeritageMapScreen(),
    ),
    GoRoute(
      path: '/upload',
      name: 'upload',
      builder: (context, state) => const HeritageUploadScreen(),
    ),
    GoRoute(
      path: '/messenger',
      name: 'messenger',
      builder: (context, state) => const HeritageMessengerScreen(),
    ),
    GoRoute(
      path: '/ai-identity',
      name: 'ai-identity',
      builder: (context, state) => const AIIdentityMatcherScreen(),
    ),
    GoRoute(
      path: '/ai-chronicles',
      name: 'ai-chronicles',
      builder: (context, state) => const AIFamilyChroniclesScreen(),
    ),
    GoRoute(
      path: '/tree',
      name: 'tree',
      builder: (context, state) => const FamilyTreeExplorerScreen(),
    ),
    GoRoute(
      path: '/identify-tree',
      name: 'identify-tree',
      builder: (context, state) => const IdentifyGrowTreeScreen(),
    ),
    GoRoute(
      path: '/admin-sync',
      name: 'admin-sync',
      builder: (context, state) => const AdminSyncConflictScreen(),
    ),
    GoRoute(
      path: '/admin-delegation',
      name: 'admin-delegation',
      builder: (context, state) => const AdminDelegationScreen(),
    ),
    GoRoute(
      path: '/admin-infra',
      name: 'admin-infra',
      builder: (context, state) => const AdminInfrastructureControlScreen(),
    ),
    GoRoute(
      path: '/admin-audit',
      name: 'admin-audit',
      builder: (context, state) => const AdminFinalAuditScreen(),
    ),
    GoRoute(
      path: '/legacy-handover',
      name: 'legacy-handover',
      builder: (context, state) => const LegacyHandoverScreen(),
    ),
    GoRoute(
      path: '/admin-ai-engine',
      name: 'admin-ai-engine',
      builder: (context, state) => const AdminAIEngineScreen(),
    ),
    GoRoute(
      path: '/admin-ai-restoration',
      name: 'admin-ai-restoration',
      builder: (context, state) => const AdminAIRestorationScreen(),
    ),
    GoRoute(
      path: '/admin-spatial',
      name: 'admin-spatial',
      builder: (context, state) => const AdminSpatialExplorerScreen(),
    ),
    GoRoute(
      path: '/admin-storage',
      name: 'admin-storage',
      builder: (context, state) => const AdminStorageSetupScreen(),
    ),
    GoRoute(
      path: '/admin-roles',
      name: 'admin-roles',
      builder: (context, state) => const AdminRoleManagementScreen(),
    ),
    GoRoute(
      path: '/admin-catalog',
      name: 'admin-catalog',
      builder: (context, state) => const AdminCatalogEngineScreen(),
    ),
    GoRoute(
      path: '/admin-launch',
      name: 'admin-launch',
      builder: (context, state) => const AdminAlphaLaunchScreen(),
    ),
    GoRoute(
      path: '/admin-architecture',
      name: 'admin-architecture',
      builder: (context, state) => const AdminStorageArchitectureScreen(),
    ),
    GoRoute(
      path: '/admin-privacy',
      name: 'admin-privacy',
      builder: (context, state) => const AdminPrivacySecurityScreen(),
    ),
    GoRoute(
      path: '/onboarding-journey',
      name: 'onboarding-journey',
      builder: (context, state) => const OnboardingJourneyScreen(),
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => const HeritageSearchScreen(),
    ),
    GoRoute(
      path: '/restricted-profile',
      name: 'restricted-profile',
      builder: (context, state) => const RestrictedProfileScreen(),
    ),
    GoRoute(
      path: '/media-detail',
      name: 'media-detail',
      builder: (context, state) {
        final imageUrl = state.extra as String? ?? "https://placeholder.com";
        return MediaDetailScreen(
          imageUrl: imageUrl,
          title: "Family Memory",
          year: "1968",
          location: "New York, USA",
        );
      },
    ),
    GoRoute(
      path: '/plant-branch',
      name: 'plant-branch',
      builder: (context, state) => const PlantBranchScreen(),
    ),
    GoRoute(
      path: '/family-branches',
      name: 'family-branches',
      builder: (context, state) => const FamilyBranchNavigatorScreen(),
    ),
    GoRoute(
      path: '/discovery',
      name: 'discovery',
      builder: (context, state) => const SemanticDiscoveryScreen(),
    ),
    GoRoute(
      path: '/vault-health',
      name: 'vault-health',
      builder: (context, state) => const VaultSyncHealthScreen(),
    ),
    GoRoute(
      path: '/cloud-redundancy',
      name: 'cloud-redundancy',
      builder: (context, state) => const CloudRedundancyScreen(),
    ),
  ],
);

class AevumApp extends StatelessWidget {
  const AevumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Aevum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF1173D4),
        scaffoldBackgroundColor: const Color(0xFF0B1121),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
