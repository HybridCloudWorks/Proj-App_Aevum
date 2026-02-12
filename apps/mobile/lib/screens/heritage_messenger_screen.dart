import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeritageMessengerScreen extends StatelessWidget {
  const HeritageMessengerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Mesh Gradient Background
          _buildMeshGradient(),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    children: [
                      _buildBranchSection(),
                      const SizedBox(height: 32),
                      _buildRecentChatsSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Floating Action Button
          _buildFAB(),

          // Bottom Navigation
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildMeshGradient() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(color: Color(0xFF101922)),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF1173D4).withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF0EA5E9).withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Family Messenger',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white10),
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Connect with your lineage',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white60,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBranchSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FAMILY BRANCHES',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white38,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'View All',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF1173D4),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              _buildBranchCard(
                title: 'Ricci\nBranch',
                initial: 'R',
                members: 12,
                isActive: true,
                accessLevel: 'Full Access',
                gradientColors: [
                  const Color(0xFF4F46E5),
                  const Color(0xFF1173D4),
                ],
              ),
              const SizedBox(width: 12),
              _buildBranchCard(
                title: 'Smith\nBranch',
                initial: 'S',
                members: 5,
                isActive: false,
                accessLevel: 'Limited',
                gradientColors: [
                  const Color(0xFF10B981),
                  const Color(0xFF0D9488),
                ],
              ),
              const SizedBox(width: 12),
              _buildBranchCard(
                title: 'Chen\nBranch',
                initial: 'C',
                members: 8,
                isActive: false,
                accessLevel: 'Limited',
                gradientColors: [
                  const Color(0xFFF59E0B),
                  const Color(0xFFD97706),
                ],
              ),
              const SizedBox(width: 12),
              _buildAddBranchCard(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBranchCard({
    required String title,
    required String initial,
    required int members,
    required bool isActive,
    required String accessLevel,
    required List<Color> gradientColors,
  }) {
    return Container(
      width: 144,
      height: 176,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? const Color(0x1A1173D4) : const Color(0xCC1E293B),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isActive
              ? const Color(0x661173D4)
              : Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColors),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[0].withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    initial,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (isActive)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF22C55E),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Color(0x8022C55E), blurRadius: 4),
                    ],
                  ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color:
                      (accessLevel == 'Full Access'
                              ? const Color(0xFF10B981)
                              : const Color(0xFFF59E0B))
                          .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color:
                        (accessLevel == 'Full Access'
                                ? const Color(0xFF10B981)
                                : const Color(0xFFF59E0B))
                            .withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  accessLevel.toUpperCase(),
                  style: GoogleFonts.plusJakartaSans(
                    color: (accessLevel == 'Full Access'
                        ? const Color(0xFF10B981)
                        : const Color(0xFFF59E0B)),
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$members Active Members',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white38,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddBranchCard() {
    return Container(
      width: 144,
      height: 176,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white10,
          style: BorderStyle.solid,
        ), // Simplified, should be dashed
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white38),
          ),
          const SizedBox(height: 12),
          Text(
            'Join New\nBranch',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white38,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentChatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16),
          child: Text(
            'RECENT CHATS',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white38,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        _buildChatTile(
          name: 'Elena Ricci',
          message: 'Found the old photo albums in the attic!',
          time: '2m ago',
          isNew: true,
          imageUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCvrfWGXR_NSzBzI-JasKOidA7kNnec1xEo-F4tEKONh3BnnTTr9SujMk86VlGSW4a0huOIl6C2-R1sS-MsjiTawJGTP61ugi0m18NTYSVhw1RJ9WNIJ5KkZ9reDqFDL3lPIx5tKg3TLO33-8ZkodDYfpah3gEaa5hVhIdnFEgox0Tsbk7Ueci3-w1ulBfXeGCvrzfXdA3U2ehwlnXybAw7RQA8mrOAQPZeMGma_1gywJx1ghseyqQpyiletZuSh3Q4hQ5LA5j3Gjk',
        ),
        _buildChatTile(
          name: 'Ricci Family Global',
          message: 'Marco: Who\'s bringing the wine for the reunion?',
          time: '1h ago',
          isGroup: true,
        ),
        _buildChatTile(
          name: 'Marco Ricci',
          message: 'Did you see the update to the family tree?',
          time: '3h ago',
          initials: 'MR',
          avatarColor: const Color(0xFFF97316),
        ),
      ],
    );
  }

  Widget _buildChatTile({
    required String name,
    required String message,
    required String time,
    bool isNew = false,
    bool isGroup = false,
    String? imageUrl,
    String? initials,
    Color? avatarColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isNew
              ? const Color(0x1A0EA5E9)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isNew
                ? const Color(0x660EA5E9)
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: avatarColor ?? Colors.white10,
                    image: imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: imageUrl == null
                      ? Center(
                          child: Icon(
                            isGroup ? Icons.diversity_3 : Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                        )
                      : null,
                ),
                if (isNew)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF101922),
                          width: 2,
                        ),
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
                      Row(
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildTag(isGroup ? 'Group' : 'Direct Family'),
                        ],
                      ),
                      Text(
                        time,
                        style: GoogleFonts.plusJakartaSans(
                          color: isNew
                              ? const Color(0xFF0EA5E9)
                              : Colors.white38,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.plusJakartaSans(
          color: const Color(0xFF10B981),
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return Positioned(
      bottom: 110,
      right: 24,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1173D4).withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1173D4).withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Upload Memories',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF101922).withValues(alpha: 0.9),
              border: const Border(top: BorderSide(color: Colors.white10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(Icons.home_outlined, 'Home', false),
                _buildNavItem(Icons.chat_bubble_rounded, 'Messages', true),
                _buildNavItem(Icons.folder_open_outlined, 'Vault', false),
                _buildNavItem(Icons.settings_outlined, 'Config', false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF1173D4) : Colors.white38,
          size: 26,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: isActive ? const Color(0xFF1173D4) : Colors.white38,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}


