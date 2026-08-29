import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeritageBottomNav extends StatelessWidget {
  final int selectedIndex;

  const HeritageBottomNav({
    super.key,
    int? selectedIndex,
    int? activeIndex,
  }) : selectedIndex = selectedIndex ?? activeIndex ?? 0;

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return;

    final routes = ['/dashboard', '/tree', '/upload', '/memories', '/profile-main'];
    if (index < routes.length) {
      if (index != 2) {
        context.push(routes[index]);
      } else {
        _showAddMenu(context);
      }
    }
  }

  void _showAddMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 250,
        decoration: const BoxDecoration(
          color: Color(0xFF1E293B),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton(
                  context,
                  Icons.person_add,
                  "Invite",
                  Colors.blue,
                  () {
                    context.pop();
                    context.push('/invite');
                  },
                ),
                _actionButton(
                  context,
                  Icons.upload_file,
                  "Media",
                  Colors.purple,
                  () {
                    context.pop();
                    context.push('/upload');
                  },
                ),
                _actionButton(
                  context,
                  Icons.mic,
                  "Story",
                  Colors.orange,
                  () {
                    context.pop();
                    context.push('/family-branches');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context, IconData icon, String label,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => _onItemTapped(context, index),
      backgroundColor: const Color(0xFF0F172A),
      selectedItemColor: const Color(0xFF1173D4),
      unselectedItemColor: Colors.white38,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.account_tree), label: 'Tree'),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            backgroundColor: Color(0xFF1173D4),
            radius: 24,
            child: Icon(Icons.add, color: Colors.white),
          ),
          label: 'Add',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.photo_library), label: 'Memories'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
