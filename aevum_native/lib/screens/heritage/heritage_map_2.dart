import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../widgets/glass_card.dart';
import '../../theme/app_theme.dart';

class HeritageMap2 extends StatefulWidget {
  const HeritageMap2({Key? key}) : super(key: key);

  @override
  State<HeritageMap2> createState() => _HeritageMap2State();
}

class _HeritageMap2State extends State<HeritageMap2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          // Mesh Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.2,
                colors: [Color(0xFF1E1B4B), Color(0xFF0F172A)],
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Family Messenger',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            'Connect with your lineage',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                      GlassCard(
                        borderRadius: 999,
                        padding: const EdgeInsets.all(8),
                        backgroundColor: const Color(0xB31E293B),
                        child: Stack(
                          children: [
                            const Icon(Icons.notifications, color: Colors.grey, size: 24),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: const Color(0xFF101922)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 120),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),

                        // Family Branches Header
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'FAMILY BRANCHES',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[200],
                                  letterSpacing: 1.0,
                                ),
                              ),
                              Text(
                                'View All',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Branches List
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              _buildBranchCard('R', 'Ricci\nBranch', '12 Active Members', [Colors.indigo, AppTheme.primary], isActive: true),
                              const SizedBox(width: 12),
                              _buildBranchCard('S', 'Smith\nBranch', '5 Active Members', [Colors.teal, Colors.tealAccent], isActive: false, isLimited: true),
                              const SizedBox(width: 12),
                              _buildBranchCard('C', 'Chen\nBranch', '8 Active Members', [Colors.orange, Colors.amber], isActive: false, isLimited: true),
                              const SizedBox(width: 12),
                              _buildAddBranchCard(),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Recent Chats Header
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'RECENT CHATS',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[200],
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Chats List
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              _buildChatCard(
                                'Elena Ricci',
                                'Found the old photo albums in the attic!',
                                '2m ago',
                                'Direct Family',
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuCvrfWGXR_NSzBzI-JasKOidA7kNnec1xEo-F4tEKONh3BnnTTr9SujMk86VlGSW4a0huOIl6C2-R1sS-MsjiTawJGTP61ugi0m18NTYSVhw1RJ9WNIJ5KkZ9reDqFDL3lPIx5tKg3TLO33-8ZkodDYfpah3gEaa5hVhIdnFEgox0Tsbk7Ueci3-w1ulBfXeGCvrzfXdA3U2ehwlnXybAw7RQA8mrOAQPZeMGma_1gywJx1ghseyqQpyiletZuSh3Q4hQ5LA5j3Gjk',
                                isNew: true,
                                isOnline: true,
                              ),
                              const SizedBox(height: 12),
                              _buildChatCard(
                                'Ricci Family Global',
                                'Marco: Who\'s bringing the wine for the reunion?',
                                '1h ago',
                                'Direct Family',
                                null,
                                icon: Icons.diversity_3,
                                color: Colors.blue,
                              ),
                              const SizedBox(height: 12),
                              _buildChatCard(
                                'Marco Ricci',
                                'Did you see the update to the family tree?',
                                '3h ago',
                                'Direct Family',
                                null,
                                initials: 'MR',
                                color: Colors.orange,
                              ),
                              const SizedBox(height: 12),
                              _buildChatCard(
                                'Sarah Smith',
                                'Sent a request to view the archives.',
                                'Yesterday',
                                'Extended',
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuCcPMHZe7pihuDC5a1Ab23u52UektHv1tziZdoknIH6xx0WN3z71zNmLVdb1d_tRYkuxnnGDZpOwQp2juuCCakBuRSWjSGuLqPoF7Prb-Hm3AbibIn1J39HzeYV9NOJ8bMG4oShj8sgbjU3m5xCUe_RURkKEkxgqLG7NSqmtBEql701G8VrT9PjHRA8cTOxE4mqWflN0bOs3SsQwt0-hc6AyYTnFsHdUGEjO1HDl6fK613ZVMwJCUAb8sF6jzfwHqFp_cTPg_zr90w',
                                isExtended: true,
                                isGrayscale: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Floating Action Button
          Positioned(
            bottom: 100,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.lock_open, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Request Access',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Nav
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xE6101922),
                border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.home, 'Home'),
                      _buildNavItem(Icons.chat_bubble, 'Messages', isActive: true),
                      _buildNavItem(Icons.folder_open, 'Vault'),
                      _buildNavItem(Icons.settings, 'Config'),
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

  Widget _buildBranchCard(String initial, String name, String members, List<Color> colors, {bool isActive = false, bool isLimited = false}) {
    return GlassCard(
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      backgroundColor: isActive ? const Color(0x401173D4) : Colors.white.withOpacity(0.03),
      borderColor: isActive ? AppTheme.primary.withOpacity(0.4) : Colors.white.withOpacity(0.12),
      child: Container(
        width: 144, // w-36
        height: 176, // h-44
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    initial,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (isActive)
                  Column(
                    children: [
                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.green, blurRadius: 8)])),
                      const SizedBox(height: 4),
                      const Icon(Icons.verified_user, color: Colors.green, size: 16),
                    ],
                  )
                else
                  const Icon(Icons.gpp_maybe, color: Colors.amber, size: 16),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: (isLimited ? Colors.amber : Colors.teal).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: (isLimited ? Colors.amber : Colors.teal).withOpacity(0.3)),
                  ),
                  child: Text(
                    isLimited ? 'LIMITED' : 'FULL ACCESS',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: isLimited ? Colors.amber : Colors.tealAccent,
                    ),
                  ),
                ),
                Text(
                  name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  members,
                  style: GoogleFonts.plusJakartaSans(
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
    );
  }

  Widget _buildAddBranchCard() {
    return GlassCard(
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      backgroundColor: Colors.white.withOpacity(0.08),
      child: Container(
        width: 144,
        height: 176,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Join New\nBranch',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatCard(String title, String message, String time, String badge, String? imageUrl, {bool isNew = false, bool isOnline = false, IconData? icon, Color? color, String? initials, bool isExtended = false, bool isGrayscale = false}) {
    return GlassCard(
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      backgroundColor: isNew ? const Color(0x401173D4) : Colors.white.withOpacity(0.03), // glow-new-message simulation
      borderColor: isNew ? AppTheme.primary.withOpacity(0.6) : Colors.white.withOpacity(0.12),
      child: Stack(
        children: [
          if (isNew)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF0EA5E9),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('NEW', style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: color != null ? LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [color.withOpacity(0.8), color]) : null,
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: imageUrl != null
                        ? ClipOval(
                            child: ColorFiltered(
                              colorFilter: isGrayscale ? const ColorFilter.mode(Colors.grey, BlendMode.saturation) : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                              child: Image.network(imageUrl, fit: BoxFit.cover),
                            ),
                          )
                        : (icon != null
                            ? Icon(icon, color: Colors.white, size: 24)
                            : Center(child: Text(initials!, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)))),
                  ),
                  if (isOnline)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF101922), width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  title,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isExtended ? Colors.grey[200] : Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (isExtended ? const Color(0xFF0EA5E9) : Colors.green).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: (isExtended ? const Color(0xFF0EA5E9) : Colors.green).withOpacity(0.3)),
                                ),
                                child: Text(
                                  badge.toUpperCase(),
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: isExtended ? const Color(0xFF7DD3FC) : const Color(0xFF4ADE80),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isNew)
                          Text(
                            time,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isNew ? const Color(0xFF0EA5E9) : Colors.grey[400],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: Text(
                        message,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[300],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isActive) ...[
          Container(
            width: 48,
            height: 4,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.8), blurRadius: 10)],
            ),
          ),
          Icon(icon, color: AppTheme.primary, size: 24),
          Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primary)),
        ] else ...[
          const SizedBox(height: 12),
          Icon(icon, color: Colors.grey[400], size: 24),
          Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.grey[400])),
        ],
      ],
    );
  }
}
