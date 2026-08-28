import 'package:aevum_native/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/glass_card.dart';
import '../widgets/heritage_bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    final User? user = FirebaseAuth.instance.currentUser;
    final String name = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!.trim()
        : 'Aevum Member';
    final String subtitle = user?.email ?? 'Authenticated family member';
    final String? photoUrl = user?.photoURL;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF0F172A),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blueAccent, Color(0xFF0F172A)],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            photoUrl != null ? NetworkImage(photoUrl) : null,
                        child: photoUrl == null
                            ? const Icon(Icons.person, size: 48)
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSection('Account', [
                  _menuItem(context, Icons.person, 'Personal Info', () {}),
                  _menuItem(context, Icons.security, 'Privacy & Security', () {}),
                ]),
                const SizedBox(height: 24),
                _buildSection('Family Features', [
                  _menuItem(
                    context,
                    Icons.auto_stories,
                    'Chronicles',
                    () => context.push('/ai-chronicles'),
                  ),
                  _menuItem(
                    context,
                    Icons.photo_library,
                    'Memories',
                    () => context.push('/memories'),
                  ),
                  _menuItem(
                    context,
                    Icons.map,
                    'Heritage Map',
                    () => context.push('/map'),
                  ),
                  _menuItem(
                    context,
                    Icons.restore,
                    'Restoration Lab',
                    () => context.push('/restoration'),
                  ),
                ]),
                const SizedBox(height: 24),
                FutureBuilder<bool>(
                  future: auth.isAdmin(),
                  builder: (context, snapshot) {
                    final items = <Widget>[];
                    if (snapshot.data == true) {
                      items.add(
                        _menuItem(
                          context,
                          Icons.admin_panel_settings,
                          'Dev Menu',
                          () => context.push('/dev-menu'),
                        ),
                      );
                    }
                    items.add(
                      _menuItem(
                        context,
                        Icons.logout,
                        'Log Out',
                        () async => auth.signOut(),
                      ),
                    );
                    return _buildSection('Session', items);
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const HeritageBottomNav(selectedIndex: 4),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        GlassCard(child: Column(children: children)),
      ],
    );
  }

  Widget _menuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white54,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}
