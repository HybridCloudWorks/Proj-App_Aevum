import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminAlphaLaunchScreen extends StatelessWidget {
  const AdminAlphaLaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B14),
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.2,
                  colors: [
                    const Color(0xFF1173d4).withValues(alpha: 0.15),
                    const Color(0xFF070B14),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 60),
                _buildInitializationTitle(),
                const SizedBox(height: 60),
                _buildSystemStatus(),
                const SizedBox(height: 60),
                _buildChecklistGrid(),
                const Spacer(),
                _buildLaunchButton(),
                const SizedBox(height: 40),
                _buildBottomNav(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "V1.0.0 ALPHA",
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1173d4),
              letterSpacing: 1,
            ),
          ),
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Node: US-EAST-1",
                style: GoogleFonts.manrope(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white38,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInitializationTitle() {
    return Column(
      children: [
        Text(
          "Initialization",
          style: GoogleFonts.manrope(
            fontSize: 42,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Aevum Alpha Launch Protocol",
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white38,
          ),
        ),
      ],
    );
  }

  Widget _buildSystemStatus() {
    return Center(
      child: Container(
        width: 240,
        height: 240,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF1173d4).withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1173d4).withValues(alpha: 0.2),
              blurRadius: 100,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF070B14),
            border: Border.all(
              color: const Color(0xFF1173d4).withValues(alpha: 0.4),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.sensors, color: Color(0xFF1173d4), size: 40),
              const SizedBox(height: 16),
              Text(
                "SYSTEM ONLINE",
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF1173d4),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChecklistGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.4,
        children: [
          _checklistCard(Icons.storage, "DATABASE", "Migration Complete", true),
          _checklistCard(Icons.memory, "AI ENGINE", "Vector Index Live", true),
          _checklistCard(
            Icons.cloud_done,
            "BYOB STORAGE",
            "Handshake Verified",
            true,
          ),
          _checklistCard(
            Icons.phone_android,
            "TESTFLIGHT",
            "Build 1.0.0 Ready",
            true,
          ),
        ],
      ),
    );
  }

  Widget _checklistCard(IconData icon, String title, String val, bool isDone) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: const Color(0xFF1173d4), size: 20),
              Icon(
                Icons.check_circle,
                color: const Color(0xFF10B981).withValues(alpha: 0.6),
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: Colors.white38,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            val,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLaunchButton() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1173d4),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 40,
              shadowColor: const Color(0xFF1173d4).withValues(alpha: 0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LAUNCH ALPHA",
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.rocket_launch, size: 24),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "FINAL DEPLOYMENT VERIFICATION REQUIRED",
          style: GoogleFonts.manrope(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: Colors.white24,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.grid_view_rounded, color: Color(0xFF1173d4), size: 28),
          Icon(Icons.terminal_rounded, color: Colors.white12, size: 28),
          Icon(Icons.settings_rounded, color: Colors.white12, size: 28),
          Icon(Icons.person_rounded, color: Colors.white12, size: 28),
        ],
      ),
    );
  }
}


