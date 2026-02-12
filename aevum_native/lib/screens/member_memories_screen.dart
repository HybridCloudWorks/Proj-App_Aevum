import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aevum_native/widgets/heritage_bottom_nav.dart';
import 'package:aevum_native/widgets/smart_navigation_wrapper.dart';

class MemberMemoriesScreen extends StatelessWidget {
  const MemberMemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1121),
      body: SmartNavigationWrapper(
        bottomNav: const HeritageBottomNav(
          activeIndex: 3,
        ), // Profile-related or newly added Vault icon
        child: Stack(
          children: [
            // Hero Backdrop
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 320,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuAzJrvtRiuf5UIaUM0d3Hj1OvYpO6NQMQ_Z37YGiWkhlSztdCH5ummpBS11d20I2OXAfh35U2Ob_nBs0kMXIslYN6_z8U2Rzd_Xc5eU78eJHzlNmk5e5rOeuTCniNQfa2h4oU8KH9n6SQqgyEZ3eLgRlKjmkJOcye-b_vbOXVw5SRzYFehdK8ofq3Oo2ZwX1C1QYZM4j0K-ei4qDPJPn_qNg5byhDKWX-qN9YSjuwDlYsgnEsdtkD8K656wRa9iwOM4xLeuohRKoOg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.3),
                            Colors.transparent,
                            const Color(0xFF0B1121),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                ],
              ),
            ),
            // Floating Action Menu
            _buildFloatingActionMenu(),
            // Main Content
            SafeArea(
              child: Column(
                children: [
                  _buildHeader(context),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 100, bottom: 120),
                      child: Column(
                        children: [
                          _buildProfileInfo(),
                          const SizedBox(height: 24),
                          _buildActionButtons(context),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Featured Moments",
                                  style: GoogleFonts.manrope(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "View All",
                                  style: GoogleFonts.manrope(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B82F6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildBentoGrid(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _circleIconButton(
            Icons.arrow_back_ios_new,
            onTap: () => Navigator.pop(context),
          ),
          _circleIconButton(Icons.more_horiz),
        ],
      ),
    );
  }

  Widget _circleIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white10),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                  ),
                ],
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuCypW0HCtYaKHH0MjMWX5XSsEKnu7uoyRGpXiybm9VCSMSScwMkgC9ez5DGxTI5aZ9R8qtdmEhpP57FWjs1FEoF71D4bCGguhT8QavCYCK0Hq6QmPi5gBbq-toXZJYB2YAyY3ACa7I9D_xT4aNPKnATilfv4r2mIsfkVXaKiuzT4E6wh8xuMRQ2gs1XjSq71o-iw17bRamMPrWJPA1F8-lYYaF3HAZYx3KtIUk3CtH-NetUq8Av_FjlDt-4jo7Pxw5GiiDB9tT_y0w",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: -8,
              right: -8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0B1121), width: 2),
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "Joseph Miller",
          style: GoogleFonts.manrope(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Text(
                "1945 – 2022",
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Grandfather",
              style: GoogleFonts.manrope(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _actionCard(
              Icons.add_a_photo,
              "Add Memory",
              "Upload new photos",
              const Color(0xFF3B82F6),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _actionCard(
              Icons.auto_fix_high,
              "AI Restore",
              "Colorize & sharpen",
              const Color(0xFF8B5CF6),
              onTap: () => Navigator.pushNamed(context, '/restoration'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionCard(
    IconData icon,
    String title,
    String sub,
    Color color, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              sub,
              style: const TextStyle(color: Colors.white54, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBentoGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Large item
          _bentoItem(
            imageUrl:
                "https://lh3.googleusercontent.com/aida-public/AB6AXuB0w_7LgeGvO_40XKSE8_u9BlvBlyoFqmsb1rRwBgV3p4LIpenJmAItYk0k2ZIRvGLwhtqqGIt9Jlv7eLRCHRag_AyVxwGyInXcEdoNon2qyjhBmDwhrh5MmEBUUPeiAIJhY7byAEJWebCT44LqMdSrnmEFL8NvjlI4KwQla_aefPelwUwi4_hmF41W3_pkfzLbf8CDDmy2qvacKOnMMpvnvvqOb31CmqCzgLHtbuVMQ6Qj0p9Fhij8p0-UhJn1g9ODbjQORkH_uDU",
            title: "First Car Purchase",
            subtitle: "Chevrolet Impala",
            year: "1968",
            isLarge: true,
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _bentoItem(
                      imageUrl:
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuD6rLWYNqR4sQgKqUxA8itpYbWXVX2-AazxpOq2ruKAUHeE88QzbLzddOdrSSPueXXolY0mRc53w7JH1MHgnxowqUH38duGKayQBL3QGkFmy67PfrafwkAncBVgXFshhCrlV5O9l5XYFtSWDjvsZgOmDibOqOf9VfohVZPB8t3L1XsH0o7Gc8wHDiTMDJLR3Mkv8u1JKpekBv7hqaZN-XbkutgK1HMXkryD667osEYGmVBJUXNSmRkMazqU6vZYrXp21beGfnhnR_Q",
                      title: "Portrait",
                      subtitle: "Restored • 1970",
                      aiEnabled: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    _bentoItem(
                      imageUrl:
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuBWscasPduzMbADc5Zs38ALSTI6Oan1y4-FKMdAeNvtTEJ-1K3cVodl_pFhXF8a6i-REOo23jaB_5wVBNieVLvGPFIZyTdHu6EgOvzFczDTHD9Elanoz8xmSTLSZ11FgLqtYPa8zKkTnyiy9gyII1kokAkiw1iVPgzoqMDRCqhDKEhOAauTpfk0kpDD4QS98DsNQfQkmQCQQiV_xERwi6rv4p8uA6joXRG5nEF9E2BzfUdnk-rpa-yKOvfw2A7cjvlC-1zZrKGSYjg",
                      tag: "School",
                    ),
                    const SizedBox(height: 16),
                    _bentoItem(
                      imageUrl:
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuC5n5doYCkY-YpRrJdRCEC4_j3RHMdF7UNO_U-zdqhtQqCfRQkDGub_myiBzSbIVEdZVY8N8WT3FYlKEdWwlYyZgXI00wnZTvtH658N2Zy8S26IqRb3wjBBdjzhRLv1_qJyJ7mG21vqFdE3O-dBMC61_M5TjLzrTwIx5TmHL_DIssIkwmrTb-Zm_YaQ6VPQ1Uwht8jeyqrqqYE3aiTO2qttDWTmw1rO7eEXBN-sffm2UeQuwVcLaLtfuV7viy1lscKMSKbyCvfFpt4",
                      title: "Wedding Day",
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _bentoItem(
            imageUrl:
                "https://lh3.googleusercontent.com/aida-public/AB6AXuCNgJYKQvFHe-9LeuQ5ivvK4C_HDOwhkhs6cph24zCDb8DlpCkipfSBnduvQywqwrn3HrU3uH7PXY-5hEek_X_1OkaTszZS5w83tu8eFrwGhmpxqu2IV_54mO5OnPB4FGS69q_cEcnonsUHTIfKZjKkrDoSWAcYYg_0yt9oB2c-Dd2I713DC2YtF59CeoqSkhCGVtWNbwtlFar7__FY0IV5_WTdf0JXf5VOJfOeRicM8YVmiMwO1hAJhfiAlImmphkOLs_yH4bKgVg",
            location: "Central Park, 1985",
            isLarge: true,
          ),
        ],
      ),
    );
  }

  Widget _bentoItem({
    required String imageUrl,
    String? title,
    String? subtitle,
    String? year,
    String? tag,
    String? location,
    bool isLarge = false,
    bool aiEnabled = false,
  }) {
    return Container(
      width: double.infinity,
      height: isLarge ? 200 : 180,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
              ),
            ),
          ),
          if (year != null)
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white12),
                ),
                child: Text(
                  year,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (tag != null)
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (aiEnabled)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (location != null)
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                if (title != null)
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white70, fontSize: 10),
                  ),
              ],
            ),
          ),
          if (isLarge)
            Positioned(
              bottom: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionMenu() {
    return Positioned(
      bottom: 104,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _floatingButton(
            icon: Icons.person_add,
            label: "Magic Tagging",
            color: const Color(0xFF6366F1),
          ),
          const SizedBox(height: 12),
          _floatingButton(
            icon: Icons.auto_fix_high,
            label: "AI Enhance",
            color: const Color(0xFF8B5CF6),
            isGradient: true,
          ),
          const SizedBox(height: 12),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.add, color: Color(0xFF0B1121), size: 28),
          ),
        ],
      ),
    );
  }

  Widget _floatingButton({
    required IconData icon,
    required String label,
    required Color color,
    bool isGradient = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Icon(icon, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
