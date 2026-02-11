import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/background_scaffold.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../../widgets/section_header.dart';
import '../../theme/app_theme.dart';

class WelcomeScreen1 extends StatefulWidget {
  const WelcomeScreen1({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen1> createState() => _WelcomeScreen1State();
}

class _WelcomeScreen1State extends State<WelcomeScreen1> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120), // Bottom padding for nav bar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 56), // Top padding for header
            _buildHeader(),
            const SizedBox(height: 24),
            _buildHeroCard(),
            const SizedBox(height: 16),
            _buildStatsGrid(),
            const SizedBox(height: 16),
            const SectionHeader(
              title: 'Recent Memories',
              icon: Icons.history_edu,
              iconColor: Colors.orange,
            ),
            _buildRecentMemories(),
            const SizedBox(height: 16),
            _buildActionButtons(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.blue, Colors.purple],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black.withOpacity(0.5), width: 2),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/user_profile.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[300],
                  ),
                ),
                Text(
                  'Alex',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18, // text-lg
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                    letterSpacing: -0.5, // tracking-tight
                  ),
                ),
              ],
            ),
          ],
        ),
        GlassCard(
          borderRadius: 999,
          padding: EdgeInsets.zero,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.notifications_outlined, color: Colors.white70),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard() {
    return SizedBox(
      height: 224, // h-56 = 14rem = 224px
      width: double.infinity,
      child: Stack(
        children: [
          // Background Image with Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: const DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1534330207526-9e4823cde21d?auto=format&fit=crop&q=80&w=2000'),
                fit: BoxFit.cover,
                opacity: 0.4,
              ),
            ),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.transparent,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // SVG Patterns (Simplified as CustomPaint or just skipped/approximated for now)
          // Text Content
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Text(
                        'QUICK PAN',
                        style: GoogleFonts.manrope(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[100],
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Family Tree',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 24, // text-2xl
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Last edited 2 hours ago by Sarah',
                      style: GoogleFonts.manrope(
                        fontSize: 14, // text-sm
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.open_in_full, color: Colors.black, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        // Growth Card
        Expanded(
          child: GlassCard(
            borderRadius: 24,
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 144, // h-44 = 11rem = 176px? No, 44 * 4 = 176px. Tailwind h-44 is 11rem.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.spa, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Growth',
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[200],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '142',
                        style: GoogleFonts.manrope(
                          fontSize: 30, // text-3xl
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Members added',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progress Bar
                      Container(
                        height: 6,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.75,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green[400],
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '+12 this month',
                        style: GoogleFonts.manrope(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.green[300],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // AI Tasks Card
        Expanded(
          child: GlassCard(
            borderRadius: 24,
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 144, // Match sibling
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.auto_fix_high, color: Colors.purple, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'AI Tasks',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[200],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '3',
                          style: GoogleFonts.manrope(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // User List Item
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCst1gIFGnX9hkdMwGTaxY6xjUlP-IAFFAh7ypfOuPKGVthwfRdOj01OQ5TVfUrQz3nmE7f3sWLFcEeZsZFJmMIX1GQYL3xDuFw49ZFBVnhAXd455GgLwYdqEj6VP9zHQjOLdbNqUtH9egfkXyq99VsuzDKq8pMEh8dCfPAv4XR6muac_M4rmeOXxkl_Ao8uGNz3sN9rMJ3IlXfIdezJzFvDSMtysjXO7GXs4B2tLwjld77v9VX3o4-npz_pJY5nIomO-I1vO1tcJ4'),
                              fit: BoxFit.cover,
                              opacity: 0.8,
                              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Grandpa '54",
                                style: GoogleFonts.manrope(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Enhance color',
                                style: GoogleFonts.manrope(
                                  fontSize: 10,
                                  color: Colors.purple[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Button
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.purple.withOpacity(0.3)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Start Restore',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.purple[100],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentMemories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildMemoryItem(
            'Summer Wedding',
            '1985',
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDL0ASC5yYi1mDVBhtxP-NWj91-XxfHOUjRJ6xAx69QDglsj3aDqdKWm7cW75kCSWIFX5TjbgNY6SmkePMgb4ZXVHhOMhVUwCBSaXlJjvXb2UeomYB4IxzxWwGaeUkiTvNvFIFyDsPGQW_ca_rn0JU14iyPn5p83rabQcLsLow3LwHlTNOf3nXbFppOC1vE3XQIjJnYnpl-hjGoG3uZxRmH93UmPcLqEgcWK3v1oyX-tcrPXi3c8Ag2nJMC-SvVEuK0FzmGQ_X9yGo',
          ),
          const SizedBox(width: 12),
          _buildMemoryItem(
            'First Grade',
            '1992',
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAtpb0MC0tKaL9Q-459mrQe_yyMmwEgudC0PTs-yip4CCbJIli4jqQY_Fy23VplbWrUM0oF4zM2hvlX9z2yVZQaGTw4MZih0VO3XeRARLIEnWC-N1O145KuwhOFKZEA8A9vO-tPhktc-XaDZtks0OzL_rYm1GMuRxMoWGUg_nahXJpfgZi_Ru9Y89u-JnYZcBsyui2D1YCV2h5uYug2xIGbKlVgNtn0CEIWS1K0axWMAQyFaIKfK6kSi8Cexc0tGgU-VYdNrCsn884',
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 128, // w-32
                height: 160, // h-40
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                  color: Colors.white.withOpacity(0.05),
                ),
                child: const Center(
                  child: Icon(Icons.add_a_photo, color: Colors.white54, size: 30),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  'Add New',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemoryItem(String title, String year, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 128, // w-32
          height: 160, // h-40
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black87, Colors.transparent],
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Text(
                  year,
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[300],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: GlassCard(
            borderRadius: 24,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person_add, color: Colors.blue, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invite',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Kinship',
                      style: GoogleFonts.manrope(
                        fontSize: 10,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GlassCard(
            borderRadius: 24,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.mic, color: Colors.orange, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Record',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Story',
                      style: GoogleFonts.manrope(
                        fontSize: 10,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
