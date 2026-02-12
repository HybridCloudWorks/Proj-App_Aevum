import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aevum_native/widgets/smart_navigation_wrapper.dart';
import 'package:aevum_native/widgets/heritage_top_nav.dart';
import 'package:aevum_native/widgets/heritage_bottom_nav.dart';

class FamilyBranchNavigatorScreen extends StatelessWidget {
  const FamilyBranchNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: SmartNavigationWrapper(
        topNav: const HeritageTopNav(
          title: "Family Branches",
          subtitle: "Select a lineage to explore",
        ),
        bottomNav: const HeritageBottomNav(activeIndex: 0),
        child: Stack(
          children: [
            _buildMeshGradient(),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 80), // Spacer for topNav
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildBranchCard(
                          title: "Sterling — Beaumont",
                          ancestors: 142,
                          isMainLine: true,
                          imageUrl:
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuCvrfWGXR_NSzBzI-JasKOidA7kNnec1xEo-F4tEKONh3BnnTTr9SujMk86VlGSW4a0huOIl6C2-R1sS-MsjiTawJGTP61ugi0m18NTYSVhw1RJ9WNIJ5KkZ9reDqFDL3lPIx5tKg3TLO33-8ZkodDYfpah3gEaa5hVhIdnFEgox0Tsbk7Ueci3-w1ulBfXeGCvrzfXdA3U2ehwlnXybAw7RQA8mrOAQPZeMGma_1gywJx1ghseyqQpyiletZuSh3Q4hQ5LA5j3Gjk",
                          flagColor: Colors.blue[900]!,
                        ),
                        const SizedBox(height: 16),
                        _buildBranchCard(
                          title: "Ricci — Moretti",
                          ancestors: 89,
                          imageUrl:
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuCcPMHZe7pihuDC5a1Ab23u52UektHv1tziZdoknIH6xx0WN3z71zNmLVdb1d_tRYkuxnnGDZpOwQp2juuCCakBuRSWjSGuLqPoF7Prb-Hm3AbibIn1J39HzeYV9NOJ8bMG4oShj8sgbjU3m5xCUe_RURkKEkxgqLG7NSqmtBEql701G8VrT9PjHRA8cTOxE4mqWflN0bOs3SsQwt0-hc6AyYTnFsHdUGEjO1HDl6fK613ZVMwJCUAb8sF6jzfwHqFp_cTPg_zr90w",
                          flagColor: Colors.red[600]!,
                        ),
                        const SizedBox(height: 16),
                        _buildBranchCard(
                          title: "Thatcher — Sinclair",
                          ancestors: 216,
                          tag: "Paternal",
                          tagColor: const Color(0xFFD4AF37), // Gold
                          imageUrl:
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuD-nKQbiFsnM91oCP-REC1jlVD8Vn5aEW6X_cxkm_Cd7eL5qb-npLJ5617eXXHSQJFy9Oj9NZj1BFilr2Ep8qlqtl0lWDP8F9-ONGrbJU0HIMEVQmnjpksG59WGzl9fC4kJCHFexd0wuj24i8DVhhTfkmLBUu0w5YK2rZvQJLhUwpquEa_JkviFbJnH6j8VRBUec5SoXr6Q-h0A6B-JPNupsiIIKFHe5uC2xHOYlN-hGygP3Z0f_KbxUK_jxhPA1Z97lLdhL-HB6Vo",
                          flagColor: Colors.green[700]!,
                          opacity: 0.9,
                        ),
                        const SizedBox(height: 16),
                        _buildBranchCard(
                          title: "Hamilton — Ross",
                          ancestors: 54,
                          imageUrl:
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuDefNGMx_L3_FnLpCbvzPX5nNPOjBgiuGAm5za8a161AfwUxWVtGTzDIKPVV6qDMZ3RHRkFeOTfpeEEou7F2obAeB7DrKxELhL4bvzzTjs71TsLM3j6U-uMRgVZLJEdkR7yjLdOeftsDBZekO_RwFODQ85H3AKLqgmsEg-Ag6PEah6HoM1hIahMoVw_dod0xxhZhtl24jmk-n1ArfyLvI-LPedTctTlx6tUQi8D1-ot28UiRGICH0PluJTWuC1c6U3gXDSaewtAB5g",
                          flagColor: Colors.blue[400]!,
                          opacity: 0.8,
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildFAB(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMeshGradient() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xFF0F172A)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF13111A).withValues(alpha: 1.0),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 200,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF1E2F4D).withValues(alpha: 1.0),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF4D1E2F).withValues(alpha: 1.0),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchCard({
    required String title,
    required int ancestors,
    bool isMainLine = false,
    String? tag,
    Color? tagColor,
    required String imageUrl,
    required Color flagColor,
    double opacity = 1.0,
  }) {
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1E293B).withValues(alpha: 0.75),
              const Color(0xFF0F172A).withValues(alpha: 0.85),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "FAMILY BRANCH",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white38,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1173D4).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(
                              0xFF1173D4,
                            ).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          "$ancestors Ancestors",
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF60A5FA),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (isMainLine) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF0EA5E9,
                            ).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(
                                0xFF0EA5E9,
                              ).withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            "Main Line",
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF38BDF8),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      if (tag != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: (tagColor ?? Colors.green).withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: (tagColor ?? Colors.green).withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ),
                          child: Text(
                            tag,
                            style: GoogleFonts.plusJakartaSans(
                              color: tagColor ?? Colors.green,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF101922),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Icon(Icons.flag, color: flagColor, size: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return Positioned(
      bottom: 120,
      right: 24,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF1173D4), Color(0xFF0EA5E9)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0EA5E9).withValues(alpha: 0.4),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/plant-branch');
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add, color: Colors.white, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    "New Branch",
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
      ),
    );
  }
}
