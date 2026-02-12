import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class MemberMemoriesScreen extends StatelessWidget {
  const MemberMemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922), // bg-background-dark
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      _buildProfileSection(),
                      const SizedBox(height: 24),
                      _buildActionButtons(),
                      const SizedBox(height: 8),
                      _buildFilters(),
                      const SizedBox(height: 12),
                      _buildMasonryGrid(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Floating Action Button
          Positioned(
            bottom: 96, // bottom-24 (96px approx considering bottom nav)
            right: 16,
            child: _buildFloatingActionButton(),
          ),
          // Bottom Navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNav(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 8,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF101922).withOpacity(0.95),
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFF1F2937),
            width: 1,
          ), // border-gray-800
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _circleButton(
                Icons.arrow_back_ios_new,
                onTap: () => Navigator.pop(context),
              ),
              Expanded(
                child: Text(
                  "Joseph Miller",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.015,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _circleButton(Icons.more_vert),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 128, // w-32
              height: 128, // h-32
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF283039), // surface-dark
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
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
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF1173d4), // primary
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF101922), // bg-background-dark
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "Joseph Miller",
          style: GoogleFonts.manrope(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "1945 – 2022",
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9dabb9), // text-secondary
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Color(0xFF9dabb9),
                shape: BoxShape.circle,
              ),
            ),
            Text(
              "Grandfather",
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9dabb9),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          "Maternal Side • New York, USA",
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF9dabb9).withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Row(
            children: [
              Expanded(
                child: _actionButton(
                  icon: Icons.add_a_photo,
                  label: "Add Memory",
                  bgColor: const Color(0xFF1173d4), // primary
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  shadowColor: const Color(
                    0xFF1E3A8A,
                  ).withOpacity(0.2), // blue-900/20
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _actionButton(
                  icon: Icons.auto_fix_high,
                  label: "AI Restore",
                  bgColor: const Color(0xFF283039), // surface-dark
                  iconColor: Colors.purpleAccent,
                  textColor: Colors.white,
                  borderColor: Colors.transparent, // dark:border-transparent
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color iconColor,
    required Color textColor,
    Color? shadowColor,
    Color? borderColor,
  }) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12), // rounded-xl
        border: borderColor != null ? Border.all(color: borderColor) : null,
        boxShadow: shadowColor != null
            ? [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          _filterChip("All Photos", active: true),
          const SizedBox(width: 8),
          _filterChip("Portraits", icon: Icons.face),
          const SizedBox(width: 8),
          _filterChip("Group Shots", icon: Icons.groups),
          const SizedBox(width: 8),
          _filterChip(
            "Restored",
            icon: Icons.auto_awesome,
            iconColor: Colors.purple[200],
          ),
        ],
      ),
    );
  }

  Widget _filterChip(
    String label, {
    bool active = false,
    IconData? icon,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ), // py-2 -> ~8px
      decoration: BoxDecoration(
        color: active ? Colors.white : const Color(0xFF283039), // surface-dark
        borderRadius: BorderRadius.circular(999), // rounded-full
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: iconColor ?? (active ? Colors.black : Colors.grey[300]),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12, // text-xs in tailwind is usually 0.75rem ~ 12px
              fontWeight: FontWeight.bold,
              color: active
                  ? const Color(0xFF0F172A)
                  : Colors.grey[300], // slate-900 / gray-300
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMasonryGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                _masonryItem(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuB0w_7LgeGvO_40XKSE8_u9BlvBlyoFqmsb1rRwBgV3p4LIpenJmAItYk0k2ZIRvGLwhtqqGIt9Jlv7eLRCHRag_AyVxwGyInXcEdoNon2qyjhBmDwhrh5MmEBUUPeiAIJhY7byAEJWebCT44LqMdSrnmEFL8NvjlI4KwQla_aefPelwUwi4_hmF41W3_pkfzLbf8CDDmy2qvacKOnMMpvnvvqOb31CmqCzgLHtbuVMQ6Qj0p9Fhij8p0-UhJn1g9ODbjQORkH_uDU",
                  label: "1968",
                ),
                const SizedBox(height: 12),
                _masonryItem(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuBWscasPduzMbADc5Zs38ALSTI6Oan1y4-FKMdAeNvtTEJ-1K3cVodl_pFhXF8a6i-REOo23jaB_5wVBNieVLvGPFIZyTdHu6EgOvzFczDTHD9Elanoz8xmSTLSZ11FgLqtYPa8zKkTnyiy9gyII1kokAkiw1iVPgzoqMDRCqhDKEhOAauTpfk0kpDD4QS98DsNQfQkmQCQQiV_xERwi6rv4p8uA6joXRG5nEF9E2BzfUdnk-rpa-yKOvfw2A7cjvlC-1zZrKGSYjg",
                  label: "School Days",
                ),
                const SizedBox(height: 12),
                _masonryItem(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuC5n5doYCkY-YpRrJdRCEC4_j3RHMdF7UNO_U-zdqhtQqCfRQkDGub_myiBzSbIVEdZVY8N8WT3FYlKEdWwlYyZgXI00wnZTvtH658N2Zy8S26IqRb3wjBBdjzhRLv1_qJyJ7mG21vqFdE3O-dBMC61_M5TjLzrTwIx5TmHL_DIssIkwmrTb-Zm_YaQ6VPQ1Uwht8jeyqrqqYE3aiTO2qttDWTmw1rO7eEXBN-sffm2UeQuwVcLaLtfuV7viy1lscKMSKbyCvfFpt4",
                  label: "Wedding Day",
                ),
                const SizedBox(height: 12),
                _masonryItem(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuCNgJYKQvFHe-9LeuQ5ivvK4C_HDOwhkhs6cph24zCDb8DlpCkipfSBnduvQywqwrn3HrU3uH7PXY-5hEek_X_1OkaTszZS5w83tu8eFrwGhmpxqu2IV_54mO5OnPB4FGS69q_cEcnonsUHTIfKZjKkrDoSWAcYYg_0yt9oB2c-Dd2I713DC2YtF59CeoqSkhCGVtWNbwtlFar7__FY0IV5_WTdf0JXf5VOJfOeRicM8YVmiMwO1hAJhfiAlImmphkOLs_yH4bKgVg",
                  aiBadge: true,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                _masonryItem(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuD6rLWYNqR4sQgKqUxA8itpYbWXVX2-AazxpOq2ruKAUHeE88QzbLzddOdrSSPueXXolY0mRc53w7JH1MHgnxowqUH38duGKayQBL3QGkFmy67PfrafwkAncBVgXFshhCrlV5O9l5XYFtSWDjvsZgOmDibOqOf9VfohVZPB8t3L1XsH0o7Gc8wHDiTMDJLR3Mkv8u1JKpekBv7hqaZN-XbkutgK1HMXkryD667osEYGmVBJUXNSmRkMazqU6vZYrXp21beGfnhnR_Q",
                  label: "Restored • 1970",
                  aiBadge: true,
                ),
                const SizedBox(height: 12),
                _masonryItem(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuAzJrvtRiuf5UIaUM0d3Hj1OvYpO6NQMQ_Z37YGiWkhlSztdCH5ummpBS11d20I2OXAfh35U2Ob_nBs0kMXIslYN6_z8U2Rzd_Xc5eU78eJHzlNmk5e5rOeuTCniNQfa2h4oU8KH9n6SQqgyEZ3eLgRlKjmkJOcye-b_vbOXVw5SRzYFehdK8ofq3Oo2ZwX1C1QYZM4j0K-ei4qDPJPn_qNg5byhDKWX-qN9YSjuwDlYsgnEsdtkD8K656wRa9iwOM4xLeuohRKoOg",
                ),
                const SizedBox(height: 12),
                _masonryItem(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuCPJgW-RdUtLRai54yiWXJ9VSPXlRJ5KA2K-ebBJiUJR5FQqOtcb4uM7GET9ojASBVMnuFxgEyuucpHSOF48m7xCIWLqUuOy3wCLN4JvC9VXhnMyArbhN7pbJUIYuppMznaoj_j-wKDpYyHRaxcA0mBXbMnzM5n8gXknTQSQMNOuA1nw9cVAoUH4Y7NLNyrLAUkc2x4s26coX7n2MioS6m0XowtX0Zrswgf41AMB9_i1_at2utrDDOSlnuf169xV94R6p44s3QXLgo",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _masonryItem(String url, {String? label, bool aiBadge = false}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.network(
              url,
              fit: BoxFit.cover,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.error)),
            ),
            if (label != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Text(
                    label,
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            if (aiBadge)
              Positioned(
                top: 8,
                right: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.purple[600]!.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF1173d4), // primary
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A8A).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      color: const Color(0xFF101922),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 8,
        top: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.photo_library, "Album", active: true),
          _navItem(Icons.account_tree, "Tree"),
          _navItem(Icons.search, "Search"),
          _navItem(Icons.person, "Profile"),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, {bool active = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: active ? const Color(0xFF1173d4) : Colors.grey[400],
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: active ? const Color(0xFF1173d4) : Colors.grey[400],
          ),
        ),
      ],
    );
  }
}
