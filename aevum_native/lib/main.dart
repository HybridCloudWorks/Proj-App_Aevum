import 'package:flutter/material.dart';
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

void main() {
  runApp(const AevumApp());
}

class AevumApp extends StatelessWidget {
  const AevumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aevum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF1173D4),
        scaffoldBackgroundColor: const Color(0xFF0B1121),
        useMaterial3: true,
      ),
      home: const HeritageMapScreen(),
      routes: {
        '/restoration': (context) => const RestorationScreen(),
        '/memories': (context) => const MemberMemoriesScreen(),
        '/invite': (context) => const InviteMemberScreen(),
        '/map': (context) => const HeritageMapScreen(),
        '/upload': (context) => const HeritageUploadScreen(),
        '/messenger': (context) => const HeritageMessengerScreen(),
        '/ai-identity': (context) => const AIIdentityMatcherScreen(),
        '/ai-chronicles': (context) => const AIFamilyChroniclesScreen(),
        '/tree': (context) => const FamilyTreeExplorerScreen(),
        '/identify-tree': (context) => const IdentifyGrowTreeScreen(),
        '/admin-sync': (context) => const AdminSyncConflictScreen(),
        '/admin-delegation': (context) => const AdminDelegationScreen(),
        '/admin-infra': (context) => const AdminInfrastructureControlScreen(),
        '/admin-audit': (context) => const AdminFinalAuditScreen(),
        '/legacy-handover': (context) => const LegacyHandoverScreen(),
        '/admin-ai-engine': (context) => const AdminAIEngineScreen(),
        '/admin-ai-restoration': (context) => const AdminAIRestorationScreen(),
        '/admin-spatial': (context) => const AdminSpatialExplorerScreen(),
        '/admin-storage': (context) => const AdminStorageSetupScreen(),
        '/admin-roles': (context) => const AdminRoleManagementScreen(),
        '/admin-catalog': (context) => const AdminCatalogEngineScreen(),
        '/admin-launch': (context) => const AdminAlphaLaunchScreen(),
        '/admin-architecture': (context) =>
            const AdminStorageArchitectureScreen(),
        '/admin-privacy': (context) => const AdminPrivacySecurityScreen(),
        '/onboarding-journey': (context) => const OnboardingJourneyScreen(),
        '/search': (context) => const HeritageSearchScreen(),
        '/restricted-profile': (context) => const RestrictedProfileScreen(),
        '/media-detail': (context) => MediaDetailScreen(
          imageUrl:
              ModalRoute.of(context)!.settings.arguments as String? ??
              "https://placeholder.com",
          title: "Family Memory",
          year: "1968",
          location: "New York, USA",
        ),
      },
    );
  }
}
