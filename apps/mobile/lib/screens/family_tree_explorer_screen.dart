import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aevum_native/models/family_member.dart';
import 'dart:ui';
import 'package:aevum_native/widgets/smart_navigation_wrapper.dart';
import 'package:aevum_native/widgets/heritage_top_nav.dart';
import 'package:aevum_native/widgets/heritage_bottom_nav.dart';

class FamilyTreeExplorerScreen extends StatefulWidget {
  const FamilyTreeExplorerScreen({super.key});

  @override
  State<FamilyTreeExplorerScreen> createState() =>
      _FamilyTreeExplorerScreenState();
}

class _FamilyTreeExplorerScreenState extends State<FamilyTreeExplorerScreen> {
  bool _isShowingBranchProfile = false;
  String? _selectedMemberId;

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
            color: const Color(0xFF0F172A).withValues(alpha: 0.9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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
        color: Colors.white.withValues(alpha: 0.05),
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
      body: SmartNavigationWrapper(
        topNav: const HeritageTopNav(
          title: "Johnson Family Tree",
          subtitle: "Active Archive • 32 Members",
        ),
        bottomNav: const HeritageBottomNav(activeIndex: 0),
        child: Stack(
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
                    // Parents
                    Positioned(
                      top: 100,
                      left: 400,
                      child: _treeNode(mockFamily[0]),
                    ),
                    Positioned(
                      top: 100,
                      left: 600,
                      child: _treeNode(mockFamily[1]),
                    ),
                    // Children
                    Positioned(
                      top: 400,
                      left: 500,
                      child: _treeNode(mockFamily[2]),
                    ),
                    // Transparent "+" between parents
                    Positioned(top: 170, left: 575, child: _branchPlusButton()),
                  ],
                ),
              ),
            ),
            _buildZoomControls(),
            if (_isShowingBranchProfile) _buildBranchProfileOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchProfileOverlay() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () => setState(() => _isShowingBranchProfile = false),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: const Color(0xFF101922).withValues(alpha: 0.9),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Family Branch Profile",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Sterling — Beaumont Lineage",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white38,
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 60),
                  // Mini Static Tree
                  SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Parents
                        Positioned(
                          top: 0,
                          left: MediaQuery.of(context).size.width / 2 - 120,
                          child: _miniNode(mockFamily[0], "Mother"),
                        ),
                        Positioned(
                          top: 0,
                          right: MediaQuery.of(context).size.width / 2 - 120,
                          child: _miniNode(mockFamily[1], "Father"),
                        ),
                        // Connector
                        Positioned(
                          top: 45,
                          child: Container(
                            width: 80,
                            height: 2,
                            color: Colors.white10,
                          ),
                        ),
                        // Children
                        Positioned(
                          top: 180,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _miniNode(mockFamily[2], "Son"),
                              const SizedBox(width: 40),
                              _miniNode(mockFamily[2], "Daughter"),
                            ],
                          ),
                        ),
                        // Vertical Connector
                        Positioned(
                          top: 45,
                          child: Container(
                            height: 135,
                            width: 2,
                            color: Colors.white10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  Text(
                    "TAP ANYWHERE TO RETURN",
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF0EA5E9),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _miniNode(FamilyMember member, String role) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white24, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 20,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(member.imageUrl),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          role.toUpperCase(),
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white38,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundGrid() {
    return Positioned.fill(child: CustomPaint(painter: DotGridPainter()));
  }

  Widget _buildLine(double x1, double y1, double x2, double y2) {
    return CustomPaint(painter: LinePainter(Offset(x1, y1), Offset(x2, y2)));
  }

  Widget _branchPlusButton() {
    return GestureDetector(
      onTap: () => setState(() => _isShowingBranchProfile = true),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: const Icon(Icons.add, color: Colors.white24, size: 20),
      ),
    );
  }

  Widget _treeNode(FamilyMember member) {
    bool isSelected = _selectedMemberId == member.id;
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedMemberId == member.id) {
            _selectedMemberId = null;
          } else {
            _selectedMemberId = member.id;
          }
        });
        _showRelativeProfile(member);
      },
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0EA5E9).withValues(alpha: 0.2)
              : const Color(0xFF1E293B).withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0EA5E9)
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color(0xFF0EA5E9).withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: isSelected
                      ? [const Color(0xFF0EA5E9), const Color(0xFF22C55E)]
                      : [const Color(0xFF0EA5E9), const Color(0xFF6366F1)],
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
                color: isSelected ? const Color(0xFF0EA5E9) : Colors.white38,
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
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

class DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
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
      ..color = Colors.white.withValues(alpha: 0.15)
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


