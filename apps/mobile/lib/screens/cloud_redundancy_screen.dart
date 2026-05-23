import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aevum_native/widgets/smart_navigation_wrapper.dart';
import 'package:aevum_native/widgets/heritage_top_nav.dart';
import 'package:aevum_native/widgets/heritage_bottom_nav.dart';

class CloudRedundancyScreen extends StatelessWidget {
  const CloudRedundancyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: SmartNavigationWrapper(
        topNav: const HeritageTopNav(
          title: "Cloud Redundancy",
          subtitle: "Security Level: Maximum",
        ),
        bottomNav: const HeritageBottomNav(activeIndex: 2),
        child: Stack(
          children: [
            _buildAmbientGlows(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildSyncBanner(),
                    const SizedBox(height: 20),
                    _buildStorageGrid(),
                    const SizedBox(height: 20),
                    _buildZeroKnowledgeCard(),
                    const SizedBox(height: 20),
                    _buildRecoveryKeyCard(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            _buildStickyAction(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAmbientGlows() {
    return Stack(
      children: [
        Positioned(
          top: -120,
          left: -50,
          child: Container(
            width: 350,
            height: 350,
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
          top: 300,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF00E0FF).withValues(alpha: 0.15),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSyncBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF22C55E),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "GLOBAL SYNC ACTIVE",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              Text(
                "Synced 2s ago",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white38,
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Locally Encrypted",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(Icons.sync_alt, color: Color(0xFF00E0FF), size: 16),
                Text(
                  "Cloud Mirroring",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageGrid() {
    return Row(
      children: [
        Expanded(
          child: _storageCard(
            title: "Google Cloud",
            subtitle: "Primary Storage",
            meta: "us-east1 • 42.8 GB Used",
            iconWidget: Image.network(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuC4t7nj6pUKmKcMNeCgFkR9nLPbYD3cvKVliAyMBnKMDpdq_546o_fDUkOFRZR2vvVIBUJJoympjsBxSwM2ZGdEOWcCbKJPcZn__oFWx8lWsqOV8iY-kF16ijhlR0K00h0AzkHqDsvRPvjfdSQ8itllA2YApf2fTRpGXP85-ObBJMuPHMPPX0klSzC7ewEHQTmvYcbr0AW6KlAHOyD9NaUpvP-1N4Mg7OgygCQcNDmUohehJxVzbtPpFLoBeZpvlZShcZsMCM-H3Xs",
              width: 20,
              height: 20,
            ),
            iconBg: Colors.white,
            progress: 0.45,
            progressColor: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _storageCard(
            title: "AWS S3 Glacier",
            subtitle: "Redundant Mirror",
            meta: "eu-west • Immutable",
            iconWidget: Text(
              "AWS",
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconBg: const Color(0xFF232F3E),
            isVerified: true,
            isAccent: true,
          ),
        ),
      ],
    );
  }

  Widget _storageCard({
    required String title,
    required String subtitle,
    required String meta,
    required Widget iconWidget,
    required Color iconBg,
    double? progress,
    Color? progressColor,
    bool isVerified = false,
    bool isAccent = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isAccent
              ? const Color(0xFF00E0FF).withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: iconWidget),
          ),
          const SizedBox(height: 20),
          Text(
            subtitle.toUpperCase(),
            style: GoogleFonts.plusJakartaSans(
              color: isAccent ? const Color(0xFF00E0FF) : Colors.white38,
              fontSize: 8,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            meta,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white38,
              fontSize: 10,
            ),
          ),
          const Spacer(),
          if (progress != null)
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
                    color: progressColor ?? Colors.blue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          if (isVerified)
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF22C55E),
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  "Verified 100%",
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF22C55E),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildZeroKnowledgeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1173D4).withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF1173D4).withValues(alpha: 0.2),
              ),
            ),
            child: const Icon(Icons.lock, color: Color(0xFF1173D4), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Zero-Knowledge",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Only you hold the keys. Aevum cannot access your data.",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: true,
            onChanged: (v) {},
            activeThumbColor: const Color(0xFF1173D4),
          ),
        ],
      ),
    );
  }

  Widget _buildRecoveryKeyCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Master Recovery Key",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Required to restore backups.",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.refresh,
                  size: 14,
                  color: Color(0xFF00E0FF),
                ),
                label: Text(
                  "Regenerate",
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF00E0FF),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "",
                  style: GoogleFonts.jetBrainsMono(
                    color: Colors.white70,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
                const Icon(Icons.content_copy, color: Colors.white30, size: 20),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _entropySegment(true)),
              const SizedBox(width: 8),
              Expanded(child: _entropySegment(true)),
              const SizedBox(width: 8),
              Expanded(child: _entropySegment(true)),
              const SizedBox(width: 8),
              Expanded(child: _entropySegment(false)),
              const SizedBox(width: 12),
              Text(
                "Strong Entropy",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white38,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _entropySegment(bool isActive) {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF22C55E)
            : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildStickyAction(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 20,
      right: 20,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF1173D4), Color(0xFF1E2F4D)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1173D4).withValues(alpha: 0.2),
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
                  const Icon(Icons.cloud_upload, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    "Force Backup Now",
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
    );
  }
}


