import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DevMenuScreen extends StatelessWidget {
  const DevMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1015),
      appBar: AppBar(
        title: Text(
          'Aevum Dev Menu',
          style: GoogleFonts.plusJakartaSans(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSection('Core Flows'),
          _buildNavItem(
            context,
            'Onboarding Journey',
            '/onboarding-journey',
            Icons.rocket_launch,
          ),
          _buildNavItem(context, 'Heritage Map (Home)', '/map', Icons.map),
          _buildNavItem(context, 'Global Search', '/search', Icons.search),
          _buildNavItem(
            context,
            'Restricted Profile',
            '/restricted-profile',
            Icons.person_off,
          ),
          _buildNavItem(
            context,
            'Media Detail (Example)',
            '/media-detail',
            Icons.photo,
          ),

          const SizedBox(height: 20),
          _buildSection('Family Social'),
          _buildNavItem(context, 'Invite Member', '/invite', Icons.group_add),
          _buildNavItem(
            context,
            'Family Memories',
            '/memories',
            Icons.collections_bookmark,
          ),
          _buildNavItem(context, 'Messenger', '/messenger', Icons.chat),

          const SizedBox(height: 20),
          _buildSection('Data & Upload'),
          _buildNavItem(
            context,
            'Restoration Controls',
            '/restoration',
            Icons.tune,
          ),
          _buildNavItem(context, 'Upload Center', '/upload', Icons.upload_file),

          const SizedBox(height: 20),
          _buildSection('Admin Infrastructure'),
          _buildNavItem(
            context,
            'Infrastructure Control',
            '/admin-infra',
            Icons.settings_system_daydream,
          ),
          _buildNavItem(
            context,
            'AI Engine Monitor',
            '/admin-ai-engine',
            Icons.psychology,
          ),
          _buildNavItem(
            context,
            'Sync Conflict Resolver',
            '/admin-sync',
            Icons.sync_problem,
          ),
          _buildNavItem(
            context,
            'Final Audit Log',
            '/admin-audit',
            Icons.check_circle_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String title,
    String route,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1173D4)),
        title: Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.white30,
        ),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
