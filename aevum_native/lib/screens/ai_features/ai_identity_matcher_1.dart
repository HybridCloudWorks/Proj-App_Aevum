import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/glass_card.dart';
import '../../theme/app_theme.dart';

class AIIdentityMatcher1 extends StatefulWidget {
  const AIIdentityMatcher1({Key? key}) : super(key: key);

  @override
  State<AIIdentityMatcher1> createState() => _AIIdentityMatcher1State();
}

class _AIIdentityMatcher1State extends State<AIIdentityMatcher1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      appBar: AppBar(
        backgroundColor: const Color(0xCC101922),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, size: 20, color: Colors.white),
            onPressed: () {},
          ),
        ),
        title: Text(
          'Identify Faces',
          style: GoogleFonts.plusJakartaSans(
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
              'Skip',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Main Image
            Expanded(
              flex: 4,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuC31RpQX57UnykwreUCc1soshAuPgixpGwElecNvQXJSif9R6dIbPPm0zmW6RHa7tjxEgZtuSVpi3k2_i1U5keZSMfcKSoN63rF_cmlAs4G6EciEafIpZyLQqrzMwKGBmucasxYidpGUFHoDgS_YjYEDpWZzRUl3QLJ3gaNFw8-T2Ey2fboKwpq3-4GLm_vuhp7DZEHLbAN---O1iWdAKzJkHVHEp_pYQ7H-gYYgBoj5mcHx-Vo76VwBxdADbZ-gQk6LFwU29mfDRs',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Dark overlay
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  // Scan Box (Selected)
                  Positioned(
                    top: 100, // approx 32%
                    left: 150, // approx 48%
                    width: 60, // approx 14%
                    height: 80, // approx 18%
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.1),
                            border: Border.all(color: AppTheme.primary.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primary.withOpacity(0.4),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        ),
                        // Corners
                        const Positioned(top: -1, left: -1, child: _Corner(isTop: true, isLeft: true)),
                        const Positioned(top: -1, right: -1, child: _Corner(isTop: true, isLeft: false)),
                        const Positioned(bottom: -1, left: -1, child: _Corner(isTop: false, isLeft: true)),
                        const Positioned(bottom: -1, right: -1, child: _Corner(isTop: false, isLeft: false)),

                        // Label
                        Positioned(
                          top: -24,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.primary,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                'Selected',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Crosshair
                        Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            child: Stack(
                              children: [
                                Center(child: Container(width: 8, height: 1, color: AppTheme.primary.withOpacity(0.3))),
                                Center(child: Container(width: 1, height: 8, color: AppTheme.primary.withOpacity(0.3))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Other Faces (Boxes)
                  Positioned(
                    top: 110,
                    left: 70,
                    width: 40,
                    height: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  // Date Badge
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 12, color: Colors.white70),
                          const SizedBox(width: 4),
                          Text(
                            '1964',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Question
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Is this ',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'Grandpa Joe',
                        style: TextStyle(color: AppTheme.primary),
                      ),
                      const TextSpan(text: '?'),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Found in "Summer Vacation 1964"',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Matches Scroll
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildMatchCard('Grandpa Joe', '98% Match', 'https://lh3.googleusercontent.com/aida-public/AB6AXuDQG7P7lNixOixWvE-uS3QVuXaZo73C1_JToDK4GOiaD53rADv7ZLGMfrfENeu5KKJCtFWoy0hiyQ6EPq4uOX6mu5eybJK8NXPVc1S_p77UXJ-z_2gk2HcIfj4MVG3AEW9ZqXROc5W3YnRZfLSo_YzzVJrA4D8XJqZzG_HQBr78F8alwK74qJkLeiVrNMAJb9jR2mPq3m1RN-L92BvA2qgUFYsht_QfWe8Crbu1KqY9H0gWRT9v1A9GpVzo9epCGr_ECpIFR7gs3kk', isSelected: true),
                  const SizedBox(width: 12),
                  _buildMatchCard('Uncle Bob', '45% Match', 'https://lh3.googleusercontent.com/aida-public/AB6AXuBd-l6-9V3Ex2vMHKhRjeppS1TU2PWOD27Ok4JlbnfgpLrHhEp1NjFJpIgghXZfZW1RzYUnwfZMpThAHHQ5ePpwHVZy31S5xeTL2wrj4fOZbhU8aTT4HC4TJ_66d7Cw0jUv-YnvyThMPWmHuvHhCOLD8h67Zk8k5KaHttOXqEtPTllTUWMbp17pwIcd6v6LLmDTqQ1uudhu7r8Alhv3-6rqRScb32F-CNV9FIBvdadhlDnNMyME3QePtPLJaIAV3V0MYfqyrfQd2as'),
                  const SizedBox(width: 12),
                  _buildNewPersonCard(),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Info Grid
            Row(
              children: [
                Expanded(
                  child: GlassCard(
                    borderRadius: 16,
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.white.withOpacity(0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.face, color: AppTheme.primary, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'AI GROUPING',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'Seen in ',
                            style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.grey[200]),
                            children: [
                              TextSpan(
                                text: '12 other photos',
                                style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GlassCard(
                    borderRadius: 16,
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.white.withOpacity(0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FAMILY TREE',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Suggested from',
                          style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.grey[200]),
                        ),
                        Text(
                          'Paternal Line',
                          style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.how_to_reg, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Confirm Match',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildSecondaryButton(Icons.person_off, 'Not a Person'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSecondaryButton(Icons.edit, 'Edit Selection'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchCard(String name, String matchPercent, String imageUrl, {bool isSelected = false}) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primary.withOpacity(0.15) : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isSelected ? AppTheme.primary.withOpacity(0.4) : Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isSelected ? AppTheme.primary : Colors.white.withOpacity(0.1), width: 2),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            matchPercent,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppTheme.primary : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewPersonCard() {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), style: BorderStyle.solid), // Dashed preferred
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Text(
            'New Person',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton(IconData icon, String label) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: Colors.grey[300]),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}

class _Corner extends StatelessWidget {
  final bool isTop;
  final bool isLeft;

  const _Corner({Key? key, required this.isTop, required this.isLeft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? BorderSide(color: AppTheme.primary, width: 2) : BorderSide.none,
          bottom: !isTop ? BorderSide(color: AppTheme.primary, width: 2) : BorderSide.none,
          left: isLeft ? BorderSide(color: AppTheme.primary, width: 2) : BorderSide.none,
          right: !isLeft ? BorderSide(color: AppTheme.primary, width: 2) : BorderSide.none,
        ),
      ),
    );
  }
}
