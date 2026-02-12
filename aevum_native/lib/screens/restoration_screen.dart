import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aevum_native/widgets/heritage_bottom_nav.dart';
import 'package:aevum_native/widgets/smart_navigation_wrapper.dart';

import 'package:aevum_native/services/storage_service.dart';

class RestorationScreen extends StatefulWidget {
  final String? mediaId;
  const RestorationScreen({super.key, this.mediaId});

  @override
  State<RestorationScreen> createState() => _RestorationScreenState();
}

class _RestorationScreenState extends State<RestorationScreen> {
  final StorageService _storageService = StorageService();
  static const Color _accentColor = Color(0xFF6366F1);
  static const Color _emeraldColor = Color(0xFF10B981);
  bool _isProcessing = false;
  double _sliderValue = 0.5;
  bool _colorize = true;
  bool _sharpen = true;
  bool _repair = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1121),
      appBar: _buildAppBar(),
      body: SmartNavigationWrapper(
        bottomNav: const HeritageBottomNav(activeIndex: 3), // Profile-related
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildComparisonSection(),
              const SizedBox(height: 32),
              _buildSectionHeader(Icons.tune, "Restoration Controls"),
              const SizedBox(height: 20),
              _buildControlsGrid(),
              const SizedBox(height: 16),
              _buildRepairTile(),
              const SizedBox(height: 32),
              _buildSaveButton(),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF0B1121).withValues(alpha: 0.7),
      elevation: 0,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.transparent),
        ),
      ),
      leading: Center(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.05),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Column(
        children: [
          Text(
            "Aevum",
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Text(
            "AI RESTORATION",
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white54,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.ios_share, size: 20, color: Colors.white),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildComparisonSection() {
    const String imageUrl =
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD6rLWYNqR4sQgKqUxA8itpYbWXVX2-AazxpOq2ruKAUHeE88QzbLzddOdrSSPueXXolY0mRc53w7JH1MHgnxowqUH38duGKayQBL3QGkFmy67PfrafwkAncBVgXFshhCrlV5O9l5XYFtSWDjvsZgOmDibOqOf9VfohVZPB8t3L1XsH0o7Gc8wHDiTMDJLR3Mkv8u1JKpekBv7hqaZN-XbkutgK1HMXkryD667osEYGmVBJUXNSmRkMazqU6vZYrXp21beGfnhnR_Q';

    return Column(
      children: [
        Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: _accentColor.withValues(alpha: 0.2),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // "Before" (Grayscale base)
                Positioned.fill(
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.matrix([
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ),
                // "After" (Color overlay clipped)
                Positioned.fill(
                  child: ClipRect(
                    clipper: _ComparisonClipper(_sliderValue),
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ),
                // Labels
                Positioned(
                  top: 16,
                  left: 16,
                  child: _labelTag(
                    "Before",
                    Colors.black.withValues(alpha: 0.6),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: _labelTag(
                    "After",
                    _accentColor.withValues(alpha: 0.9),
                  ),
                ),
                // Slider Interaction
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          setState(() {
                            _sliderValue =
                                (details.localPosition.dx /
                                        constraints.maxWidth)
                                    .clamp(0.0, 1.0);
                          });
                        },
                        child: Container(color: Colors.transparent),
                      );
                    },
                  ),
                ),
                // Slider Handle
                Positioned(
                  left:
                      400 *
                      _sliderValue *
                      (MediaQuery.of(context).size.width - 40) /
                      400,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 2,
                    color: Colors.white,
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 10),
                          ],
                        ),
                        child: const Icon(
                          Icons.compare_arrows,
                          color: Color(0xFF6366F1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Original",
              style: GoogleFonts.manrope(fontSize: 12, color: Colors.white54),
            ),
            Text(
              "Enhanced Result",
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: _accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _labelTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: _accentColor, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildControlsGrid() {
    return Row(
      children: [
        Expanded(
          child: _controlCard(
            Icons.palette,
            "Colorize",
            "Add natural colors to B&W photos",
            _colorize,
            (v) => setState(() => _colorize = v),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _controlCard(
            Icons.shutter_speed,
            "Sharpen",
            "Enhance details and remove blur",
            _sharpen,
            (v) => setState(() => _sharpen = v),
          ),
        ),
      ],
    );
  }

  Widget _controlCard(
    IconData icon,
    String title,
    String sub,
    bool active,
    Function(bool) onChanged,
  ) {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: _accentColor, size: 20),
              ),
              Switch(
                value: active,
                onChanged: onChanged,
                activeThumbColor: _accentColor,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                sub,
                style: const TextStyle(color: Colors.white54, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRepairTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _emeraldColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.healing, color: _emeraldColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Repair Scratches",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Fix tears, dust and damage",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _repair,
            onChanged: (v) => setState(() => _repair = v),
            activeThumbColor: _emeraldColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: _isProcessing
          ? null
          : () async {
              if (widget.mediaId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No media selected for restoration"),
                  ),
                );
                return;
              }

              setState(() => _isProcessing = true);

              try {
                await _storageService.requestRestoration(
                  mediaId: widget.mediaId!,
                  colorize: _colorize,
                  sharpen: _sharpen,
                  repair: _repair,
                );

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Restoration request sent to AI engine"),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Error: $e")));
                }
              } finally {
                if (mounted) setState(() => _isProcessing = false);
              }
            },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: _isProcessing ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _accentColor.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: _isProcessing
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFF0B1121),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_awesome, color: Color(0xFF0B1121)),
                    const SizedBox(width: 8),
                    Text(
                      "Start AI Restoration",
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF0B1121),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildFloatingBottomNav() {
    return Positioned(
      bottom: 24,
      left: 20,
      right: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFF101922).withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _navIcon(Icons.photo_library, false),
                _navIcon(Icons.account_tree, false),
                _navIcon(Icons.auto_fix_high, true),
                _navIcon(Icons.person, false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, bool active) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: active
          ? BoxDecoration(
              color: _accentColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      child: Icon(icon, color: active ? _accentColor : Colors.white24),
    );
  }
}

class _ComparisonClipper extends CustomClipper<Rect> {
  final double progress;
  _ComparisonClipper(this.progress);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * progress, size.height);
  }

  @override
  bool shouldReclip(_ComparisonClipper oldClipper) =>
      oldClipper.progress != progress;
}
