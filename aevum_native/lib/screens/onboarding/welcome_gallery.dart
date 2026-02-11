import 'package:flutter/material.dart';
import 'welcome_screen_1.dart';
import 'welcome_screen_2.dart';
import 'welcome_screen_3.dart';
import 'welcome_screen_4.dart';

class WelcomeGallery extends StatelessWidget {
  const WelcomeGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const [
        WelcomeScreen1(),
        WelcomeScreen2(),
        WelcomeScreen3(),
        WelcomeScreen4(),
      ],
    );
  }
}
