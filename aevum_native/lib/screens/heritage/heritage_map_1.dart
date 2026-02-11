import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../widgets/glass_card.dart';
import '../../theme/app_theme.dart';

class HeritageMap1 extends StatefulWidget {
  const HeritageMap1({Key? key}) : super(key: key);

  @override
  State<HeritageMap1> createState() => _HeritageMap1State();
}

class _HeritageMap1State extends State<HeritageMap1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: Stack(
        children: [
          // Mesh Gradient Background (simplified)
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.0,
                colors: [Color(0xFF1E1B4B), Color(0xFF101922)], // Dark blue to dark
              ),
            ),
          ),

          // Main Content
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
                            'Upload Center',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            'Digitize your legacy',
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
                        backgroundColor: const Color(0xB31E293B), // slate-800/85 (approx glass-panel)
                        child: const Icon(Icons.history, color: Colors.grey, size: 24),
                      ),
                    ],
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        // Upload Area
                        Container(
                          height: 192, // h-48
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.1), style: BorderStyle.solid),
                            // Dashed border would be better but requires custom painter. Using solid for now.
                            image: const DecorationImage(
                              image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDefNGMx_L3_FnLpCbvzPX5nNPOjBgiuGAm5za8a161AfwUxWVtGTzDIKPVV6qDMZ3RHRkFeOTfpeEEou7F2obAeB7DrKxELhL4bvzzTjs71TsLM3j6U-uMRgVZLJEdkR7yjLdOeftsDBZekO_RwFODQ85H3AKLqgmsEg-Ag6PEah6HoM1hIahMoVw_dod0xxhZhtl24jmk-n1ArfyLvI-LPedTctTlx6tUQi8D1-ot28UiRGICH0PluJTWuC1c6U3gXDSaewtAB5g'),
                              fit: BoxFit.cover,
                              opacity: 0.2,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xB31E293B), // glass-panel
                                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
                                    ],
                                  ),
                                  child: const Icon(Icons.cloud_upload, color: Color(0xFF0EA5E9), size: 30),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Upload Photos',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Drag & drop or tap to select from your gallery',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // AI Processing Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF0EA5E9), // accent
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'AI PROCESSING',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200],
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '2 items remaining',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0EA5E9),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Processing Card
                        GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(16),
                          backgroundColor: const Color(0x261173D4), // glass-panel-active (blue tint)
                          borderColor: const Color(0x661173D4),
                          child: Row(
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0x4D0EA5E9)),
                                  image: const DecorationImage(
                                    image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCvrfWGXR_NSzBzI-JasKOidA7kNnec1xEo-F4tEKONh3BnnTTr9SujMk86VlGSW4a0huOIl6C2-R1sS-MsjiTawJGTP61ugi0m18NTYSVhw1RJ9WNIJ5KkZ9reDqFDL3lPIx5tKg3TLO33-8ZkodDYfpah3gEaa5hVhIdnFEgox0Tsbk7Ueci3-w1ulBfXeGCvrzfXdA3U2ehwlnXybAw7RQA8mrOAQPZeMGma_1gywJx1ghseyqQpyiletZuSh3Q4hQ5LA5j3Gjk'),
                                    fit: BoxFit.cover,
                                    opacity: 0.8,
                                  ),
                                ),
                                // Scanner line animation requires AnimationController, skipping for static baseline
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Scanning in Progress',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '67%',
                                          style: GoogleFonts.robotoMono(
                                            fontSize: 12,
                                            color: const Color(0xFF0EA5E9),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(999),
                                      child: LinearProgressIndicator(
                                        value: 0.67,
                                        backgroundColor: Colors.grey[700]!.withOpacity(0.5),
                                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0EA5E9)),
                                        minHeight: 6,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Analyzing pixel density & color grading...',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 10,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Metadata & Face ID Grid
                        Row(
                          children: [
                            Expanded(
                              child: GlassCard(
                                borderRadius: 16,
                                padding: const EdgeInsets.all(16),
                                backgroundColor: const Color(0xB31E293B),
                                child: SizedBox(
                                  height: 128, // h-32
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Colors.indigo.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.indigo.withOpacity(0.3)),
                                        ),
                                        child: const Icon(Icons.data_object, color: Colors.indigoAccent, size: 18),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.check_circle, color: Colors.green, size: 14),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Metadata',
                                                style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[200],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Date: 1984-05-12\nLoc: Tuscany, IT',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 10,
                                              color: Colors.grey[400],
                                              height: 1.4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GlassCard(
                                borderRadius: 16,
                                padding: const EdgeInsets.all(16),
                                backgroundColor: const Color(0xB31E293B),
                                child: SizedBox(
                                  height: 128,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Colors.pink.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.pink.withOpacity(0.3)),
                                        ),
                                        child: const Icon(Icons.face_retouching_natural, color: Colors.pinkAccent, size: 18),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // Spinner placeholder
                                              Container(width: 12, height: 12, margin: const EdgeInsets.only(right: 4), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.pink, width: 2))),
                                              Text(
                                                'Face ID',
                                                style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[200],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            height: 20,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: Colors.grey[800]!),
                                                    image: const DecorationImage(image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCcPMHZe7pihuDC5a1Ab23u52UektHv1tziZdoknIH6xx0WN3z71zNmLVdb1d_tRYkuxnnGDZpOwQp2juuCCakBuRSWjSGuLqPoF7Prb-Hm3AbibIn1J39HzeYV9NOJ8bMG4oShj8sgbjU3m5xCUe_RURkKEkxgqLG7NSqmtBEql701G8VrT9PjHRA8cTOxE4mqWflN0bOs3SsQwt0-hc6AyYTnFsHdUGEjO1HDl6fK613ZVMwJCUAb8sF6jzfwHqFp_cTPg_zr90w')),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 14,
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[700],
                                                      shape: BoxShape.circle,
                                                      border: Border.all(color: Colors.grey[800]!),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text('+2', style: GoogleFonts.plusJakartaSans(fontSize: 8, color: Colors.grey[300])),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Target Branch
                        Text(
                          'TARGET BRANCH',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[200],
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(4),
                          backgroundColor: const Color(0xB31E293B),
                          child: Column(
                            children: [
                              // Ricci Branch (Selected)
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(colors: [Colors.indigo, Color(0xFF1173d4)]),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'R',
                                            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Ricci Branch',
                                              style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                            Text(
                                              'Primary Lineage',
                                              style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.grey[400]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.radio_button_checked, color: Color(0xFF1173d4)),
                                  ],
                                ),
                              ),
                              // Smith Branch (Unselected)
                              Container(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(colors: [Colors.tealAccent, Colors.teal]),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'S',
                                            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Smith Branch',
                                              style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[300]),
                                            ),
                                            Text(
                                              'Maternal Side',
                                              style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.grey[500]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.radio_button_unchecked, color: Colors.grey),
                                  ],
                                ),
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
                gradient: const LinearGradient(colors: [Color(0xFF1173d4), Color(0xFF0EA5E9)]),
                borderRadius: BorderRadius.circular(999),
                boxShadow: const [BoxShadow(color: Color(0x4D0EA5E9), blurRadius: 20)],
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_fix_high, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Start Processing',
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
                      _buildNavItem(Icons.chat_bubble, 'Messages'),
                      _buildUploadItem(),
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

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.grey[400], size: 24),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -8,
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: const [BoxShadow(color: Color(0xCC1173D4), blurRadius: 10)],
                ),
              ),
            ),
            const Icon(Icons.add_circle, color: AppTheme.primary, size: 24),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          'Upload',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppTheme.primary,
          ),
        ),
      ],
    );
  }
}
