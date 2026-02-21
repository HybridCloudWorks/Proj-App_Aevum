import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroPageScreen extends StatelessWidget {
  const IntroPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Auto-redirect to Auth for now
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        context.go('/auth');
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF1173D4).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.hourglass_empty,
                color: Color(0xFF1173D4),
                size: 60,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "AEVUM",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Preserving Heritage. Connecting Generations.",
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
