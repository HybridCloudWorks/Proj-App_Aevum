import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class IdentifyGrowTreeScreen extends StatelessWidget {
  const IdentifyGrowTreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1121),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Tag Faces",
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressHeader(),
            const SizedBox(height: 24),
            _buildWhoIsThisHeader(),
            const SizedBox(height: 24),
            _buildProfileSelection(),
            const SizedBox(height: 30),
            _buildMainIdentityCard(),
            const SizedBox(height: 40),
            _buildAppearsInSection(),
            const SizedBox(height: 30),
            _buildSecurityFooter(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildProgressHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Identifying 3 of 15",
                style: GoogleFonts.manrope(fontSize: 12, color: Colors.white70),
              ),
              Text(
                "20%",
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.2,
              backgroundColor: Colors.white.withOpacity(0.05),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF1173d4),
              ),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhoIsThisHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Who is this?",
            style: GoogleFonts.manrope(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.verified, color: Colors.green, size: 16),
              const SizedBox(width: 8),
              Text(
                "High confidence match found.",
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: Colors.white54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSelection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _profileCircle(
            "Active",
            true,
            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100",
          ),
          const SizedBox(width: 16),
          _profileCircle("Unknown", false, null, count: 8),
          const SizedBox(width: 16),
          _profileCircle("Unknown", false, null, count: 5),
          const SizedBox(width: 16),
          _profileCircle("Unknown", false, null),
        ],
      ),
    );
  }

  Widget _profileCircle(
    String label,
    bool isActive,
    String? url, {
    int? count,
  }) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isActive
                      ? const Color(0xFF1173d4)
                      : Colors.transparent,
                  width: 3,
                ),
              ),
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                  image: url != null
                      ? DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: url == null
                    ? Icon(
                        Icons.person,
                        color: Colors.white.withOpacity(0.1),
                        size: 40,
                      )
                    : null,
              ),
            ),
            if (count != null)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFF151C2E),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      count.toString(),
                      style: GoogleFonts.manrope(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? const Color(0xFF1173d4) : Colors.white24,
          ),
        ),
      ],
    );
  }

  Widget _buildMainIdentityCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            height: 480,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?auto=format&fit=crop&q=80&w=1000",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 30,
                  right: 30,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.face,
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
                              "Is this Aunt Marie?",
                              style: GoogleFonts.manrope(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "90% match based on previous tags.",
                              style: GoogleFonts.manrope(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check_circle),
            label: const Text("Yes, Confirm Match"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1173d4),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 64),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _secondaryButton(Icons.account_tree, "Search Tree"),
              ),
              const SizedBox(width: 12),
              Expanded(child: _secondaryButton(Icons.person_add, "Invite New")),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Ignore or not a relative",
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: Colors.white38,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _secondaryButton(IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.08),
        foregroundColor: Colors.white70,
        minimumSize: const Size(0, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 0,
      ),
    );
  }

  Widget _buildAppearsInSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Appears in these photos",
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1173d4).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "12 Photos",
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1173d4),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _photoGrid(),
      ],
    );
  }

  Widget _photoGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              _gridImage(
                "https://images.unsplash.com/photo-1511895426328-dc8714191300?w=300",
              ),
              const SizedBox(width: 12),
              _gridImage(
                "https://images.unsplash.com/photo-1542037104857-ffbb0b9155fb?w=300",
              ),
              const SizedBox(width: 12),
              _gridImage(
                "https://images.unsplash.com/photo-1519741497674-611481863552?w=300",
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _gridImage(
                "https://images.unsplash.com/photo-1511285560929-80b456fea0bc?w=300",
              ),
              const SizedBox(width: 12),
              _gridImage(
                "https://images.unsplash.com/photo-1534330207526-9e4823cde21d?w=300",
              ),
              const SizedBox(width: 12),
              _viewAllGridItem(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _gridImage(String url) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Widget _viewAllGridItem() {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.04)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.grid_view_rounded, color: Colors.white38),
              const SizedBox(height: 4),
              Text(
                "View All",
                style: GoogleFonts.manrope(fontSize: 10, color: Colors.white38),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityFooter() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock, color: Colors.white12, size: 14),
          const SizedBox(width: 8),
          Text(
            "Biometric data is private to this tree.",
            style: GoogleFonts.manrope(fontSize: 12, color: Colors.white12),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1121),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.face_retouching_natural, "Identify", true),
          _navItem(Icons.account_tree, "Tree", false),
          _navItem(Icons.photo_library, "Memories", false),
          _navItem(Icons.settings, "Settings", false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF1173d4) : Colors.white38,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 10,
            color: isActive ? const Color(0xFF1173d4) : Colors.white38,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
