import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aevum_native/models/family_member.dart';
import 'dart:ui';

class FamilyTreeExplorerScreen extends StatefulWidget {
  const FamilyTreeExplorerScreen({super.key});

  @override
  State<FamilyTreeExplorerScreen> createState() =>
      _FamilyTreeExplorerScreenState();
}

class _FamilyTreeExplorerScreenState extends State<FamilyTreeExplorerScreen> {
  void _showRelativeProfile(FamilyMember member) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A).withOpacity(0.9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 32),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(member.imageUrl),
                ),
                const SizedBox(height: 20),
                Text(
                  member.name,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  member.relationship.toUpperCase(),
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF0EA5E9),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  member.lifeSpan,
                  style: GoogleFonts.plusJakartaSans(color: Colors.white54),
                ),
                const SizedBox(height: 32),
                _buildProfileStats(),
                const SizedBox(height: 32),
                _buildLinkedStoriesSection(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statItem("24", "Memories"),
        _statItem("Login", "Restored"),
        _statItem("12", "Stories"),
      ],
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white38,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildLinkedStoriesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "LINKED STORIES",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          _storyCard(
            "The Summer of '68",
            "A warm narrative of the Tuscany gathering...",
            "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=400",
          ),
          const SizedBox(height: 12),
          _storyCard(
            "Legacy Wedding",
            "Preserving the vows taken in the old chapel...",
            "https://images.unsplash.com/photo-1519741497674-611481863552?w=400",
          ),
        ],
      ),
    );
  }

  Widget _storyCard(String title, String snippet, String image) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  snippet,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white24),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1121),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: Column(
          children: [
            Text(
              "Johnson Family Tree",
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Active Archive • 32 Members",
              style: GoogleFonts.manrope(fontSize: 11, color: Colors.white54),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share_outlined,
              color: Colors.white,
              size: 22,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildBackgroundGrid(),
          InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(200),
            minScale: 0.2,
            maxScale: 2.0,
            child: SizedBox(
              width: 1200,
              height: 1200,
              child: Stack(
                children: [
                  // Rendering Mock Tree
                  _buildLine(600, 200, 600, 400),
                  _buildLine(600, 400, 850, 400),
                  _buildLine(650, 400, 650, 450),

                  Positioned(
                    top: 100,
                    left: 520,
                    child: _treeNode(mockFamily[0]),
                  ),
                  Positioned(
                    top: 250,
                    left: 480,
                    child: _treeNode(mockFamily[1]),
                  ),
                  Positioned(
                    top: 500,
                    left: 550,
                    child: _treeNode(mockFamily[2]),
                  ),
                ],
              ),
            ),
          ),
          _buildZoomControls(),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildBackgroundGrid() {
    return Positioned.fill(child: CustomPaint(painter: DotGridPainter()));
  }

  Widget _buildLine(double x1, double y1, double x2, double y2) {
    return CustomPaint(painter: LinePainter(Offset(x1, y1), Offset(x2, y2)));
  }

  Widget _treeNode(FamilyMember member) {
    return GestureDetector(
      onTap: () => _showRelativeProfile(member),
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B).withOpacity(0.9),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF0EA5E9), Color(0xFF6366F1)],
                ),
              ),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(member.imageUrl),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              member.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              member.relationship.toUpperCase(),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: Colors.white38,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZoomControls() {
    return Positioned(
      bottom: 120,
      right: 24,
      child: Column(
        children: [
          _controlButton(Icons.add),
          const SizedBox(height: 12),
          _controlButton(Icons.remove),
          const SizedBox(height: 12),
          _controlButton(Icons.center_focus_strong, isPrimary: true),
        ],
      ),
    );
  }

  Widget _controlButton(IconData icon, {bool isPrimary = false}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFF0EA5E9) : const Color(0xFF1E293B),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildBottomNav() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A).withOpacity(0.8),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.05)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.account_tree, "Tree", true),
              _navItem(Icons.photo_library, "Gallery", false),
              _navItem(Icons.map_outlined, "Map", false),
              _navItem(Icons.settings_outlined, "Settings", false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF0EA5E9) : Colors.white30,
          size: 24,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            color: isActive ? const Color(0xFF0EA5E9) : Colors.white30,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    for (double i = 0; i < size.width; i += 40) {
      for (double j = 0; j < size.height; j += 40) {
        canvas.drawCircle(Offset(i, j), 1.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class LinePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  LinePainter(this.start, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(start.dx, start.dy);
    path.lineTo(start.dx, (start.dy + end.dy) / 2);
    path.lineTo(end.dx, (start.dy + end.dy) / 2);
    path.lineTo(end.dx, end.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
