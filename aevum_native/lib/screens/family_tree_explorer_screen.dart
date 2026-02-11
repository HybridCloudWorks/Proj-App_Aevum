import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class FamilyTreeExplorerScreen extends StatelessWidget {
  const FamilyTreeExplorerScreen({super.key});

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
              "Last edited 2h ago",
              style: GoogleFonts.manrope(fontSize: 11, color: Colors.white54),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF1173d4),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_add, color: Colors.white, size: 20),
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Grid
          _buildBackgroundGrid(),

          // Interactive Tree Area
          InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(100),
            minScale: 0.1,
            maxScale: 2.0,
            child: SizedBox(
              width: 1000,
              height: 1000,
              child: Stack(
                children: [
                  // Lines
                  _buildLine(500, 200, 500, 400),
                  _buildLine(500, 400, 750, 400),
                  _buildLine(550, 400, 550, 450),

                  // Nodes
                  Positioned(
                    top: 100,
                    left: 420,
                    child: _treeNode(
                      "Great Grandma",
                      "1920 - 1998",
                      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100",
                      isCompact: true,
                    ),
                  ),
                  Positioned(
                    top: 250,
                    left: 380,
                    child: _treeNode(
                      "Grandpa John",
                      "1945 - 2018",
                      "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
                    ),
                  ),
                  Positioned(
                    top: 500,
                    left: 450,
                    child: _treeNode(
                      "Michael Johns...",
                      "1970 - Present",
                      "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
                      label: "FATHER",
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Zoom Controls
          Positioned(
            bottom: 120,
            left: 20,
            child: Column(
              children: [
                _controlButton(Icons.add),
                const SizedBox(height: 12),
                _controlButton(Icons.remove),
              ],
            ),
          ),

          // Focus Control
          Positioned(
            bottom: 120,
            right: 20,
            child: _controlButton(Icons.center_focus_strong, isPrimary: true),
          ),

          // Bottom Nav
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildBackgroundGrid() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(painter: DotGridPainter()),
    );
  }

  Widget _buildLine(double x1, double y1, double x2, double y2) {
    return CustomPaint(painter: LinePainter(Offset(x1, y1), Offset(x2, y2)));
  }

  Widget _treeNode(
    String name,
    String years,
    String url, {
    String? label,
    bool isCompact = false,
  }) {
    return Container(
      width: isCompact ? 140 : 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF151C2E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: isCompact ? 28 : 35,
            backgroundImage: NetworkImage(url),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: GoogleFonts.manrope(
              fontSize: isCompact ? 13 : 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            years,
            style: GoogleFonts.manrope(fontSize: 10, color: Colors.white38),
          ),
          if (label != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1173d4).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                label,
                style: GoogleFonts.manrope(
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1173d4),
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _controlButton(IconData icon, {bool isPrimary = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isPrimary
            ? const Color(0xFF1173d4)
            : Colors.white.withOpacity(0.08),
        shape: BoxShape.circle,
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _buildBottomNav() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF0B1121),
          border: Border(
            top: BorderSide(color: Colors.white.withOpacity(0.05)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.account_tree, "Tree", true),
            _navItem(Icons.photo_library, "Memories", false),
            _navItem(Icons.search, "Search", false),
            _navItem(Icons.person, "Profile", false),
          ],
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
          color: isActive ? const Color(0xFF1173d4) : Colors.white38,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 10,
            color: isActive ? const Color(0xFF1173d4) : Colors.white38,
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
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1.0;

    for (double i = 0; i < size.width; i += 30) {
      for (double j = 0; j < size.height; j += 30) {
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
      ..color = Colors.white24
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(start.dx, start.dy);
    // Draw stepped line
    path.lineTo(start.dx, (start.dy + end.dy) / 2);
    path.lineTo(end.dx, (start.dy + end.dy) / 2);
    path.lineTo(end.dx, end.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
