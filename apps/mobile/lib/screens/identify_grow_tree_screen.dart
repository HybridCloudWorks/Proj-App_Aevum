import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/glass_card.dart';

class IdentifyGrowTreeScreen extends StatelessWidget {
  const IdentifyGrowTreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text("Identify & Grow", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.nature_people, size: 80, color: Colors.green),
            const SizedBox(height: 24),
            const Text(
              "Grow Your Tree",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "Add new members and connect branches.",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 32),
            GlassCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person_add, color: Colors.blue),
                      title: const Text("Add Member", style: TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),
                    const Divider(color: Colors.white24),
                    ListTile(
                      leading: const Icon(Icons.link, color: Colors.orange),
                      title: const Text("Link Existing Branch", style: TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
