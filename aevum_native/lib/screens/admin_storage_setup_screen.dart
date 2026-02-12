import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminStorageSetupScreen extends StatelessWidget {
  const AdminStorageSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1121),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1173d4).withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.folder_copy,
            color: Color(0xFF1173d4),
            size: 18,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Storage Setup",
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Step 2 of 3 • Configuration",
              style: GoogleFonts.manrope(
                fontSize: 10,
                color: const Color(0xFF1173d4),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Help",
              style: GoogleFonts.manrope(color: Colors.white38, fontSize: 13),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              "Your Data, Your Control",
              style: GoogleFonts.manrope(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Choose how you want to store your family's heritage. Aevum is built on a \"Zero-Lock-In\" philosophy.",
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 14,
                color: Colors.white54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 48),
            _buildTierCard("Aevum Managed", "\$29", "Recommended", [
              "Concierge support included",
              "Unlimited high-res AI restoration",
              "Triple-redundant managed storage",
            ], false),
            const SizedBox(height: 20),
            _buildTierCard(
              "Aevum Basic",
              "\$12",
              "BYOB Storage",
              [],
              true,
              child: _buildBYOBConfig(),
            ),
            const SizedBox(height: 32),
            _buildConfirmButton(),
            const SizedBox(height: 20),
            Text(
              "Secure 256-bit encrypted connection",
              style: GoogleFonts.manrope(
                fontSize: 11,
                color: Colors.white10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTierCard(
    String title,
    String price,
    String badge,
    List<String> features,
    bool isActive, {
    Widget? child,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isActive
              ? const Color(0xFF1173d4)
              : Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive
                            ? const Color(0xFF1173d4)
                            : Colors.white24,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: isActive
                        ? Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF1173d4),
                              shape: BoxShape.circle,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.manrope(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          if (isActive)
                            const Icon(
                              Icons.verified,
                              color: Color(0xFF1173d4),
                              size: 12,
                            )
                          else
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF10B981),
                              size: 12,
                            ),
                          const SizedBox(width: 6),
                          Text(
                            badge,
                            style: GoogleFonts.manrope(
                              fontSize: 11,
                              color: isActive
                                  ? const Color(0xFF1173d4)
                                  : const Color(0xFF10B981),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: price,
                      style: GoogleFonts.manrope(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "/mo",
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (features.isNotEmpty) ...[
            const SizedBox(height: 20),
            ...features.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.sync, color: Color(0xFF1173d4), size: 14),
                    const SizedBox(width: 12),
                    Text(
                      f,
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          if (child != null) ...[
            const SizedBox(height: 24),
            const Divider(color: Colors.white10),
            const SizedBox(height: 24),
            child,
          ],
        ],
      ),
    );
  }

  Widget _buildBYOBConfig() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "PROVIDER CREDENTIALS",
              style: GoogleFonts.manrope(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: Colors.white38,
                letterSpacing: 1,
              ),
            ),
            const Icon(Icons.terminal, color: Colors.white24, size: 16),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _providerTab("AWS S3", true),
            const SizedBox(width: 8),
            _providerTab("Azure", false),
            const SizedBox(width: 8),
            _providerTab("GCP", false),
          ],
        ),
        const SizedBox(height: 24),
        _inputField("Bucket Name", "my-family-archive", Icons.folder),
        const SizedBox(height: 16),
        _inputField("Access Key ID", "AKIA....", Icons.key),
        const SizedBox(height: 16),
        _inputField("Secret Access Key", "••••••••••••••••", Icons.lock),
        const SizedBox(height: 16),
        _dropdownField("Region", "us-east-1 (N. Virginia)", Icons.public),
        const SizedBox(height: 20),
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Waiting for credentials...",
              style: GoogleFonts.manrope(
                fontSize: 11,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _providerTab(String name, bool isActive) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF1173d4).withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? const Color(0xFF1173d4) : Colors.white10,
          ),
        ),
        child: Center(
          child: Text(
            name,
            style: GoogleFonts.manrope(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : Colors.white38,
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 11,
            color: Colors.white38,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black26, size: 18),
              const SizedBox(width: 12),
              Text(
                hint,
                style: GoogleFonts.manrope(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dropdownField(String label, String val, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 11,
            color: Colors.white38,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white38, size: 18),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  val,
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white38),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1173d4),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 64),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Confirm Configuration",
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.arrow_forward_rounded, size: 20),
        ],
      ),
    );
  }
}
