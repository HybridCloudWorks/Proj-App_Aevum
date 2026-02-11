import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../widgets/glass_card.dart';
import '../../theme/app_theme.dart';

class IdentityProfile extends StatefulWidget {
  const IdentityProfile({Key? key}) : super(key: key);

  @override
  State<IdentityProfile> createState() => _IdentityProfileState();
}

class _IdentityProfileState extends State<IdentityProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F12),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, size: 20),
            onPressed: () {},
          ),
        ),
        title: Text(
          'FAMILY TREE',
          style: GoogleFonts.publicSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.more_horiz, size: 20),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 120),
            child: Column(
              children: [
                // Hero Section
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        // Background Image
                        Container(
                          height: 400,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuD-oyhRVhSG2iIq_vrIA4_h8UAzmKunZ_CN647bOSTeCAJysuwNaoZzrdXx6p4kZKvRS4riWOYIQzNYjgtpVc2NWIF-A_L-cnphJoXiApokraUhkMqHAb5uUN8Hl3a-dReB_iBGLiikNvLepb-iJ1XzWq3QcsEXev7WeJiu4KfYr5kAX5f_yR-xvyw7N11UtvozoUw1kmMUzlwOYI5LkGlgIG53q3_1fACbjcF4MTtnH2ZAlh4bKeYqwvmKgaZ_MbCcZtCeOzpiCyY'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFF0F0F12).withOpacity(0.4),
                                  const Color(0xFF0F0F12).withOpacity(0.9),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Content
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              // Parent Origin Indicators
                              Row(
                                children: [
                                  _buildOriginPill(Icons.female, Colors.pinkAccent, 'https://lh3.googleusercontent.com/aida-public/AB6AXuDzzjrxVlqF1xub-PtALcCXbgaJZU4vNgfsIA5JLrlOxpXT3RBbeKc5WQoRObzwsTmMeg_wGg9WYluJmJUGKeK9RxgAiXM1xsURVQUUcxEBjK-goU7WgvTlZf6qw-m8WoOU6GUv4_bGU4S0uF6tKNYOn_s7q6Uy3LHqkaMHS3yfICWJzm7PDOzhUaG6ZgcL2IZQAx4WcUE_FcmDrrRpMj_PefiYgoE_VDxwxnncBaRyBHlHc9imPXtC1Raa_qEpkpXi47AP8pSMzDA'),
                                  const SizedBox(width: 8),
                                  _buildOriginPill(Icons.male, Colors.blueAccent, 'https://lh3.googleusercontent.com/aida-public/AB6AXuAeQSfjEriYOvmYAgYJWykUtj_D6FkYi1q6XRQlpRQiQv1VuOQWbzC7VipIyEAaJ7FCY6LrMjTuXVRRzOBSr9Fcnczysp-n16vxzIieHhWVT1x6p-4bsSNIZKPO0_mnDMaJ9f-czMbThB1zir_lPqjdTlOSMNpyPjrQk_vRExNDX-tFCJze_8w6GwvPVW379L9Gu9fQrdWk10CpDnv4qnuSw4n--PAxYQdo-LFn7UcCfGP2qgFS_q4TgVAI9jZRpXycKG6p7wE22q4'),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Profile Avatar
                              SizedBox(
                                width: 128,
                                height: 128,
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [Colors.white.withOpacity(0.2), Colors.white.withOpacity(0.05)],
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: const Color(0xFF0F0F12), width: 2),
                                          image: const DecorationImage(
                                            image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCiBhyW7LOXta9AdX-TD8CixwU9Se6lU4DZRI0y5L9hoKLdTJsv8OpUOxX2LDUInp2ygYOiZb9LActFcsnZW_6iYlEz9Jna4cLRiYAEfX1wbybd7ZnC3fbrpobpdU3z-mxgi_lF0hca3R4CWPwXIwF8kz6BYrrAbiLU8m2Th61nIrSdhASVvhRcpfN-9vW_Orpd7PYoSV_z2Ai8i2OGcvOlVWERtAMxWEZ74N7i_rwoDIo0LSNVYjhGv3bN7_wL54L28DYxaArmVvE'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Verified Badge
                                    Positioned(
                                      bottom: 4,
                                      right: 4,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primary,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: const Color(0xFF0F0F12), width: 2),
                                        ),
                                        child: const Icon(Icons.check, size: 16, color: Colors.white),
                                      ),
                                    ),
                                    // Citizenship Badge
                                    Positioned(
                                      bottom: 4,
                                      left: 4,
                                      child: SizedBox(
                                        width: 32,
                                        height: 32,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                                                  image: const DecorationImage(image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDsjnLKTYfTRXi1jXH7VasYv9KqZgB649chvG4lWatc7BDxcjGgeSteTDL2XjMXM5dMOrWIEjdeLTFmxF5obSIeicOgv78WouyysGf1GbCXQbUXE03OSFtriHQLwyF6osuEh214fR1xIQ9ucn-mSdix5FKfSjsRjG8Au1B_5pwAi0OoGmTPnROUPbHwc06rFt0H-BC1cIJzmN8QTdAKqDKku7MKyr3OOkkj9EhtUHIFyyz9GC2s79V2-l3Mk2MKIU341TswO6hFsCw'), fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 32,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: const Color(0xFF0F0F12), width: 2),
                                                image: const DecorationImage(image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCGvDvYnLo0lMbyKBSHHzM8f7E2LCLNyoKTbl0Ht8wwPD5opg0JtnmzYxMvfZAncknMpMPeC6mDS6bjiKUW4tsaaIjkfmgr8NzQB8p5YVyuUEWpdEuXdOGWqFXsMhcmBrS1H3aFxUErDu5GYE3EEWFyE_Sg4Ht1qgsAIibJhO0RvPWIiFJKhLlUczqNGrbQPp8v-Ya6NdURMjnoVNmD81x7X5vzhWE9SM4m0zohMNF22rb2l4eAPZEF5v0TJgznMnd8zvFCsYwgZjs'), fit: BoxFit.cover),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 12),
                              Text(
                                'Arthur James Sterling',
                                style: GoogleFonts.publicSans(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('1892', style: GoogleFonts.publicSans(color: Colors.white70)),
                                  const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Icon(Icons.circle, size: 4, color: Colors.white38)),
                                  Text('1954', style: GoogleFonts.publicSans(color: Colors.white70)),
                                  const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Icon(Icons.circle, size: 4, color: Colors.white38)),
                                  Text('62 Years', style: GoogleFonts.publicSans(color: Colors.white70)),
                                ],
                              ),

                              const SizedBox(height: 24),

                              Row(
                                children: [
                                  Expanded(
                                    child: _buildActionButton(Icons.share, 'Share', isPrimary: false),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildActionButton(Icons.edit, 'Edit Profile', isPrimary: true),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Bento Grid
                // Vital Records (Full Width)
                GlassCard(
                  borderRadius: 16,
                  padding: const EdgeInsets.all(20),
                  backgroundColor: const Color(0x991E1E23), // glass-card
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.folder_open, color: Colors.orange, size: 20),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'VITAL RECORDS',
                                style: GoogleFonts.publicSans(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.9),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '3 Found',
                              style: GoogleFonts.publicSans(fontSize: 12, color: Colors.white38),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildRecordItem(Icons.description, '1900 US Census', 'Cook County, IL'),
                      const SizedBox(height: 8),
                      _buildRecordItem(Icons.badge, 'WWI Draft Card', 'Registration 1917'),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Life Timeline (Full Width)
                GlassCard(
                  borderRadius: 16,
                  padding: const EdgeInsets.all(20),
                  backgroundColor: const Color(0x991E1E23),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(0.2), // was emerald
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.timeline, color: Colors.teal, size: 20), // was emerald
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'LIFE TIMELINE',
                            style: GoogleFonts.publicSans(
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.9),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Stack(
                        children: [
                          Positioned(
                            left: 12,
                            top: 8,
                            bottom: 8,
                            width: 2,
                            child: Container(color: Colors.white.withOpacity(0.1)),
                          ),
                          Column(
                            children: [
                              _buildTimelineEvent('1892', 'Born in Birmingham', 'United Kingdom', Colors.teal), // was emerald
                              const SizedBox(height: 24),
                              _buildTimelineEvent('1910', 'Immigrated to New York', 'Ellis Island Records', AppTheme.primary),
                              const SizedBox(height: 24),
                              _buildTimelineEvent('1954', 'Died in Chicago', 'Illinois', Colors.white60),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Bottom Bento Grid
                Row(
                  children: [
                    Expanded(
                      child: GlassCard(
                        borderRadius: 16,
                        padding: const EdgeInsets.all(16),
                        backgroundColor: const Color(0x991E1E23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.diversity_2, color: Colors.purple, size: 20),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '14',
                              style: GoogleFonts.publicSans(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            Text(
                              'Immediate Kin',
                              style: GoogleFonts.publicSans(fontSize: 12, color: Colors.white60),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 28,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFF1E1E23)),
                                      image: const DecorationImage(
                                        image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuARn8Q5InnpKY3xRIb4_TwUw0p13UZoKJUnxvQRy9i7xBV7elGpzQtCmkptFpxtWre2AmLdifEzHVI1Td2GZormaSKRteESDU0S8AmIQOAgVHhNlaWobe-fNdk_SMQc87_zbrzpacjwghg3md9UKd9WjrUgZmh-QsRd54eWTO1AAbEjYZE52xUhdc6GPQMB6G1lWmVb5cF_HiEIuLZMsFB1aJgJI85iW8ft3yDx2m9F0cPE5DZWqE90uycpBj7nHJuGUJvPgVNCVmY'),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20,
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: const Color(0xFF1E1E23)),
                                        image: const DecorationImage(
                                          image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBAVEN29vQV0bD8a1EDUWXTLAk5btpsOoi7iBYlUPMtMfQtVhrGelyL_qLWDiayXB5Xx7fm1a9xT9teb0vbLOlzMyKbygMy_Qgkp93wpR2VhG4m0fKP9Oxc01gyhsnIJCgM-IBiHLbsr27NpHtBZyfxqstG6pNxhTBg9Q10LCLuE6rY5dHSkXhwEIVDm98hKGdUKIrMuRuHYCDOfPoV9MaNAZNkXnLMw4EL42QEgOhBbVS5CXoT4qOJ_MUksoJpQVsjrjcUTM3Jjpo'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 40,
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: const Color(0xFF1E1E23)),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '+12',
                                          style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GlassCard(
                        borderRadius: 16,
                        padding: const EdgeInsets.all(16),
                        backgroundColor: const Color(0x991E1E23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: NetworkImage('https://placeholder.pics/svg/300'),
                                  fit: BoxFit.cover,
                                  opacity: 0.6,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.public, color: Colors.blue, size: 20),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Migration Map',
                              style: GoogleFonts.publicSans(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Floating Tab Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0x991E1E23), // glass-card
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 30, offset: const Offset(0, 4)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.home, color: Colors.grey),
                      const Icon(Icons.search, color: Colors.grey),
                      Container(
                        width: 56,
                        height: 56,
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF0F0F12), width: 4),
                          boxShadow: const [BoxShadow(color: Color(0x801173D4), blurRadius: 15)],
                        ),
                        child: const Icon(Icons.history_edu, color: Colors.white, size: 28), // was family_history
                      ),
                      const Icon(Icons.person, color: Colors.white),
                      const Icon(Icons.settings, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOriginPill(IconData icon, Color color, String flagUrl) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.network(flagUrl, width: 16, height: 12, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, {required bool isPrimary}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isPrimary ? AppTheme.primary : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isPrimary ? AppTheme.primary : Colors.white.withOpacity(0.1)),
        boxShadow: isPrimary ? [BoxShadow(color: AppTheme.primary.withOpacity(0.2), blurRadius: 10)] : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.publicSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordItem(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(icon, color: Colors.white70, size: 18),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.publicSans(fontSize: 14, fontWeight: FontWeight.w500)),
                  Text(subtitle, style: GoogleFonts.publicSans(fontSize: 10, color: Colors.white54)),
                ],
              ),
            ],
          ),
          Icon(Icons.verified, color: AppTheme.primary, size: 18),
        ],
      ),
    );
  }

  Widget _buildTimelineEvent(String year, String title, String subtitle, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 6, right: 16, top: 2), // Adjust alignment
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1E1E23), width: 2),
                boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 10)],
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(year, style: GoogleFonts.publicSans(fontSize: 12, fontWeight: FontWeight.bold, color: color, letterSpacing: 1.0)),
              Text(title, style: GoogleFonts.publicSans(fontSize: 14, fontWeight: FontWeight.w500)),
              Text(subtitle, style: GoogleFonts.publicSans(fontSize: 12, color: Colors.white54)),
            ],
          ),
        ),
      ],
    );
  }
}
