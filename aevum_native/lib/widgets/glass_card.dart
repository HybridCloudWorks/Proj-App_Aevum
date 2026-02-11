import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blurAmount;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsets padding;
  final double borderWidth;
  final List<BoxShadow>? shadows;
  final VoidCallback? onTap;

  const GlassCard({
    Key? key,
    required this.child,
    this.borderRadius = 24.0,
    this.blurAmount = 16.0,
    this.backgroundColor = const Color(0x1AFFFFFF), // rgba(255, 255, 255, 0.1)
    this.borderColor = const Color(0x33FFFFFF), // rgba(255, 255, 255, 0.2)
    this.padding = EdgeInsets.zero,
    this.borderWidth = 1.0,
    this.shadows,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine if we need a GestureDetector
    Widget content = child;
    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: content,
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadows ?? [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: borderColor,
                width: borderWidth,
              ),
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
