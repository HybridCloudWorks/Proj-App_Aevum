import 'package:flutter/material.dart';
import '../../widgets/glass_card.dart';

class CustomBottomNavBarVariant1 extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBarVariant1({
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
        height: 80,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: GlassCard(
                borderRadius: 24.0,
                backgroundColor: const Color(0xCC1F2937),
                blurAmount: 20.0,
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                child: SizedBox(
                  height: 56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildNavItem(Icons.home, 0),
                      _buildNavItem(Icons.diversity_2, 1),
                      const SizedBox(width: 48),
                      _buildNavItem(Icons.search, 3),
                      _buildNavItem(Icons.person, 4),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 0,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Colors.indigo], // Blue to Indigo
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: const Color(0xFF111827), width: 6), // Thicker border
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
          color: isSelected ? Colors.white : Colors.grey[500],
          size: 28,
        ),
        onPressed: () => onTap(index),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
