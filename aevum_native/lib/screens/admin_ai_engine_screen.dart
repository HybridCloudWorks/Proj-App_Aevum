import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminAIEngineScreen extends StatelessWidget {
  const AdminAIEngineScreen({super.key});
  static const Color _accent = Color(0xFF1173d4);
  static const Color _warning = Color(0xFFFBBF24);
  static const Color _infoAccent = Color(0xFF7C3AED);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1121),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 16,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          "AEVUM AI ENGINE",
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            color: Colors.white70,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white54),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildEnhancementHeader(),
            const SizedBox(height: 32),
            _buildCurrentlyEnhancingSection(),
            const SizedBox(height: 32),
            _buildNextInQueueSection(),
            const SizedBox(height: 32),
            _buildWaitingInfoCard(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildEnhancementHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, color: _accent, size: 40),
          ),
          const SizedBox(height: 24),
          Text(
            "Enhancement in\nProgress",
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Our AI is currently restoring high-fidelity details from your archive. To ensure quality, we're processing your queue in batches.",
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.white54,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.4,
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              valueColor: const AlwaysStoppedAnimation<Color>(_accent),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Processing Batch 2/5",
                style: GoogleFonts.manrope(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white38,
                ),
              ),
              Text(
                "~12 mins remaining",
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

  Widget _buildCurrentlyEnhancingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "CURRENTLY ENHANCING",
              style: GoogleFonts.manrope(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.white38,
                letterSpacing: 1,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Active",
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: _accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _warning.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: _warning.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=200",
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
                      "Wedding of Eleanor & Arthur",
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "1942 • Colorization & Upscaling",
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        color: Colors.white38,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white38),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Processing texture details...",
                          style: GoogleFonts.manrope(
                            fontSize: 10,
                            color: Colors.white38,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNextInQueueSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "NEXT IN QUEUE",
              style: GoogleFonts.manrope(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.white38,
                letterSpacing: 1,
              ),
            ),
            Text(
              "View All",
              style: GoogleFonts.manrope(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: _accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _queueItem(
          "Arthur's Portrait",
          "Waiting for available slot",
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
        ),
        const SizedBox(height: 12),
        _queueItem(
          "Summer of '69",
          "Waiting for available slot",
          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100",
        ),
        const SizedBox(height: 12),
        _queueItem(
          "Graduation Day",
          "Waiting for available slot",
          "https://images.unsplash.com/photo-1463453091185-61582044d556?w=100",
        ),
      ],
    );
  }

  Widget _queueItem(String title, String subtitle, String url) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(url, width: 44, height: 44, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    color: Colors.white24,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  "Prioritize",
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_upward, color: Colors.white70, size: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaitingInfoCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _infoAccent.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: _infoAccent, size: 20),
              const SizedBox(width: 12),
              Text(
                "Why is there a wait?",
                style: GoogleFonts.manrope(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "High-fidelity restoration requires significant processing power. We limit concurrent tasks to ensure the highest quality output for every memory.",
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: Colors.white38,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 80,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _accent,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: _accent.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.home_filled, color: Colors.white38, size: 28),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.bolt, color: _accent, size: 28),
          ),
          const Icon(Icons.person_outline, color: Colors.white38, size: 28),
        ],
      ),
    );
  }
}
