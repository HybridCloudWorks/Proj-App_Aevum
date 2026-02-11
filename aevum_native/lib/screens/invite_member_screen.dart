import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class InviteMemberScreen extends StatelessWidget {
  const InviteMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F151B),
      body: Stack(
        children: [
          _buildMeshBackground(),
          _buildAppBar(context),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildInviteCard(),
                  const SizedBox(height: 120), // Bottom nav spacer
                ],
              ),
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildMeshBackground() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [Color(0xFF1E1B4B), Colors.transparent],
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _circleIconButton(
            Icons.arrow_back_ios_new,
            () => Navigator.pop(context),
          ),
          _circleIconButton(Icons.help_outline, () {}),
        ],
      ),
    );
  }

  Widget _circleIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          "CONNECT YOUR\nROOTS",
          textAlign: TextAlign.center,
          style: GoogleFonts.cinzel(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2.0,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Expand the Aevum Tree together",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }

  Widget _buildInviteCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              _buildProfilePicker(),
              const SizedBox(height: 12),
              Text(
                "NEW MEMBER",
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Colors.white38,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 32),
              _buildInput("Full Name", "e.g. Sarah Miller", Icons.person),
              const SizedBox(height: 20),
              _buildInput("Email or Phone", "invite@example.com", Icons.mail),
              const SizedBox(height: 20),
              _buildRelationshipDropdown(),
              const SizedBox(height: 32),
              _buildSendButton(),
              const SizedBox(height: 16),
              Text(
                "They will receive an email to join your family tree and contribute photos.",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  color: Colors.white38,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicker() {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white10, width: 4),
            image: const DecorationImage(
              image: NetworkImage(
                "https://lh3.googleusercontent.com/aida-public/AB6AXuCypW0HCtYaKHH0MjMWX5XSsEKnu7uoyRGpXiybm9VCSMSScwMkgC9ez5DGxTI5aZ9R8qtdmEhpP57FWjs1FEoF71D4bCGguhT8QavCYCK0Hq6QmPi5gBbq-toXZJYB2YAyY3ACa7I9D_xT4aNPKnATilfv4r2mIsfkVXaKiuzT4E6wh8xuMRQ2gs1XjSq71o-iw17bRamMPrWJPA1F8-lYYaF3HAZYx3KtIUk3CtH-NetUq8Av_FjlDt-4jo7Pxw5GiiDB9tT_y0w",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add_a_photo, color: Colors.blue, size: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildInput(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white12),
          ),
          child: TextField(
            style: GoogleFonts.manrope(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.white38, size: 20),
              hintText: hint,
              hintStyle: GoogleFonts.manrope(
                color: Colors.white24,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRelationshipDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Relationship to you",
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              const Icon(Icons.family_history, color: Colors.white38, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Choose relationship...",
                  style: GoogleFonts.manrope(
                    color: Colors.white24,
                    fontSize: 14,
                  ),
                ),
              ),
              const Icon(Icons.expand_more, color: Colors.white38),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSendButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Send Invite",
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.send, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Positioned(
      bottom: 24,
      left: 20,
      right: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.photo_library,
                  color: Colors.white38,
                  size: 22,
                ),
                const Icon(Icons.account_tree, color: Colors.white38, size: 22),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person_add,
                    color: Colors.blue,
                    size: 24,
                  ),
                ),
                const Icon(Icons.settings, color: Colors.white38, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
