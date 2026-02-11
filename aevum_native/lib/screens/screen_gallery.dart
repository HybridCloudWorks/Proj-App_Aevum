import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding/welcome_gallery.dart';
import 'auth/auth_screen.dart';
import 'family_tree/family_tree_explorer_1.dart';
import 'memories/member_memories_1.dart';
import 'heritage/heritage_map_1.dart';
import 'ai_features/ai_identity_matcher_1.dart';
import 'identity/identity_profile.dart';
import 'admin/admin_infrastructure_1.dart';
import 'catalog/catalog_screen.dart';
import 'settings/privacy_settings.dart';
import '../theme/app_theme.dart';

class ScreenGallery extends StatelessWidget {
  const ScreenGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      appBar: AppBar(
        title: Text('Aevum Screen Gallery', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('Onboarding', [
            _buildItem(context, 'Welcome Flow (Gallery)', const WelcomeGallery()),
          ]),
          _buildSection('Authentication', [
            _buildItem(context, 'Auth Screen', const AuthScreen()),
          ]),
          _buildSection('Core App', [
            _buildItem(context, 'Family Tree Explorer', const FamilyTreeExplorer1()),
            _buildItem(context, 'AI Restoration (Memories)', const MemberMemories1()),
            _buildItem(context, 'Upload Center (Heritage Map)', const HeritageMap1()),
          ]),
          _buildSection('Features', [
            _buildItem(context, 'AI Identity Matcher', const AIIdentityMatcher1()),
            _buildItem(context, 'Identity Profile', const IdentityProfile()),
          ]),
          _buildSection('Admin & Tools', [
            _buildItem(context, 'Deployment Center (Admin)', const AdminInfrastructure1()),
            _buildItem(context, 'Catalog Engine', const CatalogScreen()),
            _buildItem(context, 'Privacy Settings', const PrivacySettings()),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
              letterSpacing: 1.0,
            ),
          ),
        ),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildItem(BuildContext context, String title, Widget screen) {
    return Card(
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title, style: GoogleFonts.manrope(color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}
