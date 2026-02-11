import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeritageMapScreen extends StatelessWidget {
  const HeritageMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1015),
      body: Stack(
        children: [
          // 1. Interactive Map Layer (Simulated with Image)
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDipXXkhtdLez0uOSBrxpYrZ3aj5qn2LxSI410UIY4fwaYQARZvG6MI1UzRkWCJYSJhXrXOCNngHQSYbA5we3pwiUfffPFH285sYxxR5Dq5wDsiufbFYGHGkT8dc3JQTFkif3eJiJtrrhjUToQ44KqRbby586qGHYIuQ87Eo_yDXVuhl7coEQkdi7lIqutzHNFVsau7jIUQueow3tmdnnquZOBIkbM-Cid_NGGjaByeS1HGs0h-qsTlATRelHkC6w457cglF76Nkak',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.black26),
              ),
            ),
          ),

          // 2. Map Pins (Glass Orbs)
          _buildMapPin(
            context,
            top: 0.40,
            left: 0.45,
            imageUrl:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDtLi3Kg6MacYJ8tK6FuMGwbBWGIy0aDc-zS-_TmdQUKxChBjCABdycrSGe9DvMvjMwGTVApKFbtr6BVDrKW_kkF_O24yeuNgKsVkK4ZK6BUQPXa6YtpuNgAvy8j_j15ZeV1qGH2MsoqygOzNh87ubF-G2mDzsw2v9GgFlek4Q5SRJyp106yECoumifEXauxho3vtM3yKaK5Tov8jiA0MxJGwchf2bGsRkk0EHR_nbGxdsT7RaRBlJvz4DEj62-EayRfdgukxx_b10',
            badgeCount: '+14',
            label: 'Tuscany Roots',
            isFeatured: true,
          ),
          _buildMapPin(
            context,
            top: 0.28,
            left: 0.35,
            imageUrl:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuC09m8XmORd7jMBDvGyk68B4PyuJwDzSlTQyZg8C2HPMBWPugQyF0o_p6KFmEaZyjHvaDW4BO4dHKjnGXwKp3DjvC43HAQIDJccNyWg0k5bt7BfGhwfpEzBjNp3-wb5rajC-Pv8Q3uroaiPAO8lAhN2qBKj-22_iOQzO_57tMUqMPofxEOsTxkyTNtos8yjRstoQQNPQKRMlHySo_fydxbbsgazrREQVIlgnZ4cID2rK1zOkQhdvSJWCEqK212_v8IZvanmNGlj21I',
            isGrayscale: true,
          ),
          _buildMapPin(
            context,
            top: 0.55,
            left: 0.52,
            imageUrl:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCpT9fqAYWWjViykT-ROnMfPQBZFpiUXJQ9wPmsYWrF0R93jiyZcw_XVhB3KOxAcOr-hO20FrXz3q27yAscGG614vwb-Qd-XZLx-_6J_TOHI9NdtdgE2Pmc4EzvO6zgKylgazBhTna2JuVidRu2w70rzTTEYmh_kNtQsXBbGR3AiHhnjPDCa0I48R2ZEmH9KvWFkjpROs-oOJ5aQ1MFCKGVnzAg4OkLNN1wDhAhOFPsQWBaIsbJxf58DYIpGZsV1q91CgvmcWyplXc',
          ),

          // 3. UI Overlay Layers
          _buildTopOverlay(context),
          _buildRightControls(context),

          // 4. Draggable Bento Bottom Sheet
          _buildDraggableBottomSheet(context),
        ],
      ),
    );
  }

  Widget _buildMapPin(
    BuildContext context, {
    required double top,
    required double left,
    required String imageUrl,
    String? badgeCount,
    String? label,
    bool isFeatured = false,
    bool isGrayscale = false,
  }) {
    return Positioned(
      top: MediaQuery.of(context).size.height * top,
      left: MediaQuery.of(context).size.width * left,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: isFeatured ? 56 : 48,
                height: isFeatured ? 56 : 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0x331173D4),
                  border: Border.all(color: const Color(0x801173D4), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x661173D4).withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: ColorFiltered(
                    colorFilter: isGrayscale
                        ? const ColorFilter.matrix([
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0,
                            0,
                            0,
                            1,
                            0,
                          ])
                        : const ColorFilter.mode(
                            Colors.transparent,
                            BlendMode.multiply,
                          ),
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ),
              ),
              if (badgeCount != null)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1173D4),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white24, width: 1),
                    ),
                    child: Text(
                      badgeCount,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (label != null)
            Padding(
              padding: const EdgeInsets.top(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Text(
                      label,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTopOverlay(BuildContext context) {
    return Positioned(
      top: 60,
      left: 20,
      right: 20,
      child: Column(
        children: [
          // Search Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.white38),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.plusJakartaSans(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search ancestors, places, or dates...',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white38,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Colors.white12,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.tune,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Mode Toggles
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildModeTab('Ancestral Roots', isActive: true),
                _buildModeTab('Family Travels', isActive: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeTab(String label, {required bool isActive}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1173D4) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          color: isActive ? Colors.white : Colors.white38,
          fontSize: 12,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildRightControls(BuildContext context) {
    return Positioned(
      right: 20,
      top: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        gap: 12,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {},
                ),
                const Divider(color: Colors.white10, height: 1),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          _buildSideIconButton(Icons.my_location),
          _buildSideIconButton(Icons.layers),
        ],
      ),
    );
  }

  Widget _buildSideIconButton(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget _buildDraggableBottomSheet(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.12,
      minChildSize: 0.12,
      maxChildSize: 0.55,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xCC101922),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                border: Border.all(color: Colors.white12),
              ),
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Bottom Sheet Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.between,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Color(0xFF1173D4),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'ACTIVE REGION',
                                style: GoogleFonts.plusJakartaSans(
                                  color: const Color(0xFF1173D4),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tuscany, Italy',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '1890 - 1920 • The Ricci Era',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white38,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white10,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.share,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Bento Grid
                  _buildBentoGrid(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBentoGrid() {
    return Column(
      children: [
        // Wide Story Tile
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDk0698TlNnmR9J57eq-ABO-w1CfkmZc5Hgftu3p4yLlyuxppJkV5_gwUUtTGxPS7nkSSfBqph5veJkv1BdGQGwWcZdne4n3yti6zY40hCw1PwRbtIHn1HAhxkO7okldjUN4865vBUyVQutaf_N9qNXlrcmJr8WK-5iBEDwNuvg6-Fgs2t3ncCD_bzvzrb0UV4QS9HPv94h9hLb5lglYkgH9x5SPqeQWC3seYkJmNL08EW6s5UDnLvU5AWAZAjkP8IUxDAYTedP_XI',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.history_edu,
                      color: Colors.white70,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Featured Story',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'The Ricci Family Home',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          gap: 12,
          children: [
            // Gallery Tile
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAvatarStack(),
                    const SizedBox(height: 12),
                    Text(
                      '14 Photos',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'From this region',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white38,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Stats Tile
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0x331173D4),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0x4D1173D4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.groups,
                      color: Color(0xFF1173D4),
                      size: 24,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '4',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'GENERATIONS',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Scrubber / Timeline Tile
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.3,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1173D4),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.between,
                      children: [
                        Text(
                          '1880',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white24,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          '1895',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '2024',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white24,
                            fontSize: 10,
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

  Widget _buildAvatarStack() {
    return SizedBox(
      height: 32,
      child: Stack(
        children: [
          _buildStackedAvatar(
            0,
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDyFb_aap00-1Bxx_9bvAK3wLkoRKF7u-vqIgigZSv3n2BaP4nAFMMPvRG5d7e-GikDsfEL8SPnNAXoslikw7Ke7OR9-zTSuNk6QA3uvW-lMO4Wb4WACNKq9uauUDbkR2OrH58MOAOdTKqU1lf0vHl_W-TIojjAIDlyZlW-_toxNya2mhals7ECMyDUY-CrG4wl_NNdBldrH_a5s-g8MY0do5bW0PZTl9n4vngdqI5WbbwqSfYEzrsk6CGagk04BfDQoEKp6RF7tWI',
          ),
          _buildStackedAvatar(
            1,
            'https://lh3.googleusercontent.com/aida-public/AB6AXuARbdC-_YtWtO3zX5uZJvatpys5wwbvW8zJM5x2liNna2UeAHA9ksDZfAsf6xf6nzzX6HgJmT50IImVuzUdD_o4KNzaXlhVITntxpEvE-u10Ins4YcdQZXJH3xSCBM4iQqH-T3AOXcSu7QD7p2-GjpFZZtaQuNEWVMghBbFmgz2vHIc-xf8zqjU_A3iDChEPjr_LXXkav8WmwaPm2B1dhCUzDo5mRJQbScRjLVoP4eG7nRH-R50EtqUn42DTEZVAccQXg93U22yP9A',
          ),
          _buildStackedAvatar(
            2,
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAWKVt9AJuVbXhzZPCAeU9RiXhJive8FBHw0h620dO3we_Xl6teRX-fG7aBCnqG6dNelxuEQAsUP3D4VhW489Hs03HtqoIn65wV4BS0WDfSIcX4g5-jxxhyaTVGk81w_WkzHlESieiLicn7qmCFo3U9CX2fnJwi2tTPYWJGboVbNiN7c20rvIQPxARCgnHtyRRP8DR6jXPRRO9mF8Qc3xh8JToqImCVL7CGHDUjUlnkq1E0qIaLrOFGKuFKd4-R-2VQHRIgWh9FEUs',
          ),
          Positioned(
            left: 24 * 3.0,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF1173D4),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF171d25), width: 2),
              ),
              child: const Center(
                child: Text(
                  '+4',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackedAvatar(int index, String url) {
    return Positioned(
      left: index * 24.0,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF171d25), width: 2),
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
