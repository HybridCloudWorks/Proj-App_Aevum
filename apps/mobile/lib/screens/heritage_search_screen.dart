import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeritageSearchScreen extends StatefulWidget {
  const HeritageSearchScreen({super.key});

  @override
  State<HeritageSearchScreen> createState() => _HeritageSearchScreenState();
}

class _HeritageSearchScreenState extends State<HeritageSearchScreen> {
  String _selectedEra = '1800s';
  final List<String> _eras = ['1700s', '1800s', '1900s', '2000s'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F151B),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    const SizedBox(height: 24),
                    _buildFilterSection(),
                    const SizedBox(height: 32),
                    _buildResultsHeader(),
                    const SizedBox(height: 20),
                    _buildResultsGridWithWide(),
                  ],
                ),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: Colors.white, size: 28),
          Text(
            "AEVUM",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.1),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=200&auto=format&fit=crop",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.white.withValues(alpha: 0.5),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: "Search ancestors, locations...",
                hintStyle: GoogleFonts.plusJakartaSans(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.mic, color: Colors.blue.shade400, size: 20),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "ERA",
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white30,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            Text(
              "RESET",
              style: GoogleFonts.plusJakartaSans(
                color: Colors.blue.shade400,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _eras.map((era) => _buildEraButton(era)).toList(),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "BRANCH",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white30,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.add_circle_outline,
                        color: Colors.white30,
                        size: 12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Rutherford Line",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Paternal Side",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white30,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "MEDIA TYPE",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white30,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildMediaIcon(Icons.image, "Photos", false),
                    const SizedBox(width: 12),
                    _buildMediaIcon(Icons.description, "Docs", true),
                    const SizedBox(width: 12),
                    _buildMediaIcon(Icons.auto_awesome, "AI", false),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEraButton(String era) {
    bool isSelected = _selectedEra == era;
    return GestureDetector(
      onTap: () => setState(() => _selectedEra = era),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.shade600
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Colors.blue.shade400
                : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Text(
          era,
          style: GoogleFonts.plusJakartaSans(
            color: isSelected ? Colors.white : Colors.white54,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMediaIcon(IconData icon, String label, bool active) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: active
                ? Colors.blue.shade600
                : Colors.white.withValues(alpha: 0.05),
            shape: BoxShape.circle,
            border: Border.all(
              color: active
                  ? Colors.blue.shade400
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: active ? Colors.blue.shade400 : Colors.white24,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildResultsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Results ",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "(24 found)",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white30,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            _buildIconToggle(Icons.grid_view, true),
            const SizedBox(width: 8),
            _buildIconToggle(Icons.list, false),
          ],
        ),
      ],
    );
  }

  Widget _buildIconToggle(IconData icon, bool active) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: active
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: active ? Colors.white : Colors.white24,
        size: 18,
      ),
    );
  }

  Widget _buildResultCard(
    String title,
    String subtitle,
    String tag,
    String imgUrl, {
    bool isRecord = false,
    bool isAI = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: NetworkImage(imgUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          if (isAI)
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF6366F1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isRecord
                    ? Colors.blue.shade600
                    : Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                tag,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper for the wide card since it's in a grid
  Widget _buildResultsGridWithWide() {
    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
          children: [
            _buildResultCard(
              "Arthur J. Rutherford",
              "Portrait • London",
              "1883",
              "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400&auto=format&fit=crop",
            ),
            _buildResultCard(
              "Census Record",
              "1880 • New York",
              "RECORD",
              "https://images.unsplash.com/photo-1586769852836-bc069f19e1b6?w=400&auto=format&fit=crop",
              isRecord: true,
            ),
            _buildResultCard(
              "The Journey West",
              "AI reconstruction...",
              "AI",
              "https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=400&auto=format&fit=crop",
              isAI: true,
            ),
            _buildResultCard(
              "Sarah E. Miller",
              "1921 • Chicago",
              "1921",
              "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&auto=format&fit=crop",
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildWideCard(
          "Edinburgh Homestead",
          "HERITAGE SITE",
          "https://images.unsplash.com/photo-1533154683836-84ea7a0bc310?w=800&auto=format&fit=crop",
        ),
      ],
    );
  }

  Widget _buildWideCard(String title, String tag, String imgUrl) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: NetworkImage(imgUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 12,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      tag,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Removed redundant build method

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: BoxDecoration(
        color: const Color(0xFF0F151B),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.home, color: Colors.white.withValues(alpha: 0.3)),
          const Icon(Icons.search, color: Colors.blue),
          Icon(Icons.account_tree, color: Colors.white.withValues(alpha: 0.3)),
          Icon(Icons.settings, color: Colors.white.withValues(alpha: 0.3)),
        ],
      ),
    );
  }
}


