import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class IntroPageScreen extends StatefulWidget {
  final bool skipTimer;
  const IntroPageScreen({super.key, this.skipTimer = false});

  @override
  State<IntroPageScreen> createState() => _IntroPageScreenState();
}

class _IntroPageScreenState extends State<IntroPageScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  Timer? _rotationTimer;
  int _currentMessageIndex = 0;

  final List<String> _messages = [
    "Hello! How are you?", // English
    "你好！你好吗？", // Mandarin Chinese
    "नमस्ते! आप कैसे हैं?", // Hindi
    "¡Hola! ¿Cómo estás?", // Spanish
    "Bonjour! Comment allez-vous?", // French
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Rotate messages every 3 seconds only if not skipping
    if (!widget.skipTimer) {
      _rotationTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (mounted) {
          setState(() {
            _currentMessageIndex =
                (_currentMessageIndex + 1) % _messages.length;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _rotationTimer?.cancel();
    super.dispose();
  }

  void _onContinue() {
    Navigator.pushReplacementNamed(context, '/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F151B),
      body: Stack(
        children: [
          // Background Vignettes (Placeholder for now, using gradients/shapes)
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.network(
                'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800&fit=crop', // Vintage family photo specific
                fit: BoxFit.cover,
                errorBuilder: (c, o, s) => Container(color: Colors.black),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.8,
                colors: [
                  Colors.transparent,
                  const Color(0xFF0F151B).withOpacity(0.8),
                  const Color(0xFF0F151B),
                ],
                stops: const [0.2, 0.6, 1.0],
              ),
            ),
          ),

          // Main Content
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5A5CF2).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF5A5CF2).withOpacity(0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF5A5CF2).withOpacity(0.2),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.history_edu,
                      color: Color(0xFF5A5CF2),
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Title
                  Text(
                    "Aevum",
                    style: GoogleFonts.cinzel(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 4.0,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tagline
                  Text(
                    "PRESERVING GENERATIONS",
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white54,
                      letterSpacing: 3.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Area: Message & Continue Button
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Rotating Message
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    _messages[_currentMessageIndex],
                    key: ValueKey<int>(_currentMessageIndex),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.caveat(
                      // Handwritten style
                      fontSize: 24,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Continue Radio-Style Button
                GestureDetector(
                  onTap: _onContinue,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Continue",
                          style: GoogleFonts.manrope(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
