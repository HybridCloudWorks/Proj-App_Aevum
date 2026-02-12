import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeritageTopNav extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool showBack;

  const HeritageTopNav({
    super.key,
    this.title,
    this.subtitle,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showBack)
              _navButton(
                context,
                Icons.arrow_back_ios_new,
                () => Navigator.pop(context),
              )
            else
              const SizedBox(width: 44),
            if (title != null)
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: GoogleFonts.manrope(
                          fontSize: 11,
                          color: Colors.white54,
                        ),
                      ),
                  ],
                ),
              ),
            _navButton(context, Icons.help_outline, () {}),
          ],
        ),
      ),
    );
  }

  Widget _navButton(BuildContext context, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
