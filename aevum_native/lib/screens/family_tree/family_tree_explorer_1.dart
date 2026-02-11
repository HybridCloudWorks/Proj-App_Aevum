import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../widgets/glass_card.dart';
import '../../theme/app_theme.dart';

class FamilyTreeExplorer1 extends StatefulWidget {
  const FamilyTreeExplorer1({Key? key}) : super(key: key);

  @override
  State<FamilyTreeExplorer1> createState() => _FamilyTreeExplorer1State();
}

class _FamilyTreeExplorer1State extends State<FamilyTreeExplorer1> {
  final TransformationController _transformationController = TransformationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F151B),
      body: Stack(
        children: [
          // Infinite Canvas
          InteractiveViewer(
            transformationController: _transformationController,
            boundaryMargin: const EdgeInsets.all(1000),
            minScale: 0.1,
            maxScale: 4.0,
            child: Container(
              width: 2000,
              height: 2000,
              decoration: const BoxDecoration(
                color: Color(0xFF0B0F14),
              ),
              child: Stack(
                children: [
                  // Grid Background
                  Positioned.fill(
                    child: CustomPaint(
                      painter: GridPainter(),
                    ),
                  ),

                  // Background Blobs
                  Positioned(
                    top: 500,
                    left: 500,
                    width: 500,
                    height: 500,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  // Tree Nodes (Positioned manually based on HTML structure approx)
                  // Center is roughly 1000, 1000

                  // Great Grandma (Top) - Approx 1000, 400
                  Positioned(
                    left: 936, // 1000 - 64
                    top: 400,
                    child: _buildNode(
                      'Great Grandma',
                      '1920 - 1998',
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuC49n3EAp46HNYDwvC-xt5qXKZ3S2IumuZDdO9rHLwhl5brd2FRqA-4nwAIwcc04t2HuPo18VHwXFYrdpQfPGjXQkT3bDJ1rqUF9bD0dd3Ad8PjagcQAz2jHJLYJAFMHDZ864SwvPzDLicuHuGYwJkps71-AArAyEtF5E1pxzioTPUehxR_5ka1WH2-b77G8H7JWT7GzZSIJrO16B8WY916TUEwUcKRW4FcZ-8yYqCUb8Uz5BQx0frvptf9N8XSRsjEkglZ3FBfqc0',
                      hasMemory: true,
                    ),
                  ),

                  // Unknown (Top Right) - Approx 1100, 400
                  Positioned(
                    left: 1100,
                    top: 400,
                    child: _buildUnknownNode(),
                  ),

                  // Connector from Great Grandma
                  // Vertical line down
                  Positioned(
                    left: 1000,
                    top: 576, // 400 + 176 (height of card)
                    child: Container(width: 1, height: 48, color: Colors.white.withOpacity(0.2)),
                  ),

                  // Grandpa John & Grandma Mary (Middle) - Approx 850, 650
                  Positioned(
                    left: 850,
                    top: 650,
                    child: _buildNode(
                      'Grandpa John',
                      '1945 - 2018',
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBsfH8sC_znXauPce6RI4k93wC0K1QPHB0mvcJ8oS9qsrnHOj7ZFmDzRL7lidFTQSZMgLCKCE1mWuF46n2SsSaOnbXylI_qGflmrQGgr32gswKjvji-0X4GdFMS7IBEw-xih6iVIaQHHY2NGaem4W8SEEQhcdwlRPNHzWFK335cdLF4ofAtm1kkmFUBuFujOR47qLWov6OfTzwlpqcfqBN65l9kYbuuMxbSJIGIGyw_GZXdicEei6Hj9k7p1LtFphAQQRZL2kQYXa0',
                      badge: 'New Story',
                      badgeColor: Colors.orange,
                    ),
                  ),

                  Positioned(
                    left: 1050,
                    top: 650,
                    child: _buildNode(
                      'Grandma Mary',
                      '1948 - Present',
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuD_8Du2RPciLGr-K63SXKWPYNqJyj8UyWFBF7Snq4LCWgrpddw3JmKAZPMYQyGp2zOKoprIuE15zO-aVTJFVlZn4uCJ1ZJb-nY9Zn6aNcg6BWE8G2vWcXPSAzji9AcE46XcZYaAKj7oXQEHjt72oERCVpdhF_RYSIKid8QG6ubu5vEa_zJ2qXHF6ulqaGZ7bd-nvAFCqKX73aWAwk7-scJqOLF7o6ujqwFU-iLYCWwQTdHFZJV4vCnhsA2VKz6wEpC7cMVhqB8-P7o',
                    ),
                  ),

                  // Horizontal Connector between them
                  Positioned(
                    left: 922, // 850 + 72 (half width)
                    top: 746, // 650 + 96 (half height)
                    child: Container(width: 200, height: 1, color: Colors.white.withOpacity(0.2)),
                  ),

                  // Michael & Sarah (Bottom) - Approx 800, 900
                  Positioned(
                    left: 800,
                    top: 900,
                    child: _buildNode(
                      'Michael Johnson',
                      '1970 - Present',
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuAFNoCUAThY_enku-xJMxTZ6u6XcpinYrgacoAoTvfMeQsMsuvFWOx4Gk16k7zzGFvFqiDal7yetoigjEeX-eVPlQu2PZFWAXUUeFQMoe1SvPc6rA55qxI_4pqMrSKWKd0J-N06Igvt8Fe3FXQOVYLT3Z_ANtdPLqz2mU9gfGKEwRCcqInJPR6wq_Cabc4gvaxYOYirXUUd0DU7nvxX8RcRJAGfawZPQktuMOknnllHMghuAgPvH-c2t2khb-i_bjSUDXo1THOnOPI',
                      tag: 'FATHER',
                      tagColor: Colors.blue,
                    ),
                  ),

                  Positioned(
                    left: 1100,
                    top: 900,
                    child: _buildNode(
                      'Sarah Johnson',
                      '1972 - Present',
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCxV1U4tjHVEyPgxmTsQr_ANdHlstxxsyxHU6i_Pqv6x4u76IpKix6ZcxqWAR0h-H1RjbAlgR1dIwtA1dTxZoFW6GhiGTUtUK0XrDk2nBjusNbhfgEJ7kVM0Y4foL129avPSfpikKPghb4brWm3ppBnotHTtkP-ziLaGfiXNwWVM4NIM76MDj0_24XvhqgAjTYiVR1e4DjiUyqw1vFl9SGfCQlxE4nm_pBSWH5vBajPz90nQevQUxT9dGNjFGqBUrGQuJAsYKfJdas',
                      tag: 'MOTHER',
                      tagColor: Colors.pink,
                    ),
                  ),

                  // You (Alex) - Approx 950, 1150
                  Positioned(
                    left: 880, // Center roughly
                    top: 1150,
                    child: _buildYouNode(),
                  ),
                ],
              ),
            ),
          ),

          // Header Overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xA6101922), // glass-panel
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.menu, color: Colors.white70),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Johnson Ancestry',
                                  style: GoogleFonts.manrope(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'EDITING NOW',
                                  style: GoogleFonts.manrope(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[400],
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GlassCard(
                              borderRadius: 999,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              child: Row(
                                children: [
                                  const Icon(Icons.filter_alt, color: AppTheme.primary, size: 18),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Filter',
                                    style: GoogleFonts.manrope(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppTheme.primary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x661173D4),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.person_add, color: Colors.white, size: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Floating Controls (Bottom Right)
          Positioned(
            bottom: 110,
            right: 24,
            child: Column(
              children: [
                // Pan/Zoom Widget
                SizedBox(
                  width: 128,
                  height: 128,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GlassCard(
                        borderRadius: 999,
                        padding: EdgeInsets.zero,
                        backgroundColor: const Color(0xA6101922),
                        child: const SizedBox(
                          width: 128,
                          height: 128,
                          child: Stack(
                            children: [
                              Positioned(top: 8, left: 56, child: Icon(Icons.expand_less, color: Colors.grey, size: 16)),
                              Positioned(bottom: 8, left: 56, child: Icon(Icons.expand_more, color: Colors.grey, size: 16)),
                              Positioned(left: 8, top: 56, child: Icon(Icons.chevron_left, color: Colors.grey, size: 16)),
                              Positioned(right: 8, top: 56, child: Icon(Icons.chevron_right, color: Colors.grey, size: 16)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF334155), Color(0xFF0F172A)],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF475569)),
                          boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 4))],
                        ),
                        child: const Icon(Icons.pan_tool, color: Colors.white70),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF0F151B), width: 2),
                          ),
                          child: const Icon(Icons.center_focus_weak, color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Infinite Pan',
                    style: GoogleFonts.manrope(fontSize: 10, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          // Floating Controls (Bottom Left)
          Positioned(
            bottom: 110,
            left: 24,
            child: Column(
              children: [
                GlassCard(
                  borderRadius: 999,
                  padding: const EdgeInsets.all(6),
                  backgroundColor: const Color(0xA6101922),
                  child: Column(
                    children: [
                      IconButton(icon: const Icon(Icons.add, color: Colors.white), onPressed: () {}),
                      IconButton(icon: const Icon(Icons.remove, color: Colors.white), onPressed: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xA6101922), // glass-panel
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: const Icon(Icons.visibility, color: Colors.white),
                ),
              ],
            ),
          ),

          // Bottom Nav
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xA6101922),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                border: Border.all(color: Colors.white.withOpacity(0.08), width: 0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 40,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.account_tree, 'Tree', isActive: true),
                  _buildNavItem(Icons.photo_library, 'Memories'),
                  _buildNavItem(Icons.search, 'Search'),
                  _buildNavProfileItem(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNode(String name, String years, String imageUrl, {String? badge, Color? badgeColor, String? tag, Color? tagColor, bool hasMemory = false}) {
    return Column(
      children: [
        Container(
          width: 144, // w-36
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0x12FFFFFF), // glass-card
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 32,
                offset: const Offset(0, 8),
              ),
              if (hasMemory)
                 BoxShadow(
                  color: Colors.orange.withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Column(
            children: [
              if (hasMemory)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle)),
                ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[700],
                  border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                years,
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  color: Colors.grey[400],
                ),
                textAlign: TextAlign.center,
              ),
              if (badge != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: (badgeColor ?? Colors.orange).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: (badgeColor ?? Colors.orange).withOpacity(0.2)),
                  ),
                  child: Text(
                    badge,
                    style: GoogleFonts.manrope(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: (badgeColor ?? Colors.orange).withOpacity(0.8),
                    ),
                  ),
                ),
              ],
              if (tag != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: (tagColor ?? Colors.blue).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: (tagColor ?? Colors.blue).withOpacity(0.2)),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.manrope(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: (tagColor ?? Colors.blue).withOpacity(0.8),
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUnknownNode() {
    return Container(
      width: 128,
      height: 176,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), style: BorderStyle.none), // dashed border not easy in BoxDecoration
        // Use custom painter for dashed border if needed
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.05),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: const Icon(Icons.person, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            'Unknown',
            style: GoogleFonts.manrope(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [AppTheme.primary, Colors.blue]),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildYouNode() {
    return Container(
      width: 240, // w-60
      height: 288, // h-72
      decoration: BoxDecoration(
        color: const Color(0x12FFFFFF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primary.withOpacity(0.3), width: 2),
        boxShadow: const [
          BoxShadow(color: Color(0x661173D4), blurRadius: 20, spreadRadius: 2),
        ],
      ),
      child: Stack(
        children: [
          Container(
            height: 128,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppTheme.primary.withOpacity(0.2), Colors.transparent],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 32),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 128,
                      height: 128,
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [AppTheme.primary, Colors.blue]),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF1E293B), width: 4),
                          image: const DecorationImage(
                            image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuAuz4J3gyQLdpRSsMEvKzvTw6eZYFYbaCHhkLUshrbxFcawhprTjaVQtiIuzHGdcpS8H4qJIJTsRjcuG2J83ImDn_WXy4z70I-D4fGNLN32GWwJU9SSYVqDxegRvkOtEgeZB-aXMaozdN78Mq1PUXxtVBKx0aNcUCnXjNckfml-9DR1BftUhTUJZ9F9SaeNMn9l2YxB-fuL_kc6fd5OZqurZV_rtTMJHYdeMFKN-VG0H8FFKYPnCjvk761kg9IgtPyKs18PpDejufE'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: const Color(0xFF0F151B)),
                        ),
                        child: Text(
                          'YOU',
                          style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Alex Johnson',
                style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                '1995 - Present',
                style: GoogleFonts.manrope(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isActive)
          Container(
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(2),
              boxShadow: const [BoxShadow(color: AppTheme.primary, blurRadius: 10)],
            ),
          ),
        if (isActive) const SizedBox(height: 4),
        Icon(icon, color: isActive ? AppTheme.primary : Colors.grey, size: 28),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.white : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildNavProfileItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
            image: const DecorationImage(
              image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuB-BYcwYglHbIlbJLTB2YbiScF_Ry1BTuwm66EsQlLnsJFqBFwxwbK0p2Mwu6h77FC6D02Z5xYZuUr-EPRS9R1wRcqTJ5GHlWrSGDmK_8vMKCAWI4su8WzInKYz0SZd2qluAhFO6gEDXCDTGqBlAWnqtXdiBHx0auILWtL_alXuIdJ2pKfsaTxrpqxJopwQXxX5AAphDpe3zQWM07qNKd7FGzm63hgnarPY8AhVa42s3K-B7bIkaj8obsikF1sHtL3MH4avyl6kLjg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          'Profile',
          style: GoogleFonts.manrope(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.07)
      ..style = PaintingStyle.fill;

    const gridSize = 32.0;
    const dotSize = 1.0;

    for (var x = 0.0; x < size.width; x += gridSize) {
      for (var y = 0.0; y < size.height; y += gridSize) {
        canvas.drawCircle(Offset(x, y), dotSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
