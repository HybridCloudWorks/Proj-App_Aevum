import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          _buildMeshBackground(),
          _buildDecorations(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const Spacer(),
                  _buildHeroSection(),
                  const SizedBox(height: 32),
                  _buildBentoGrid(),
                  const SizedBox(height: 32),
                  _buildStatsRow(),
                  const Spacer(),
                  _buildFooter(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeshBackground() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [Color(0xFF1E1B4B), Colors.transparent],
          ),
        ),
      ),
    );
  }

  Widget _buildDecorations() {
    return Stack(
      children: [
        Positioned(
          top: 80,
          left: -40,
          child: _buildBlurCircle(
            const Color(0xFF1173D4).withValues(alpha: 0.3),
            200,
          ),
        ),
        Positioned(
          bottom: 150,
          right: -50,
          child: _buildBlurCircle(
            const Color(0xFFA855F7).withValues(alpha: 0.2),
            250,
          ),
        ),
      ],
    );
  }

  Widget _buildBlurCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1173D4), Color(0xFF00E0FF)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.all_inclusive,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Aevum",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Skip",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white60,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.plusJakartaSans(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
            children: [
              const TextSpan(text: "Build Your \n"),
              TextSpan(
                text: "Living Legacy",
                style: TextStyle(
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [
                        Color(0xFF93C5FD),
                        Colors.white,
                        Color(0xFFC084FC),
                      ],
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Uncover your roots with AI and preserve your history for generations to come.",
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFFCBD5E1),
            fontSize: 18,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBentoGrid() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          _buildBentoLargeCard(),
          const SizedBox(height: 4),
          Row(
            children: [
              _buildBentoSmallCard(
                Icons.smart_toy,
                "AI Architect",
                "Smart hints from billions of records.",
                const Color(0xFF00E0FF),
              ),
              const SizedBox(width: 4),
              _buildBentoSmallCard(
                Icons.lock,
                "Time Vault",
                "Preserve photos & audio forever.",
                const Color(0xFFA855F7),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBentoLargeCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.account_tree, size: 60, color: Colors.white),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF1173D4).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF1173D4).withValues(alpha: 0.3),
                  ),
                ),
                child: const Icon(
                  Icons.group_add,
                  color: Color(0xFF93C5FD),
                  size: 20,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Collaborative Branch",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Invite family to co-edit your tree. Watch your history grow in real-time.",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBentoSmallCard(
    IconData icon,
    String title,
    String desc,
    Color color,
  ) {
    return Expanded(
      child: Container(
        height: 140,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatItem("10M+", "Records"),
        Container(width: 1, height: 32, color: Colors.white10),
        _buildStatItem("99%", "Accuracy"),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label.toUpperCase(),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF94A3B8),
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/onboarding-journey'),
          child: Container(
            height: 64,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1173D4), Color(0xFF00E0FF)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1173D4).withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Start My Tree",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "By continuing, you agree to our Terms & Privacy.",
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white38,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
