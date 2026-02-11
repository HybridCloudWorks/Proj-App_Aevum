import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/glass_card.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101122), // background-dark
      body: Stack(
        children: [
          // Mesh Gradient Background
          const _MeshBackground(),

          // Abstract Shapes
          Positioned(
            top: -50,
            left: -50,
            width: 300,
            height: 300,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0x335A5CF2), // primary/20
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            width: 300,
            height: 300,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0x339333EA), // purple-600/20
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          // Main Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlassCard(
                    borderRadius: 16, // rounded-2xl
                    backgroundColor: const Color(0x73101122), // rgba(16, 17, 34, 0.45)
                    borderColor: const Color(0x14FFFFFF), // rgba(255, 255, 255, 0.08)
                    blurAmount: 20,
                    padding: const EdgeInsets.all(24), // p-6 md:p-8
                    child: SizedBox(
                      width: 420,
                      child: Column(
                        children: [
                          // Header
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: const Color(0x335A5CF2), // primary/20
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0x4D5A5CF2)), // primary/30
                            ),
                            child: const Center(
                              child: Icon(Icons.history_edu, color: Color(0xFF5A5CF2), size: 32),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Aevum',
                            style: GoogleFonts.inter(
                              fontSize: 30, // text-3xl
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            'Preserving Generations',
                            style: GoogleFonts.inter(
                              fontSize: 14, // text-sm
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF94A3B8), // slate-400
                            ),
                          ),
                          const SizedBox(height: 24),

                          // FaceID Button
                          _buildBentoButton(
                            height: 128, // h-32
                            color: const Color(0x1A5A5CF2), // primary/10
                            hoverColor: const Color(0x335A5CF2),
                            borderColor: const Color(0x335A5CF2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.face, color: Color(0xFF5A5CF2), size: 40),
                                const SizedBox(height: 12),
                                Text(
                                  'Unlock with FaceID',
                                  style: GoogleFonts.inter(
                                    fontSize: 18, // text-lg
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),

                          const SizedBox(height: 16),

                          // Divider
                          Row(
                            children: [
                              Expanded(child: Divider(color: Colors.white.withOpacity(0.1))),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  'OR CONTINUE WITH',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF64748B), // slate-500
                                    letterSpacing: 2.0, // tracking-widest
                                  ),
                                ),
                              ),
                              Expanded(child: Divider(color: Colors.white.withOpacity(0.1))),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Social Buttons Grid
                          Row(
                            children: [
                              Expanded(
                                child: _buildBentoButton(
                                  height: 96, // h-24
                                  color: Colors.white.withOpacity(0.05),
                                  borderColor: Colors.white.withOpacity(0.1),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.string(
                                        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="white"><path d="M17.05 20.28c-.98.95-2.05.88-3.08.4-1.09-.5-2.08-.48-3.24 0-1.44.62-2.2.44-3.06-.4C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.54 5.81.34 7.23-.56 1.43-1.32 2.82-2.39 3.98zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z"/></svg>',
                                        width: 32,
                                        height: 32,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Apple',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFE2E8F0), // slate-200
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildBentoButton(
                                  height: 96,
                                  color: Colors.white.withOpacity(0.05),
                                  borderColor: Colors.white.withOpacity(0.1),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.string(
                                        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/><path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/><path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.84z" fill="#FBBC05"/><path d="M12 4.63c1.61 0 3.06.56 4.23 1.68l3.18-3.18C17.46 1.34 14.97 0 12 0 7.7 0 3.99 2.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/></svg>',
                                        width: 28,
                                        height: 28,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Google',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFE2E8F0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),

                          // Email Fallback
                          _buildBentoButton(
                            height: 56, // h-14
                            color: Colors.transparent,
                            borderColor: Colors.white.withOpacity(0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.mail, color: const Color(0xFF94A3B8), size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'Continue with Email',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),

                          const SizedBox(height: 16),

                          // Footer
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Trouble signing in?',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xCC5A5CF2), // primary/80
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.lock, size: 16, color: Color(0xFF64748B)),
                              const SizedBox(width: 6),
                              Text(
                                'SECURED BY FIREBASE',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF64748B),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBentoButton({
    required double height,
    required Color color,
    Color? hoverColor,
    required Color borderColor,
    required Widget child,
    required VoidCallback onTap,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12), // rounded-xl
        border: Border.all(color: borderColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          splashColor: hoverColor ?? Colors.white.withOpacity(0.1),
          highlightColor: hoverColor ?? Colors.white.withOpacity(0.05),
          child: child,
        ),
      ),
    );
  }
}

class _MeshBackground extends StatelessWidget {
  const _MeshBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Approximate the radial gradients
    return Stack(
      children: [
        Container(color: const Color(0xFF101122)),
        // Top Left
        Positioned(
          top: -100,
          left: -100,
          width: 400,
          height: 400,
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0x406366F1), Colors.transparent], // hsla(239, 84%, 65%, 0.25)
                center: Alignment.center,
                radius: 0.5,
              ),
            ),
          ),
        ),
        // Top Right
        Positioned(
          top: -100,
          right: -100,
          width: 400,
          height: 400,
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0x4D7C3AED), Colors.transparent], // hsla(260, 90%, 65%, 0.3)
                center: Alignment.center,
                radius: 0.5,
              ),
            ),
          ),
        ),
        // Bottom Right
        Positioned(
          bottom: -100,
          right: -100,
          width: 400,
          height: 400,
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0x4D1E1B4B), Colors.transparent], // hsla(240, 80%, 40%, 0.3)
                center: Alignment.center,
                radius: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
