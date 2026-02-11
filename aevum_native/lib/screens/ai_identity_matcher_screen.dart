import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class AIIdentityMatcherScreen extends StatelessWidget {
  const AIIdentityMatcherScreen({super.key});

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
          "Identify Faces",
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Skip",
              style: GoogleFonts.manrope(color: Colors.white54, fontSize: 14),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildMainImage(),
            const SizedBox(height: 30),
            _buildQuestionSection(),
            const SizedBox(height: 24),
            _buildProfileMatches(),
            const SizedBox(height: 24),
            _buildDetailsGrid(),
            const SizedBox(height: 40),
            _buildActionButtons(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMainImage() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: const DecorationImage(
          image: NetworkImage(
            "https://images.unsplash.com/photo-1511895426328-dc8714191300?auto=format&fit=crop&q=80&w=1000",
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
        ),
      ),
      child: Stack(
        children: [
          // Facial recognition boxes
          Positioned(top: 50, left: 60, child: _faceBox(isSelected: false)),
          Positioned(
            top: 45,
            left: 170,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1173d4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Selected",
                    style: GoogleFonts.manrope(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                _faceBox(isSelected: true),
              ],
            ),
          ),
          Positioned(top: 60, left: 280, child: _faceBox(isSelected: false)),
          // Year Badge
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.white70,
                    size: 12,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "1964",
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _faceBox({required bool isSelected}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? const Color(0xFF1173d4) : Colors.white30,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildQuestionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.manrope(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            children: const [
              TextSpan(text: "Is this "),
              TextSpan(
                text: "Grandpa Joe",
                style: TextStyle(color: Color(0xFF1173d4)),
              ),
              TextSpan(text: "?"),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Found in \"Summer Vacation 1964\"",
          style: GoogleFonts.manrope(fontSize: 14, color: Colors.white54),
        ),
      ],
    );
  }

  Widget _buildProfileMatches() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _matchCard(
            "Grandpa Joe",
            "98% Match",
            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=100",
            true,
          ),
          const SizedBox(width: 12),
          _matchCard(
            "Uncle Bob",
            "45% Match",
            "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=100",
            false,
          ),
          const SizedBox(width: 12),
          _newPersonCard(),
        ],
      ),
    );
  }

  Widget _matchCard(String name, String match, String url, bool isSelected) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF1173d4).withOpacity(0.1)
            : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected
              ? const Color(0xFF1173d4)
              : Colors.white.withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(url)),
              if (isSelected)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF1173d4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            match,
            style: GoogleFonts.manrope(
              fontSize: 11,
              color: isSelected ? const Color(0xFF1173d4) : Colors.white38,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _newPersonCard() {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white38),
          ),
          const SizedBox(height: 12),
          Text(
            "New Person",
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white38,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsGrid() {
    return Row(
      children: [
        Expanded(
          child: _detailCard(
            "AI GROUPING",
            "Seen in 12 other photos",
            Icons.face,
            hasAvatars: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _detailCard(
            "FAMILY TREE",
            "Suggested from Paternal Line",
            Icons.account_tree,
            subtext2: "Detroit, MI",
            icon2: Icons.location_on,
          ),
        ),
      ],
    );
  }

  Widget _detailCard(
    String label,
    String value,
    IconData icon, {
    bool hasAvatars = false,
    String? subtext2,
    IconData? icon2,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF1173d4), size: 16),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          if (hasAvatars)
            Row(
              children: [
                _miniAvatar(
                  "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=50",
                ),
                _miniAvatar(
                  "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=50",
                ),
                _miniAvatar(
                  "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=50",
                ),
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "+9",
                    style: TextStyle(fontSize: 8, color: Colors.white70),
                  ),
                ),
              ],
            ),
          if (subtext2 != null)
            Row(
              children: [
                Icon(icon2 ?? Icons.circle, color: Colors.white38, size: 12),
                const SizedBox(width: 6),
                Text(
                  subtext2,
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _miniAvatar(String url) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        border: Border.all(color: Colors.white24, width: 1),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.person),
          label: Text(
            "Confirm Match",
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1173d4),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectanglePlatform.borderRadius(20),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.person_off, size: 18),
                label: const Text("Not a Person"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: const BorderSide(color: Colors.white12),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectanglePlatform.borderRadius(16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, size: 18),
                label: const Text("Edit Selection"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: const BorderSide(color: Colors.white12),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectanglePlatform.borderRadius(16),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RoundedRectanglePlatform {
  static RoundedRectangleBorder borderRadius(double radius) {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
  }
}
