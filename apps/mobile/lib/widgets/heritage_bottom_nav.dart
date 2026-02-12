import 'package:flutter/material.dart';
import 'dart:ui';

class HeritageBottomNav extends StatelessWidget {
  final int activeIndex;

  const HeritageBottomNav({super.key, this.activeIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 72,
              width: 320,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF101922).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _bottomNavIcon(
                    context,
                    Icons.grid_view_rounded,
                    '/dashboard',
                    activeIndex == 0,
                  ),
                  _bottomNavIcon(
                    context,
                    Icons.map_rounded,
                    '/map',
                    activeIndex == 1,
                  ),
                  // Center FAB
                  _buildCenterFAB(context),
                  _bottomNavIcon(
                    context,
                    Icons.account_tree_rounded,
                    '/tree',
                    activeIndex == 2,
                  ),
                  _bottomNavIcon(
                    context,
                    Icons.person_rounded,
                    '/profile-main',
                    activeIndex == 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterFAB(BuildContext context) {
    return GestureDetector(
      onTap: () => _showInvitePopup(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFF1173D4), Color(0xFF00E0FF)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1173D4).withValues(alpha: 0.4),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(color: const Color(0xFF101922), width: 4),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }

  Widget _bottomNavIcon(
    BuildContext context,
    IconData icon,
    String route,
    bool active,
  ) {
    return GestureDetector(
      onTap: () {
        if (!active) {
          Navigator.pushNamed(context, route);
        }
      },
      child: SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: Icon(
            icon,
            color: active ? const Color(0xFF1173D4) : Colors.grey[600],
            size: 28,
          ),
        ),
      ),
    );
  }

  void _showInvitePopup(BuildContext context) {
    // This is a duplicate of DashboardScreen._showInvitePopup
    // In a real app, this should be a shared widget too
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: const Color(0xFF101922).withValues(alpha: 0.95),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Text(
                  "Extend Your Living History",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                _popupActionCard(
                  context,
                  icon: Icons.person_add,
                  title: "Family Member",
                  subtitle: "Invite an individual to your family tree",
                  color: const Color(0xFF1173D4),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/invite');
                  },
                ),
                const SizedBox(height: 16),
                _popupActionCard(
                  context,
                  icon: Icons.account_tree,
                  title: "Family Branch",
                  subtitle: "Create a new ancestral line or branch",
                  color: Colors.purpleAccent,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/family-branches');
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _popupActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white24),
          ],
        ),
      ),
    );
  }
}


