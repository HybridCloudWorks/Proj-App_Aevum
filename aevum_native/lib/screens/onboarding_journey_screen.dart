import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class OnboardingJourneyScreen extends StatefulWidget {
  const OnboardingJourneyScreen({super.key});

  @override
  State<OnboardingJourneyScreen> createState() =>
      _OnboardingJourneyScreenState();
}

class _OnboardingJourneyScreenState extends State<OnboardingJourneyScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _steps = [
    {
      'title': 'Planting Your Roots',
      'subtitle':
          'Every great family story starts with a single memory. Begin building your legacy today.',
      'image': 'assets/images/roots.png', // Placeholder for seedling image
      'color': const Color(0xFF1173D4),
    },
    {
      'title': 'Semantic Discovery',
      'subtitle':
          'AI Analysis Active. Our neural engine matches records with 94% confidence.',
      'color': const Color(0xFF10B981),
    },
    {
      'title': 'Your Tree, Your Rules',
      'subtitle':
          'Set boundaries to keep your family history secure and accurate.',
      'color': const Color(0xFF6366F1),
    },
    {
      'title': 'Cloud Redundancy',
      'subtitle':
          'Global Sync Active. Your data is mirrored across secure locations.',
      'color': const Color(0xFF00E0FF),
    },
    {
      'title': 'Vault Sync & Health',
      'subtitle': 'Synchronizing encrypted genealogy data. 75% complete.',
      'color': const Color(0xFFA855F7),
    },
  ];

  void _nextPage() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          _buildMeshBackground(),
          _buildDecorations(),
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: _steps.length,
                    itemBuilder: (context, index) {
                      return _buildPageContent(index);
                    },
                  ),
                ),
                _buildFooter(),
              ],
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
            center: Alignment.topRight,
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
          top: 100,
          left: -50,
          child: _buildBlurCircle(
            _steps[_currentPage]['color'].withOpacity(0.2),
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

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white70),
            onPressed: () {
              if (_currentPage > 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          _buildStepIndicator(),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/auth'),
            child: Text(
              "Skip",
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white30,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "STEP ${_currentPage + 1} OF ${_steps.length}",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(width: 12),
          Row(
            children: List.generate(_steps.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: index == _currentPage ? 16 : 4,
                height: 4,
                decoration: BoxDecoration(
                  color: index == _currentPage
                      ? _steps[_currentPage]['color']
                      : Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return _buildIntroStep();
      case 1:
        return _buildAIStep();
      case 2:
        return _buildPrivacyStep();
      case 3:
        return _buildCloudStep();
      case 4:
        return _buildSyncStep();
      default:
        return Container();
    }
  }

  Widget _buildIntroStep() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1523741543316-beb7fc7023d8?w=800&auto=format&fit=crop",
                ), // Placeholder for seedling
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 40),
          _buildHeadline("Planting Your Roots"),
          const SizedBox(height: 16),
          _buildSubHeadline(
            "Every great family story starts with a single memory. Begin building your legacy today.",
          ),
        ],
      ),
    );
  }

  Widget _buildAIStep() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPremiumCard(
            title: "Semantic Discovery",
            status: "AI ANALYSIS ACTIVE",
            color: const Color(0xFF10B981),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAvatar("GF"),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF10B981).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        "94% MATCH",
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF10B981),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildAvatar("NA"),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  "Eleanor Vance",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Predicted Great-Grandmother",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          _buildHeadline("AI Assisted Lineage"),
          const SizedBox(height: 16),
          _buildSubHeadline(
            "Our neural engines reconcile billions of records to find your ancestors instantly.",
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyStep() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPrivacyCard(),
          const SizedBox(height: 40),
          _buildHeadline("Your Tree, Your Rules"),
          const SizedBox(height: 16),
          _buildSubHeadline(
            "Set boundaries to keep your family history secure, private, and accurate.",
          ),
        ],
      ),
    );
  }

  Widget _buildCloudStep() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCloudCard(),
          const SizedBox(height: 40),
          _buildHeadline("Cloud Redundancy"),
          const SizedBox(height: 16),
          _buildSubHeadline(
            "Your data is immutable and mirrored across 3 global regions for infinite preservation.",
          ),
        ],
      ),
    );
  }

  Widget _buildSyncStep() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSyncCard(),
          const SizedBox(height: 40),
          _buildHeadline("Vault Sync & Health"),
          const SizedBox(height: 16),
          _buildSubHeadline(
            "Sit back while we encrypt and sync your heritage to the Aevum Vault.",
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        height: 1.1,
      ),
    );
  }

  Widget _buildSubHeadline(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.plusJakartaSans(
        color: const Color(0xFFCBD5E1),
        fontSize: 16,
        height: 1.5,
      ),
    );
  }

  Widget _buildPremiumCard({
    required String title,
    required String status,
    required Color color,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                status,
                style: GoogleFonts.plusJakartaSans(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          child,
        ],
      ),
    );
  }

  Widget _buildAvatar(String text) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacyCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: [
          const Icon(Icons.people_alt, color: Color(0xFF6366F1), size: 40),
          const SizedBox(height: 16),
          Text(
            "Spousal Approval",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Both parties must tap 'Accept' to connect.",
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSmallIcon(Icons.person, "YOU"),
              Container(width: 60, height: 1, color: Colors.white10),
              const Icon(Icons.lock, color: Color(0xFF6366F1), size: 16),
              Container(width: 60, height: 1, color: Colors.white10),
              _buildSmallIcon(Icons.favorite, "SPOUSE"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white30,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCloudCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCloudItem("Google Cloud", "us-east1", Colors.white),
              const Icon(Icons.swap_horiz, color: Color(0xFF00E0FF)),
              _buildCloudItem("AWS S3", "eu-west1", Colors.white70),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lock_person,
                  color: Color(0xFF00E0FF),
                  size: 24,
                ),
                const SizedBox(width: 12),
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
                        "Only you hold the keys.",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF10B981),
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloudItem(String name, String region, Color color) {
    return Column(
      children: [
        Icon(Icons.cloud, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          name,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          region,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white38,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildSyncCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const CircularProgressIndicator(
                  value: 0.75,
                  strokeWidth: 8,
                  backgroundColor: Colors.white10,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFA855F7)),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "75%",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "SYNCING",
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFFA855F7),
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Cloud Vault Sync",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Synchronizing heritage data...",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GestureDetector(
        onTap: _nextPage,
        child: Container(
          height: 64,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _steps[_currentPage]['color'],
                _steps[_currentPage]['color'].withBlue(255),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _steps[_currentPage]['color'].withOpacity(0.3),
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
                  _currentPage == _steps.length - 1
                      ? "Finish Journey"
                      : "Got it, let's grow",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
