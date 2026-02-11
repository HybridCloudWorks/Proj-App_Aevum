import 'package:flutter/material.dart';
import 'package:aevum_native/screens/invite_member_screen.dart';
import 'package:aevum_native/screens/heritage_map_screen.dart';
import 'package:aevum_native/screens/heritage_upload_screen.dart';
import 'package:aevum_native/screens/heritage_messenger_screen.dart';
import 'package:aevum_native/screens/restoration_screen.dart';
import 'package:aevum_native/screens/member_memories_screen.dart';

void main() {
  runApp(const AevumApp());
}

class AevumApp extends StatelessWidget {
  const AevumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aevum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      // For the migration phase, we'll use a simple PageView or similar to browse screens
      // Setting Home to Dashboard for now
      home: const HeritageMapScreen(),
      routes: {
        '/restoration': (context) => const RestorationScreen(),
        '/memories': (context) => const MemberMemoriesScreen(),
        '/invite': (context) => const InviteMemberScreen(),
        '/map': (context) => const HeritageMapScreen(),
        '/upload': (context) => const HeritageUploadScreen(),
        '/messenger': (context) => const HeritageMessengerScreen(),
      },
    );
  }
}
