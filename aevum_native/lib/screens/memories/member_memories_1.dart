import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../widgets/glass_card.dart';
import '../../theme/app_theme.dart';

class MemberMemories1 extends StatefulWidget {
  const MemberMemories1({Key? key}) : super(key: key);

  @override
  State<MemberMemories1> createState() => _MemberMemories1State();
}

class _MemberMemories1State extends State<MemberMemories1> {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1121),
      appBar: AppBar(
        backgroundColor: const Color(0xB30B1121), // /70 opacity
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () {},
        ),
        title: Column(
          children: [
            Text(
              'Aevum',
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'AI RESTORATION',
              style: GoogleFonts.manrope(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.grey[400],
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share, size: 20),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.white.withOpacity(0.05),
            height: 1.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Before/After Image Slider
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withOpacity(0.2),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            setState(() {
                              _sliderValue += details.delta.dx / constraints.maxWidth;
                              _sliderValue = _sliderValue.clamp(0.0, 1.0);
                            });
                          },
                          child: Stack(
                            children: [
                              // Before Image (Full)
                              Image.network(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuD6rLWYNqR4sQgKqUxA8itpYbWXVX2-AazxpOq2ruKAUHeE88QzbLzddOdrSSPueXXolY0mRc53w7JH1MHgnxowqUH38duGKayQBL3QGkFmy67PfrafwkAncBVgXFshhCrlV5O9l5XYFtSWDjvsZgOmDibOqOf9VfohVZPB8t3L1XsH0o7Gc8wHDiTMDJLR3Mkv8u1JKpekBv7hqaZN-XbkutgK1HMXkryD667osEYGmVBJUXNSmRkMazqU6vZYrXp21beGfnhnR_Q',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.grey, // Grayscale approx
                                colorBlendMode: BlendMode.saturation,
                              ),
                              Positioned(
                                top: 16,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                                  ),
                                  child: Text(
                                    'Before',
                                    style: GoogleFonts.manrope(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                              // After Image (Clipped)
                              ClipRect(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: _sliderValue,
                                  child: Image.network(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuD6rLWYNqR4sQgKqUxA8itpYbWXVX2-AazxpOq2ruKAUHeE88QzbLzddOdrSSPueXXolY0mRc53w7JH1MHgnxowqUH38duGKayQBL3QGkFmy67PfrafwkAncBVgXFshhCrlV5O9l5XYFtSWDjvsZgOmDibOqOf9VfohVZPB8t3L1XsH0o7Gc8wHDiTMDJLR3Mkv8u1JKpekBv7hqaZN-XbkutgK1HMXkryD667osEYGmVBJUXNSmRkMazqU6vZYrXp21beGfnhnR_Q',
                                    fit: BoxFit.cover,
                                    width: constraints.maxWidth,
                                    height: double.infinity,
                                  ),
                                ),
                              ),

                              // Slider Handle
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: constraints.maxWidth * _sliderValue,
                                child: Container(
                                  width: 2,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                              Positioned(
                                top: constraints.maxHeight / 2 - 20,
                                left: constraints.maxWidth * _sliderValue - 20,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(Icons.compare_arrows, color: Color(0xFF6366F1)),
                                ),
                              ),

                              // After Label (only visible if slider is far enough)
                              if (_sliderValue > 0.2)
                                Positioned(
                                  top: 16,
                                  right: 16,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xE64F46E5), // Indigo-600/90
                                      borderRadius: BorderRadius.circular(999),
                                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                                    ),
                                    child: Text(
                                      'After',
                                      style: GoogleFonts.manrope(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Original',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400],
                      ),
                    ),
                    Text(
                      'Enhanced Result',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigoAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Controls
                Row(
                  children: [
                    const Icon(Icons.tune, color: Colors.indigoAccent, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Restoration Controls',
                      style: GoogleFonts.manrope(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Grid of Controls
                Row(
                  children: [
                    Expanded(
                      child: _buildControlCard(
                        title: 'Colorize',
                        subtitle: 'Add natural colors',
                        icon: Icons.palette,
                        color: Colors.indigo,
                        isChecked: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildControlCard(
                        title: 'Sharpen',
                        subtitle: 'Enhance details',
                        icon: Icons.shutter_speed,
                        color: Colors.blue,
                        isChecked: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildRepairControl(),

                const SizedBox(height: 24),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF0F172A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: Colors.indigo.withOpacity(0.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.download, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          'Save Enhanced Photo',
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Nav (Floating)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16),
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xCC0F172A), // slate-900/80
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.photo_library),
                      _buildNavItem(Icons.account_tree),
                      _buildNavItem(Icons.auto_fix_high, isActive: true),
                      _buildNavItem(Icons.person),
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

  Widget _buildControlCard({required String title, required String subtitle, required IconData icon, required Color color, bool isChecked = false}) {
    return GlassCard(
      borderRadius: 24,
      padding: const EdgeInsets.all(16),
      backgroundColor: const Color(0x661E293B), // slate-800/40
      borderColor: Colors.white.withOpacity(0.1),
      child: SizedBox(
        height: 140, // h-40 = 160px? No, 40*4=160. Tailwind h-40 is 10rem.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2), // bg-indigo-900/40
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color.withOpacity(0.8), size: 24),
                ),
                Switch(
                  value: isChecked,
                  onChanged: (v) {},
                  activeColor: color,
                  activeTrackColor: color.withOpacity(0.3),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    color: Colors.grey[400],
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRepairControl() {
    return GlassCard(
      borderRadius: 24,
      padding: const EdgeInsets.all(16),
      backgroundColor: const Color(0x661E293B),
      borderColor: Colors.white.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.2), // emerald-900/40
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.healing, color: Colors.teal.withOpacity(0.8), size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Repair Scratches',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Fix tears, dust and damage',
                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Switch(
            value: false,
            onChanged: (v) {},
            activeColor: Colors.teal,
            inactiveThumbColor: Colors.grey[300],
            inactiveTrackColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, {bool isActive = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isActive)
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.indigoAccent, size: 24),
          )
        else
          Icon(icon, color: Colors.grey[400], size: 24),
      ],
    );
  }
}
