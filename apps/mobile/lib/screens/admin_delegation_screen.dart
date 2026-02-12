import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDelegationScreen extends StatefulWidget {
  const AdminDelegationScreen({super.key});

  @override
  State<AdminDelegationScreen> createState() => _AdminDelegationScreenState();
}

class _AdminDelegationScreenState extends State<AdminDelegationScreen> {
  final List<Map<String, dynamic>> _members = [
    {
      "name": "Sarah Miller",
      "relation": "Cousin • Joined 2021",
      "isAdmin": true,
      "url": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100",
    },
    {
      "name": "Uncle Joe",
      "relation": "Uncle • Joined 2020",
      "isAdmin": false,
      "url":
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
    },
    {
      "name": "Marcus Ray",
      "relation": "Brother • Joined 2022",
      "isAdmin": true,
      "url":
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
    },
    {
      "name": "Emily Chen",
      "relation": "Spouse • Joined 2019",
      "isAdmin": false,
      "url":
          "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=100",
    },
  ];

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
              style: GoogleFonts.manrope(fontSize: 11, color: Colors.white54),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildSearchBar(),
            const SizedBox(height: 24),
            _buildOwnerCard(),
            const SizedBox(height: 24),
            _buildRoleSummary(),
            const SizedBox(height: 32),
            _buildSectionHeader("Family Members"),
            const SizedBox(height: 16),
            ..._members.map((m) => _buildMemberTile(m)).toList(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
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
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100",
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
                    Icons.verified,
                    color: Colors.white,
                    size: 14,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Full Authority",
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    color: const Color(0xFF1173d4),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Owner of Aevum Legacy #8291",
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.shield,
            color: Colors.white.withValues(alpha: 0.1),
            size: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSummary() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          _roleHeader(Icons.security, "Role Summary", Colors.blue),
          const SizedBox(height: 24),
          _roleItem(Icons.stars, "Tree Owner", [
            "Full Vault Access",
            "Out-of-wedlock ID",
            "Tree Pruning",
          ], active: true),
          const Divider(height: 48, color: Colors.white10),
          _roleItem(Icons.cloud_circle, "Tree Admin", [
            "Approve Marriage Links",
            "Verify Sibling Links",
            "Cannot Delete Nodes",
          ], active: false),
        ],
      ),
    );
  }

  Widget _roleHeader(IconData icon, String title, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _roleItem(
    IconData icon,
    String title,
    List<String> permissions, {
    required bool active,
  }) {
    return Opacity(
      opacity: active ? 1.0 : 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: active ? Colors.orangeAccent : Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              children: permissions
                  .map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            active
                                ? Icons.lock
                                : (p.startsWith("Cannot")
                                      ? Icons.block
                                      : Icons.check_circle),
                            size: 14,
                            color: active
                                ? Colors.blueAccent
                                : (p.startsWith("Cannot")
                                      ? Colors.redAccent
                                      : Colors.greenAccent),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            p,
                            style: GoogleFonts.manrope(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          style: TextButton.styleFrom(foregroundColor: const Color(0xFF1173d4)),
        ),
      ],
    );
  }

  Widget _buildMemberTile(Map<String, dynamic> member) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(member['url']),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member['name'],
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  member['relation'],
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    color: Colors.white38,
                  ),
                ),
                if (member['isAdmin']) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1173d4).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "ADMIN",
                      style: GoogleFonts.manrope(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1173d4),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Switch(
            value: member['isAdmin'],
            onChanged: (val) {
              setState(() {
                member['isAdmin'] = val;
              });
            },
            activeThumbColor: const Color(0xFF1173d4),
            activeTrackColor: const Color(0xFF1173d4).withValues(alpha: 0.2),
            inactiveThumbColor: Colors.white24,
            inactiveTrackColor: Colors.white10,
          ),
        ],
      ),
    );
  }
}


