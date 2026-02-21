import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeritageTopNav extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;

  const HeritageTopNav({
    super.key,
    required this.title,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.white, size: 20),
              onPressed: () => context.pop(),
            )
          : null,
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white70),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
