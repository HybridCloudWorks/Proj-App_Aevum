import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminSpatialExplorerScreen extends StatelessWidget {
  const AdminSpatialExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1121),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              const Color(0xFF1E1B4B).withOpacity(0.3),
              const Color(0xFF0B1121),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Stack(
                  children: [_buildLineageNodes(), _buildSelectedMemberInfo()],
                ),
              ),
              _buildBottomControls(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _frostedIconButton(Icons.arrow_back),
          const SizedBox(width: 8),
          Expanded(
            child: _frostedChip(
              Row(
                children: [
                  const Icon(Icons.hub, color: Color(0xFF1173d4), size: 18),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Aevum",
                        style: GoogleFonts.manrope(
                          fontSize: 10,
                          color: Colors.white38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Spatial",
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _frostedChip(
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100",
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "The Sterling",
                          style: GoogleFonts.manrope(
                            fontSize: 9,
                            color: Colors.white38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Lineage",
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            height: 1.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          _frostedIconButton(Icons.search),
        ],
      ),
    );
  }

  Widget _frostedIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _frostedChip(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: child,
    );
  }

  Widget _buildLineageNodes() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background connections (abstract)
          CustomPaint(size: const Size(300, 400), painter: ConnectionPainter()),
          // Generation 1
          Positioned(
            top: 0,
            left: 20,
            child: _memberAvatar(
              "Eleanor",
              "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200",
              size: 80,
            ),
          ),
          Positioned(
            top: 0,
            left: 120,
            child: _memberAvatar(
              "Arthur",
              "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200",
              size: 80,
            ),
          ),

          // Generation 2
          Positioned(
            top: 180,
            left: -40,
            child: _memberAvatar(
              "Sarah",
              "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200",
              size: 100,
            ),
          ),
          Positioned(
            top: 180,
            left: 140,
            child: _memberAvatar(
              "James",
              "https://images.unsplash.com/photo-1463453091185-61582044d556?w=200",
              size: 100,
            ),
          ),

          // Generation 3 (Focus)
          Positioned(
            top: 320,
            left: 30,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1173d4).withOpacity(0.5),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: _memberAvatar(
                "Clara",
                "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400",
                size: 160,
                isFocus: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _memberAvatar(
    String name,
    String url, {
    double size = 60,
    bool isFocus = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isFocus ? const Color(0xFF1173d4) : Colors.white24,
              width: isFocus ? 3 : 1,
            ),
            image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            name,
            style: GoogleFonts.manrope(
              fontSize: size > 100 ? 14 : 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedMemberInfo() {
    return Positioned(
      bottom: 120,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Text(
            "Clara Sterling",
            style: GoogleFonts.manrope(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navAction(Icons.zoom_out_map, "Expand"),
          _navAction(Icons.manage_search, "Explore", isActive: true),
          _navAction(Icons.share, "Share"),
        ],
      ),
    );
  }

  Widget _navAction(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF1173d4).withOpacity(0.2)
                : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? const Color(0xFF1173d4) : Colors.transparent,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: const Color(0xFF1173d4).withOpacity(0.2),
                      blurRadius: 10,
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.white : Colors.white38,
            size: 24,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.white24,
          ),
        ),
      ],
    );
  }
}

class ConnectionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw abstract connections
    final path = Path();
    path.moveTo(size.width / 2, 80);
    path.quadraticBezierTo(size.width / 2, 130, 20, 180);
    path.moveTo(size.width / 2, 80);
    path.quadraticBezierTo(size.width / 2, 130, size.width - 20, 180);

    path.moveTo(20, 280);
    path.quadraticBezierTo(size.width / 2, 300, size.width / 2, 320);
    path.moveTo(size.width - 20, 280);
    path.quadraticBezierTo(size.width / 2, 300, size.width / 2, 320);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
