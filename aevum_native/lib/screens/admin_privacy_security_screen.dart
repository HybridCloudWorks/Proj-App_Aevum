import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPrivacySecurityScreen extends StatelessWidget {
  const AdminPrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111420),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Privacy & Security",
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Save",
              style: GoogleFonts.manrope(
                color: const Color(0xFF1173d4),
                fontWeight: FontWeight.w900,
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
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildSmallToggleCard(
                    "Biometric Vault",
                    "Secure with FaceID",
                    Icons.face_unlock_outlined,
                    true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSmallStatusCard(
                    "2-Step Verification",
                    "Added security layer",
                    Icons.verified_user_sharp,
                    "Active",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildExportCard(),
            const SizedBox(height: 32),
            Row(
              children: [
                const Icon(Icons.visibility, color: Colors.white24, size: 20),
                const SizedBox(width: 12),
                Text(
                  "Personal Visibility",
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildVisibilityList(),
            const SizedBox(height: 32),
            Row(
              children: [
                const Icon(
                  Icons.notifications_active,
                  color: Colors.white24,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  "Alert Preferences",
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildAlertCard(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSmallToggleCard(
    String title,
    String sub,
    IconData icon,
    bool val,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1173d4).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: const Color(0xFF1173d4), size: 18),
              ),
              Switch(
                value: val,
                onChanged: (v) {},
                activeColor: const Color(0xFF1173d4),
                scale: 0.8,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Text(
            sub,
            style: GoogleFonts.manrope(
              fontSize: 10,
              color: Colors.white38,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallStatusCard(
    String title,
    String sub,
    IconData icon,
    String status,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: const Color(0xFF10B981), size: 18),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.manrope(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Text(
            sub,
            style: GoogleFonts.manrope(
              fontSize: 10,
              color: Colors.white38,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.folder_zip_outlined, color: Colors.white38),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Genealogy Archive",
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Export GEDCOM data",
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: Colors.white24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1173d4),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              "Export",
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisibilityList() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          _visibilityItem(
            Icons.group_rounded,
            "Immediate Family",
            "Parents, Siblings, Children",
            true,
          ),
          _visibilityItem(
            Icons.groups_outlined,
            "Extended Family",
            "Cousins, Aunts, Uncles",
            false,
          ),
          _visibilityItem(
            Icons.public_off,
            "Public",
            "Strangers, Search Engines",
            false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _visibilityItem(
    IconData icon,
    String title,
    String sub,
    bool isSelected, {
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor(title).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor(title), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  sub,
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    color: Colors.white24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFF1173d4) : Colors.white24,
                width: 2,
              ),
            ),
            padding: const EdgeInsets.all(4),
            child: isSelected
                ? Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF1173d4),
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }

  Color iconColor(String title) {
    if (title.contains("Immediate")) return const Color(0xFF1173d4);
    if (title.contains("Extended")) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  Widget _buildAlertCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DNA Matches",
                style: GoogleFonts.manrope(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "New genetic relatives found",
                style: GoogleFonts.manrope(
                  fontSize: 11,
                  color: Colors.white24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Switch(
            value: true,
            onChanged: (v) {},
            activeColor: const Color(0xFF1173d4),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFF070B14),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(Icons.account_tree_outlined, "Tree", false),
          _navItem(Icons.search, "Search", false),
          _navItem(Icons.email_outlined, "Inbox", false),
          _navItem(Icons.person, "Profile", true),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF1173d4) : Colors.white24,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: isActive ? const Color(0xFF1173d4) : Colors.white24,
          ),
        ),
      ],
    );
  }
}
