import 'package:flutter/material.dart';
import 'glass_card.dart';
import '../theme/app_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    this.currentIndex = 0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 24.0, left: 16.0, right: 16.0),
        constraints: const BoxConstraints(maxWidth: 400),
        height: 80, // Height of the bar area + floating button overlap
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            // Glass Card Background with Nav Items
            Padding(
              padding: const EdgeInsets.only(top: 24.0), // Space for the floating button
              child: GlassCard(
                borderRadius: 24.0,
                backgroundColor: const Color(0xCC1F2937), // dark gray with opacity
                blurAmount: 20.0,
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                child: SizedBox(
                  height: 56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildNavItem(Icons.grid_view, 0),
                      _buildNavItem(Icons.history_edu, 1),
                      const SizedBox(width: 48), // Spacer for center button
                      _buildNavItem(Icons.search, 3),
                      _buildNavItem(Icons.settings, 4),
                    ],
                  ),
                ),
              ),
            ),

            // Floating Center Button
            Positioned(
              top: 0,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Colors.purple],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: const Color(0xFF111827), width: 4), // gray-900 border
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => onTap(2),
                    child: const Icon(Icons.add, color: Colors.white, size: 30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = currentIndex == index;
    return Expanded(
      child: IconButton(
        icon: Icon(
          icon,
          color: isSelected ? AppTheme.primary : Colors.grey[400],
          size: 28,
        ),
        onPressed: () => onTap(index),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
