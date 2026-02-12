import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aevum_native/widgets/smart_navigation_wrapper.dart';
import 'package:aevum_native/widgets/heritage_top_nav.dart';
import 'package:aevum_native/widgets/heritage_bottom_nav.dart';

class SemanticDiscoveryScreen extends StatelessWidget {
  const SemanticDiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: SmartNavigationWrapper(
        topNav: const HeritageTopNav(
          title: "Semantic Discovery",
          subtitle: "AI Analysis Active",
        ),
        bottomNav: const HeritageBottomNav(activeIndex: 1),
        child: Stack(
          children: [
            _buildAmbientGlows(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 80,
                ),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMatchCard(),
                    const SizedBox(height: 24),
                    Text(
                      "AI EVIDENCE ANALYSIS",
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white38,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildEvidenceGrid(),
                    const SizedBox(height: 24),
                    _buildTemporalCard(),
                    const SizedBox(height: 24),
                    _buildProjectedImpact(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAmbientGlows() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: 50,
          right: 50,
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF1173D4).withValues(alpha: 0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 200,
          right: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF22C55E).withValues(alpha: 0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMatchCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFF0EA5E9).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "HIGH CONFIDENCE MATCH",
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF22C55E),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ancestorCircle(
                "Grandfather",
                "https://lh3.googleusercontent.com/aida-public/AB6AXuCcxrzPy7OIC6fd_Q2YDezWIUxp5TQ5fc26rSRExBWQAogSbHqAcIW5X7KuWlU7plAP0P5KH9OR86Z0I-qFYPQIkHsqp_-Xd-bKT6GS_SbQwkMF_v21eWMHQNg-ncKsK7-OX67k9A1pjiZdgepQFPOA7uaYgzbKptnvYNvioTH6t1YsrVLoDcrW92mP2MS1oDyzCDt64EufsU6g4OIatEOy63KXakhwlJMKB2X9LUQnMS2V07kb0vgKx7tJ26GmURB4xILcTyY3So8",
                Colors.white.withValues(alpha: 0.2),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF22C55E).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.link,
                          color: Color(0xFF22C55E),
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "94%",
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF22C55E),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _ancestorCircle(
                "New Ancestor?",
                "https://lh3.googleusercontent.com/aida-public/AB6AXuB5VBZhM5VzXhfu9SvegoT9Pv4b9Fa6pvmZbzfCN90nf3Z-qIcBALR5R2sTODFd3s4N5wkPzKF0dQH8OKfxmkjbyzQ0PUsw3Uk5XPy2tWBN1c2Jj0MexMFQnuquwYFIoj-6cY3407_XOdLvufiH7UzhsAyh66OZCvI_HRuUfR0RmeVYs8N1h7VIw_006yzmqL3kayWER4--oKCJJmhLGsF0f3JM7v6TtC7bF09hXSvzjO19yX8u2p-wcj0bsG7qw35DQpg3hinhxaE",
                const Color(0xFF22C55E).withValues(alpha: 0.5),
                isNew: true,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "Eleanor Vance",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            "Predicted Great-Grandmother (1892 - 1968)",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white38,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ancestorCircle(
    String label,
    String url,
    Color borderColor, {
    bool isNew = false,
  }) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor,
                  width: 2,
                  style: isNew ? BorderStyle.solid : BorderStyle.solid,
                ),
              ),
              child: ClipOval(child: Image.network(url, fit: BoxFit.cover)),
            ),
            if (isNew)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF22C55E),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.black,
                    size: 12,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: isNew ? const Color(0xFF22C55E) : Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildEvidenceGrid() {
    return Row(
      children: [
        Expanded(
          child: _evidenceCard(
            icon: Icons.description,
            title: "CENSUS RECORD",
            desc: "Found matching 'Eleanor V.' in 1920 Census.",
            color: Colors.blue,
            progress: 0.92,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _evidenceCard(
            icon: Icons.face,
            title: "FACIAL FEATURES",
            desc: "Strong similarity to known son (John).",
            color: Colors.purple,
            progress: 0.88,
          ),
        ),
      ],
    );
  }

  Widget _evidenceCard({
    required IconData icon,
    required String title,
    required String desc,
    required Color color,
    required double progress,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white38,
              fontSize: 9,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
          const Spacer(),
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemporalCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.calendar_month,
              color: Colors.orange,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Temporal Consistency",
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "PASS",
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF22C55E),
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Birth date aligns perfectly with known family timeline gaps in registry.",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white30,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectedImpact() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "PROJECTED TREE IMPACT",
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
            Text(
              "View Full Tree",
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF1173D4),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Grid Background
              Positioned.fill(child: CustomPaint(painter: _GridPainter())),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                      border: Border.all(
                        color: const Color(0xFF22C55E),
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF22C55E),
                      size: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 2,
                        ),
                        left: BorderSide(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 2,
                        ),
                        right: BorderSide(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 2,
                        ),
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _treeNodeDot(),
                      const SizedBox(width: 40),
                      _treeNodeDot(isPrimary: true),
                      const SizedBox(width: 40),
                      _treeNodeDot(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _treeNodeDot({bool isPrimary = false}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1E293B),
        border: Border.all(
          color: isPrimary ? const Color(0xFF1173D4) : Colors.white10,
          width: isPrimary ? 2 : 1,
        ),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: const Color(0xFF1173D4).withValues(alpha: 0.5),
                  blurRadius: 10,
                ),
              ]
            : null,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 20,
      right: 20,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF22C55E).withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.call_merge,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Confirm & Merge Branch",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _secondaryButton("Ignore", () {})),
              const SizedBox(width: 12),
              Expanded(
                child: _secondaryButton(
                  "Edit Details",
                  () {},
                  icon: Icons.edit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _secondaryButton(String text, VoidCallback onTap, {IconData? icon}) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.white70, size: 16),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    for (double i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
