import 'dart:async';
import 'package:flutter/material.dart';

class SmartNavigationWrapper extends StatefulWidget {
  final Widget child;
  final Widget? topNav;
  final Widget? bottomNav;

  const SmartNavigationWrapper({
    super.key,
    required this.child,
    this.topNav,
    this.bottomNav,
  });

  @override
  State<SmartNavigationWrapper> createState() => _SmartNavigationWrapperState();
}

class _SmartNavigationWrapperState extends State<SmartNavigationWrapper> {
  bool _isVisible = true;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

  void _showNav() {
    if (!_isVisible) {
      setState(() {
        _isVisible = true;
      });
    }
    _startTimer();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _showNav(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            if (_isVisible) {
              setState(() {
                _isVisible = false;
              });
            }
          } else if (notification is ScrollEndNotification) {
            _showNav();
          }
          return false;
        },
        child: Stack(
          children: [
            widget.child,
            if (widget.topNav != null)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                top: _isVisible ? 0 : -120,
                left: 0,
                right: 0,
                child: widget.topNav!,
              ),
            if (widget.bottomNav != null)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                bottom: _isVisible ? 0 : -150,
                left: 0,
                right: 0,
                child: widget.bottomNav!,
              ),
          ],
        ),
      ),
    );
  }
}
