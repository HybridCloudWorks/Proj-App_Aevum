import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminRoleManagementScreen extends StatelessWidget {
  const AdminRoleManagementScreen({super.key});

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
        title: Column(
          children: [
            Text(
              "Admin Delegation",
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Manage tree edit permissions",
              style: GoogleFonts.manrope(fontSize: 11, color: Colors.white38),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Save",
              style: GoogleFonts.manrope(
                color: const Color(0xFF1173d4),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildSearchBar(),
            const SizedBox(height: 24),
            _buildOwnerCard(),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _roleInfoCard(
                    "ADMINS CAN",
                    ["Approve Marriages", "Verify Siblings"],
                    Icons.verified_user,
                    const Color(0xFF1173d4),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _roleInfoCard(
                    "OWNER ONLY",
                    ["Vault Access", "Out-of-wedlock"],
                    Icons.lock,
                    Colors.orangeAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildFamilyMembersList(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        style: GoogleFonts.manrope(color: Colors.white),
        decoration: InputDecoration(
          icon: const Icon(Icons.search, color: Colors.white38, size: 20),
          hintText: "Search family members...",
          hintStyle: GoogleFonts.manrope(color: Colors.white38, fontSize: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildOwnerCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1173d4),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shield,
                    color: Colors.white,
                    size: 12,
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
                Text(
                  "Me (Tree Owner)",
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Full Authority",
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: const Color(0xFF1173d4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Owner of AevumLegacy #8291",
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    color: Colors.white24,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.security_rounded,
            color: Colors.white.withOpacity(0.05),
            size: 48,
          ),
        ],
      ),
    );
  }

  Widget _roleInfoCard(
    String title,
    List<String> items,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: color,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: color, size: 12),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildFamilyMembersList() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Family Members",
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 14),
              label: Text(
                "INVITE NEW",
                style: GoogleFonts.manrope(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF1173d4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _memberTile(
          "Sarah Miller",
          "Cousin • Joined 2021",
          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100",
          true,
          isAdmin: true,
        ),
        _memberTile(
          "Uncle Joe",
          "Uncle • Joined 2020",
          "https://images.unsplash.com/photo-1463453091185-61582044d556?w=100",
          false,
        ),
        _memberTile(
          "Marcus Ray",
          "Brother • Joined 2022",
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
          true,
          isAdmin: true,
        ),
        _memberTile(
          "Emily Chen",
          "Spouse • Joined 2019",
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100",
          false,
        ),
      ],
    );
  }

  Widget _memberTile(
    String name,
    String sub,
    String url,
    bool isActive, {
    bool isAdmin = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(url), radius: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      sub,
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        color: Colors.white38,
                      ),
                    ),
                    if (isAdmin) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1173d4).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "ADMIN",
                          style: GoogleFonts.manrope(
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF1173d4),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Switch(
            value: isActive,
            onChanged: (v) {},
            activeColor: const Color(0xFF1173d4),
          ),
        ],
      ),
    );
  }
}
