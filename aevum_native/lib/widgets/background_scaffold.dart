import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BackgroundScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final bool extendBodyBehindAppBar;
  final Color backgroundColor;

  const BackgroundScaffold({
    Key? key,
    required this.body,
    this.bottomNavigationBar,
    this.appBar,
    this.extendBodyBehindAppBar = false,
    this.backgroundColor = AppTheme.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We use a Stack to layer the background blobs behind the content
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Blobs Layer
          const _BackgroundBlobs(),

          // Main Content
          SafeArea(
            child: body,
          ),

          // Bottom Nav Bar (if floating)
          if (bottomNavigationBar != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: bottomNavigationBar!,
            ),
        ],
      ),
      // If standard bottom nav is needed, use this
      // bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class _BackgroundBlobs extends StatelessWidget {
  const _BackgroundBlobs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blue Blob (Top Left)
        Positioned(
          top: -100, // approximate -10%
          left: -50, // approximate -10%
          width: 300, // approximate 60%
          height: 300,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0x4D2563EB), // blue-600/30
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        // Purple Blob (Bottom Right)
        Positioned(
          bottom: -100,
          right: -50,
          width: 300,
          height: 300,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0x4D9333EA), // purple-600/30
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        // Pink Blob (Center Left)
        Positioned(
          top: 300, // approximate 40%
          left: 100, // approximate 30%
          width: 250, // approximate 50%
          height: 250,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0x33EC4899), // pink-500/20
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        // Overlay (Backdrop Blur)
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1), // blur-[1px]
            child: Container(
              color: Colors.black.withOpacity(0.1), // bg-black/10
            ),
          ),
        ),
      ],
    );
  }
}
