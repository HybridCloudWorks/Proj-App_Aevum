import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _autoLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101122),
      body: Stack(
        children: [
          _buildMeshBackground(),
          _buildDecorations(),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _buildAuthCard(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeshBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.5,
          colors: [Color(0xFF101122), Color(0xFF0A0B14)],
        ),
      ),
    );
  }

  Widget _buildDecorations() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -100,
          child: _buildBlurCircle(
            const Color(0xFF5A5CF2).withOpacity(0.2),
            300,
          ),
        ),
        Positioned(
          bottom: -100,
          right: -100,
          child: _buildBlurCircle(
            const Color(0xFF9333EA).withOpacity(0.2),
            300,
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

  Widget _buildAuthCard(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildFaceIDButton(context),
              const SizedBox(height: 16),
              _buildLoginSettings(),
              const SizedBox(height: 24),
              _buildDivider(),
              const SizedBox(height: 24),
              _buildSocialGrid(),
              const SizedBox(height: 16),
              _buildEmailButton(),
              const SizedBox(height: 24),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF5A5CF2).withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF5A5CF2).withOpacity(0.3)),
          ),
          child: const Icon(
            Icons.history_edu,
            color: Color(0xFF5A5CF2),
            size: 32,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Aevum",
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Preserving Generations",
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginSettings() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: _autoLogin,
          onChanged: (val) {
            setState(() {
              _autoLogin = val ?? false;
            });
          },
          activeColor: const Color(0xFF5A5CF2),
          side: const BorderSide(color: Colors.white54),
        ),
        Text(
          "Auto-login & Skip Splash",
          style: GoogleFonts.inter(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildFaceIDButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, '/dashboard'),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF5A5CF2).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF5A5CF2).withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.face, color: Color(0xFF5A5CF2), size: 40),
            const SizedBox(height: 8),
            Text(
              "Unlock with FaceID",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.white12)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "OR CONTINUE WITH",
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white30,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Colors.white12)),
      ],
    );
  }

  Widget _buildSocialGrid() {
    return Row(
      children: [
        Expanded(child: _buildSocialButton(Icons.apple, "Apple")),
        const SizedBox(width: 12),
        Expanded(child: _buildSocialButton(Icons.g_mobiledata, "Google")),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String label) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailButton() {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.mail_outline, color: Colors.white54, size: 20),
          const SizedBox(width: 10),
          Text(
            "Continue with Email",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            "Trouble signing in?",
            style: GoogleFonts.inter(
              color: const Color(0xFF5A5CF2),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, color: Colors.white24, size: 14),
            const SizedBox(width: 6),
            Text(
              "SECURED BY FIREBASE",
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: Colors.white24,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
