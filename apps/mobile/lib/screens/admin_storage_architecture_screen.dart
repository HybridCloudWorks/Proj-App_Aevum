import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminStorageArchitectureScreen extends StatelessWidget {
  const AdminStorageArchitectureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D121D),
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
              "Storage Architecture",
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "YOUR DATA, YOUR BUCKET",
              style: GoogleFonts.manrope(
                fontSize: 10,
                color: Colors.white24,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.help_outline,
              color: Colors.white24,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildViewTabs(),
            const SizedBox(height: 32),
            _buildBucketStatus(),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "DIRECTORY HIERARCHY",
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: Colors.white24,
                    letterSpacing: 1,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1173d4).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Write Access",
                    style: GoogleFonts.manrope(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1173d4),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildHierarchyList(),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildObjectPreview()),
                const SizedBox(width: 16),
                Expanded(child: _buildSidecarJson()),
              ],
            ),
            const SizedBox(height: 32),
            _buildVerifyButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildViewTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(child: _tab("Logical View", false)),
          Expanded(
            child: _tab("Physical View", true, icon: Icons.storage_rounded),
          ),
        ],
      ),
    );
  }

  Widget _tab(String label, bool isActive, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF1173d4).withValues(alpha: 0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isActive
            ? Border.all(color: const Color(0xFF1173d4).withValues(alpha: 0.5))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : Colors.white38,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBucketStatus() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "CONNECTED",
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF10B981),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AWS S3 Bucket",
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "us-east-1 • aevum-user-8823",
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      color: Colors.white24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.cloud_queue,
                  color: Color(0xFF10B981),
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Storage Used",
                style: GoogleFonts.manrope(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white30,
                ),
              ),
              Text(
                "45.2 GB / ∞",
                style: GoogleFonts.manrope(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.2,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation(Color(0xFF1173d4)),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHierarchyList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _hierarchyItem(
            Icons.folder,
            "2024",
            "Root Year Folder",
            "drwxr-xr-x",
          ),
          _hierarchyItem(
            Icons.folder_shared,
            "Wedding_Anniversary",
            "Event",
            "drwxr-xr-x",
            indent: 1,
          ),
          _hierarchyItem(
            Icons.person_pin,
            "Person_John_Doe",
            "Unique Entity ID",
            "drwxr-xr-x",
            indent: 2,
          ),
          _hierarchyItem(
            Icons.image,
            "IMG_4420.heic",
            "Target Object",
            "6.2MB",
            indent: 3,
            isSelected: true,
          ),
        ],
      ),
    );
  }

  Widget _hierarchyItem(
    IconData icon,
    String title,
    String sub,
    String perm, {
    int indent = 0,
    bool isSelected = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF1173d4).withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(width: indent * 16),
          Icon(
            icon,
            color: isSelected ? const Color(0xFF1173d4) : Colors.white24,
            size: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  sub,
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    color: Colors.white24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            perm,
            style: GoogleFonts.firaCode(
              fontSize: 9,
              color: Colors.white10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObjectPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.white24,
              size: 14,
            ),
            const SizedBox(width: 8),
            Text(
              "OBJECT PREVIEW",
              style: GoogleFonts.manrope(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: Colors.white24,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(24),
            image: const DecorationImage(
              image: NetworkImage(
                "https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=400",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "HEIC",
              style: GoogleFonts.firaCode(
                fontSize: 9,
                color: Colors.white10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "4032 x 3024",
              style: GoogleFonts.firaCode(
                fontSize: 9,
                color: Colors.white10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSidecarJson() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.code, color: Color(0xFF1173d4), size: 14),
                const SizedBox(width: 8),
                Text(
                  "SIDECAR.JSON",
                  style: GoogleFonts.manrope(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1173d4),
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFF1173d4),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 160,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white10),
          ),
          child: SingleChildScrollView(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.firaCode(fontSize: 9, height: 1.5),
                children: const [
                  TextSpan(
                    text: "1  { \"event\":\n",
                    style: TextStyle(color: Colors.white24),
                  ),
                  TextSpan(
                    text: "2    \"Wedding\",\n",
                    style: TextStyle(color: Color(0xFF10B981)),
                  ),
                  TextSpan(
                    text: "3    \"people\": [\n",
                    style: TextStyle(color: Colors.white24),
                  ),
                  TextSpan(
                    text: "4    \"John\", \"Sarah\"\n",
                    style: TextStyle(color: Color(0xFF10B981)),
                  ),
                  TextSpan(
                    text: "5    ],\n",
                    style: TextStyle(color: Colors.white24),
                  ),
                  TextSpan(
                    text: "6    \"date\": \"1962\"\n",
                    style: TextStyle(color: Color(0xFF10B981)),
                  ),
                  TextSpan(
                    text: "7  }",
                    style: TextStyle(color: Colors.white24),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "JSON",
              style: GoogleFonts.firaCode(
                fontSize: 9,
                color: Colors.white10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Portable",
              style: GoogleFonts.firaCode(
                fontSize: 9,
                color: Colors.white10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVerifyButton() {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color: const Color(0xFF1173d4),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1173d4).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.verified_user, color: Colors.white, size: 20),
          const SizedBox(width: 12),
          Text(
            "Verify Integrity & Export",
            style: GoogleFonts.manrope(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}


