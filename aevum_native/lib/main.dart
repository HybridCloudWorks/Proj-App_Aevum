import 'package:flutter/material.dart';
import 'screens/screen_gallery.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AevumApp());
}

class AevumApp extends StatelessWidget {
  const AevumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aevum Native',
      theme: AppTheme.darkTheme,
      home: const ScreenGallery(),
      debugShowCheckedModeBanner: false,
    );
  }
}
