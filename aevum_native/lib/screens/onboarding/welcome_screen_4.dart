import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/background_scaffold.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/custom_bottom_nav_variant1.dart';
import '../../theme/app_theme.dart';

class WelcomeScreen4 extends StatefulWidget {
  const WelcomeScreen4({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen4> createState() => _WelcomeScreen4State();
}

class _WelcomeScreen4State extends State<WelcomeScreen4> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // WelcomeScreen4 has slightly different background blobs in HTML
    // But we'll reuse BackgroundScaffold for consistency unless critical
    return BackgroundScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 56),
            _buildHeader(),
            const SizedBox(height: 16),
            _buildHeroCard(),
            const SizedBox(height: 16),
            _buildGrid(),
            const SizedBox(height: 16),
            _buildQuickActions(),
            const SizedBox(height: 16),
            _buildArchives(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarVariant1(
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
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDVzad7SMhL366Z6ErsTXhjsxwYUIK_sPB9BQSZPSVDM83hcusxUoIvtDgdhqvGdM7st9SEloAN4DfNGWUAnJcxp79-TfJtb139W9pkzZRaSmA_NGVUAQh2xQ_vifX4ipcUOpQQ5nkNjuLAG8daOcouKWRsUV3bs9_uszkSeWWkynA4W_XfhJN3pQBJhbHqRwt88MV_-3uby4R-1psVO81XrbQOq8eC8VxiJiUuecjNx5IgmYu0ICpUwqU8bWXG4E3BY-lUGeOiBx8',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GOOD MORNING',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[300],
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'Alex',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            GlassCard(
              borderRadius: 999,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  const Icon(Icons.verified_user, color: Colors.green, size: 16),
                  const SizedBox(width: 4),
                  const Icon(Icons.auto_awesome, color: Colors.purple, size: 16),
                ],
              ),
            ),
            const SizedBox(width: 8),
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
                      right: 12,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black.withOpacity(0.2), width: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroCard() {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: const DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1511895426328-dc8714191300?auto=format&fit=crop&q=80&w=2000'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: GlassCard(
              borderRadius: 999,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              backgroundColor: Colors.white.withOpacity(0.2),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    'On this day',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Memory • 1998',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.purple[200],
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Grandma's Garden",
                  style: GoogleFonts.inter(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      width: 56, // 24 + 24 + overlap? No.
                      height: 24,
                      child: Stack(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withOpacity(0.1), width: 2),
                              image: const DecorationImage(
                                image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCst1gIFGnX9hkdMwGTaxY6xjUlP-IAFFAh7ypfOuPKGVthwfRdOj01OQ5TVfUrQz3nmE7f3sWLFcEeZsZFJmMIX1GQYL3xDuFw49ZFBVnhAXd455GgLwYdqEj6VP9zHQjOLdbNqUtH9egfkXyq99VsuzDKq8pMEh8dCfPAv4XR6muac_M4rmeOXxkl_Ao8uGNz3sN9rMJ3IlXfIdezJzFvDSMtysjXO7GXs4B2tLwjld77v9VX3o4-npz_pJY5nIomO-I1vO1tcJ4'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[600],
                                border: Border.all(color: Colors.white.withOpacity(0.1), width: 2),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '+2',
                                style: GoogleFonts.inter(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'tagged in this photo',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return Row(
      children: [
        Expanded(
          child: GlassCard(
            borderRadius: 24,
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 192, // h-48 = 12rem = 192px
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.forest, color: Colors.green, size: 24),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tree Growth',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '3',
                            style: GoogleFonts.inter(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'new',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.green[300],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'relatives found this week',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey[400],
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 28,
                        child: Stack(
                          children: [
                            Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.grey[700]!, shape: BoxShape.circle, border: Border.all(color: Colors.grey[800]!, width: 2))),
                            Positioned(left: 20, child: Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.grey[600]!, shape: BoxShape.circle, border: Border.all(color: Colors.grey[800]!, width: 2)))),
                            Positioned(left: 40, child: Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.grey[500]!, shape: BoxShape.circle, border: Border.all(color: Colors.grey[800]!, width: 2)), alignment: Alignment.center, child: const Text('JM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)))),
                          ],
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
        Expanded(
          child: GlassCard(
            borderRadius: 24,
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 192,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.forum, color: Colors.blue, size: 24),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '2',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Messages',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withOpacity(0.05)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 8,
                                  backgroundImage: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDVzad7SMhL366Z6ErsTXhjsxwYUIK_sPB9BQSZPSVDM83hcusxUoIvtDgdhqvGdM7st9SEloAN4DfNGWUAnJcxp79-TfJtb139W9pkzZRaSmA_NGVUAQh2xQ_vifX4ipcUOpQQ5nkNjuLAG8daOcouKWRsUV3bs9_uszkSeWWkynA4W_XfhJN3pQBJhbHqRwt88MV_-3uby4R-1psVO81XrbQOq8eC8VxiJiUuecjNx5IgmYu0ICpUwqU8bWXG4E3BY-lUGeOiBx8'),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Sarah',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '"Did you see the photo I uploaded of..."',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: Colors.grey[300],
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return GlassCard(
      borderRadius: 24,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildActionButton(Icons.add_a_photo, Colors.orange, 'Add Photo', 'Scan or upload')),
              const SizedBox(width: 12),
              Expanded(child: _buildActionButton(Icons.favorite, Colors.pink, 'Favorites', 'View saved')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArchives() {
    return GlassCard(
      borderRadius: 24,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'From the Archives',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'See All',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[300],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildArchiveItem('1985', 'https://lh3.googleusercontent.com/aida-public/AB6AXuDL0ASC5yYi1mDVBhtxP-NWj91-XxfHOUjRJ6xAx69QDglsj3aDqdKWm7cW75kCSWIFX5TjbgNY6SmkePMgb4ZXVHhOMhVUwCBSaXlJjvXb2UeomYB4IxzxWwGaeUkiTvNvFIFyDsPGQW_ca_rn0JU14iyPn5p83rabQcLsLow3LwHlTNOf3nXbFppOC1vE3XQIjJnYnpl-hjGoG3uZxRmH93UmPcLqEgcWK3v1oyX-tcrPXi3c8Ag2nJMC-SvVEuK0FzmGQ_X9yGo'),
                const SizedBox(width: 16),
                _buildArchiveItem('1992', 'https://lh3.googleusercontent.com/aida-public/AB6AXuAtpb0MC0tKaL9Q-459mrQe_yyMmwEgudC0PTs-yip4CCbJIli4jqQY_Fy23VplbWrUM0oF4zM2hvlX9z2yVZQaGTw4MZih0VO3XeRARLIEnWC-N1O145KuwhOFKZEA8A9vO-tPhktc-XaDZtks0OzL_rYm1GMuRxMoWGUg_nahXJpfgZi_Ru9Y89u-JnYZcBsyui2D1YCV2h5uYug2xIGbKlVgNtn0CEIWS1K0axWMAQyFaIKfK6kSi8Cexc0tGgU-VYdNrCsn884'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArchiveItem(String year, String imageUrl) {
    return Container(
      width: 144, // w-36
      height: 192, // h-48
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                year,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
