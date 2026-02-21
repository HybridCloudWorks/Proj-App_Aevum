import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/glass_card.dart';

class AIIdentityMatcherScreen extends StatelessWidget {
  const AIIdentityMatcherScreen({super.key});

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
        title: const Text("Identity Matcher",
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Review potential identity matches found by AI.",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/150?img=11'),
                        ),
                        const Icon(Icons.compare_arrows,
                            color: Colors.white54, size: 30),
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/150?img=12'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "98% Match Probability",
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const Text("Confirm"),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text("Reject"),
                        ),
                      ],
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
