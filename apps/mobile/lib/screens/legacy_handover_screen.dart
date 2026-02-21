import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/glass_card.dart';

class LegacyHandoverScreen extends StatelessWidget {
  const LegacyHandoverScreen({super.key});

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
        title: const Text("Legacy Handover", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Configure account succession settings.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: ListTile(
                leading: const Icon(Icons.timer, color: Colors.orange),
                title: const Text("Inactivity Period",
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text("3 Months",
                    style: TextStyle(color: Colors.white60)),
                trailing: const Icon(Icons.edit, color: Colors.white54),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: ListTile(
                leading: const Icon(Icons.person_pin, color: Colors.green),
                title: const Text("Successor",
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text("Not assigned",
                    style: TextStyle(color: Colors.white60)),
                trailing: const Icon(Icons.add, color: Colors.white54),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
