import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aevum_native/widgets/smart_navigation_wrapper.dart';
import 'package:aevum_native/widgets/heritage_top_nav.dart';

class PlantBranchScreen extends StatelessWidget {
  const PlantBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: SmartNavigationWrapper(
        topNav: const HeritageTopNav(
          title: "Start Your Journey",
          subtitle: "Planting your legacy",
        ),
        child: Stack(
          children: [
            _buildAmbientGlows(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60), // Space for top nav
                    _buildHeroCard(),
                    const SizedBox(height: 24),
                    _buildActionGrid(context),
                    const SizedBox(height: 32),
                    _buildAIAssistantCard(),
                    const SizedBox(height: 32),
                    _buildExampleBranches(),
                    const SizedBox(height: 100), // Padding for bottom nav space
                  ],
                ),
              ),
            ),
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
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF1173D4).withValues(alpha: 0.4),
                    const Color(0xFF1173D4).withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: -50,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF1173D4).withValues(alpha: 0.2),
                  const Color(0xFF1173D4).withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        color: Colors.white.withValues(alpha: 0.03),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuCPahOG810tTA0CDJ7hQ78KbqeMIHCm353JThEuV8KMDo6TMp0GE5bt2WCvf0aOGkzAAuXqC_GK5Hf_1M_e_XTmBVoYw7wFLaIde2L2Dn2NZF3N4Y3Fve7iqCFFFwyw3IydRYQvrSYh8RJL03rL6xX5A4y6Pj8KxVvzqybyLwFAUBwkuKWtKsiSiodFj77JYYwJOA2zzf69Dc-kk28VcIE7TULK8C8xSQkOLqoO9cPQ2idl1OwX55upHy-wWdt1pm0sDlb7h-CSPYs",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFF101922).withValues(alpha: 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1173D4).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF1173D4).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    "NEW BRANCH",
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF1173D4),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Planting Your Roots",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Every great family story starts with a single memory. Begin building your legacy today.",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            icon: Icons.add_a_photo,
            title: "Upload Photo",
            subtitle: "Add a memory to start the tree",
            iconBg: const Color(0xFF1173D4).withValues(alpha: 0.2),
            iconColor: const Color(0xFF1173D4),
            buttonLabel: "Add Photo",
            buttonColor: const Color(0xFF1173D4),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionCard(
            icon: Icons.group_add,
            title: "Invite Family",
            subtitle: "Build your history together",
            iconBg: Colors.purple.withValues(alpha: 0.2),
            iconColor: Colors.purpleAccent,
            buttonLabel: "Invite",
            buttonColor: const Color(0xFF334155),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconBg,
    required Color iconColor,
    required String buttonLabel,
    required Color buttonColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const Icon(Icons.north_east, color: Colors.white24, size: 16),
            ],
          ),
          const SizedBox(height: 16),
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
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white54,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                buttonLabel,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIAssistantCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white.withValues(alpha: 0.05), Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF1173D4), Color(0xFF22D3EE)],
              ),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Aevum AI Assistant",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Not sure where to start? I can help you find records.",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Ask AI",
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF101922),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleBranches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "EXAMPLE BRANCHES",
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white24,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildBranchCard(
                "Grandma Sarah",
                "https://lh3.googleusercontent.com/aida-public/AB6AXuB5VBZhM5VzXhfu9SvegoT9Pv4b9Fa6pvmZbzfCN90nf3Z-qIcBALR5R2sTODFd3s4N5wkPzKF0dQH8OKfxmkjbyzQ0PUsw3Uk5XPy2tWBN1c2Jj0MexMFQnuquwYFIoj-6cY3407_XOdLvufiH7UzhsAyh66OZCvI_HRuUfR0RmeVYs8N1h7VIw_006yzmqL3kayWER4--oKCJJmhLGsF0f3JM7v6TtC7bF09hXSvzjO19yX8u2p-wcj0bsG7qw35DQpg3hinhxaE",
              ),
              const SizedBox(width: 12),
              _buildBranchCard(
                "Grandpa John",
                "https://lh3.googleusercontent.com/aida-public/AB6AXuCcxrzPy7OIC6fd_Q2YDezWIUxp5TQ5fc26rSRExBWQAogSbHqAcIW5X7KuWlU7plAP0P5KH9OR86Z0I-qFYPQIkHsqp_-Xd-bKT6GS_SbQwkMF_v21eWMHQNg-ncKsK7-OX67k9A1pjiZdgepQFPOA7uaYgzbKptnvYNvioTH6t1YsrVLoDcrW92mP2MS1oDyzCDt64EufsU6g4OIatEOy63KXakhwlJMKB2X9LUQnMS2V07kb0vgKx7tJ26GmURB4xILcTyY3So8",
              ),
              const SizedBox(width: 12),
              _buildAddRelativeCard(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBranchCard(String name, String imageUrl) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(height: 12),
          Text(
            name,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddRelativeCard() {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white38),
          ),
          const SizedBox(height: 12),
          Text(
            "Add Relative",
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white38,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class DashStyle {
  final double length;
  final double gap;
  const DashStyle(this.length, this.gap);
}
