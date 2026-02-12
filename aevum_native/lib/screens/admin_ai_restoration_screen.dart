import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminAIRestorationScreen extends StatefulWidget {
  const AdminAIRestorationScreen({super.key});

  @override
  State<AdminAIRestorationScreen> createState() =>
      _AdminAIRestorationScreenState();
}

class _AdminAIRestorationScreenState extends State<AdminAIRestorationScreen> {
  double _restorationProgress = 0.85;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1121),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0B1121),
              const Color(0xFF2D1B1B).withOpacity(0.5),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 40),
              _buildRestorationPreview(),
              const Spacer(),
              _buildControlPanel(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          _headerChip(
            Icons.collections,
            "Spatial Gallery",
            const Color(0xFF1173d4),
          ),
          const SizedBox(width: 8),
          _headerChip(
            Icons.auto_fix_high,
            "AI Restoration Active",
            const Color(0xFF10B981),
            hasDot: true,
          ),
        ],
      ),
    );
  }

  Widget _headerChip(
    IconData icon,
    String label,
    Color color, {
    bool hasDot = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          if (hasDot) ...[
            const SizedBox(width: 8),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFF10B981),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRestorationPreview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 480,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              "https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=800",
              fit: BoxFit.cover,
            ),
            // Metadata Overlay
            Positioned(
              top: 24,
              right: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Text(
                  "ISO 400 • f/2.8",
                  style: GoogleFonts.firaCode(
                    fontSize: 10,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Detection Overlay (Circles)
            Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  children: [
                    _circle(60, 60, Colors.white.withOpacity(0.4)),
                    Positioned(
                      top: 10,
                      left: 100,
                      child: _circle(
                        80,
                        80,
                        const Color(0xFFA855F7).withOpacity(0.4),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 80,
                      child: _circle(
                        70,
                        70,
                        const Color(0xFF10B981).withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Gradient Scrim & Titles
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Summer Garden Party",
                      style: GoogleFonts.manrope(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white54,
                          size: 14,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Sussex, England • July 15, 1962",
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(double w, double h, Color borderColor) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Original",
                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      color: Colors.white38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "(1962)",
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Text(
                "Restoration\nProgress",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  color: Colors.white24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Enhanced (2024 AI)",
                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      color: const Color(0xFF1173d4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "ACTIVE",
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF1173d4),
              inactiveTrackColor: Colors.white.withOpacity(0.05),
              thumbColor: Colors.white,
              trackHeight: 2,
            ),
            child: Slider(
              value: _restorationProgress,
              onChanged: (v) => setState(() => _restorationProgress = v),
            ),
          ),
          const SizedBox(height: 40),
          const Divider(color: Colors.white10),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.history, color: Colors.white24, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    "1950s Era",
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      color: Colors.white24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: List.generate(
                  4,
                  (i) => Container(
                    width: i == 2 ? 24 : 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: i == 2 ? Colors.white : Colors.white10,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "1970s Era",
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      color: Colors.white24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white24,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
