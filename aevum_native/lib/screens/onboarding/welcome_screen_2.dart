import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/background_scaffold.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../../theme/app_theme.dart';

class WelcomeScreen2 extends StatefulWidget {
  const WelcomeScreen2({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen2> createState() => _WelcomeScreen2State();
}

class _WelcomeScreen2State extends State<WelcomeScreen2> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 56),
            _buildHeader(),
            const SizedBox(height: 24),
            _buildHeroCard(),
            const SizedBox(height: 16),
            _buildStatsGrid(),
            const SizedBox(height: 16),
            _buildSectionHeader(),
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
                    image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDVzad7SMhL366Z6ErsTXhjsxwYUIK_sPB9BQSZPSVDM83hcusxUoIvtDgdhqvGdM7st9SEloAN4DfNGWUAnJcxp79-TfJtb139W9pkzZRaSmA_NGVUAQh2xQ_vifX4ipcUOpQQ5nkNjuLAG8daOcouKWRsUV3bs9_uszkSeWWkynA4W_XfhJN3pQBJhbHqRwt88MV_-3uby4R-1psVO81XrbQOq8eC8VxiJiUuecjNx5IgmYu0ICpUwqU8bWXG4E3BY-lUGeOiBx8'),
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
                  'WELCOME BACK',
                  style: GoogleFonts.montserrat(
                    fontSize: 12, // text-xs
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[300],
                    letterSpacing: 0.5, // tracking-wide
                  ),
                ),
                Text(
                  'Alex',
                  style: GoogleFonts.montserrat(
                    fontSize: 20, // text-xl
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                    letterSpacing: -0.5, // tracking-tight
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'AEVUM',
              style: GoogleFonts.montserrat(
                fontSize: 20, // text-xl
                fontWeight: FontWeight.w900, // font-black
                letterSpacing: 3.2, // tracking-[0.2em] ~ 20 * 0.2 = 4
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(width: 16),
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
        ),
      ],
    );
  }

  Widget _buildHeroCard() {
    return SizedBox(
      height: 224,
      width: double.infinity,
      child: Stack(
        children: [
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
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[100],
                          letterSpacing: 1.5, // tracking-widest
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Family Tree',
                      style: GoogleFonts.montserrat( // sans serif
                        fontSize: 24, // text-2xl
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5, // tracking-tight
                      ),
                    ),
                    Text(
                      'Last edited 2h ago by Sarah',
                      style: GoogleFonts.montserrat(
                        fontSize: 14, // text-sm
                        fontWeight: FontWeight.w500,
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
        Expanded(
          child: GlassCard(
            borderRadius: 24,
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 144,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.spa, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'GROWTH',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[200],
                          letterSpacing: 0.5, // tracking-wide
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '142',
                        style: GoogleFonts.montserrat(
                          fontSize: 36, // text-4xl
                          fontWeight: FontWeight.w800, // extrabold
                          color: Colors.white,
                          letterSpacing: -1.0, // tracking-tighter
                        ),
                      ),
                      Text(
                        'Members added',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        '+12 THIS MONTH',
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[300],
                          letterSpacing: 0.5, // tracking-wide
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
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 144,
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
                            'AI TASKS',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[200],
                              letterSpacing: 0.5, // tracking-wide
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
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600, // semibold
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Enhance color',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.purple[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                      'START RESTORE',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[100],
                        letterSpacing: 0.5, // tracking-wide
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

  Widget _buildSectionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.history_edu, color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              Text(
                'RECENT MEMORIES',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: const Color(0xFFE5E7EB),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'VIEW ALL',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF9CA3AF),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
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
                width: 128,
                height: 160,
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
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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
          width: 128,
          height: 160,
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
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
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
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
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
                      'INVITE',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'to Kinship',
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
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
                      'RECORD',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'a Story',
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
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
