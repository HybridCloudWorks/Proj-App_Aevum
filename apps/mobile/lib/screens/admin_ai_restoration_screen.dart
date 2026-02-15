import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/glass_card.dart';

class AdminAIRestorationScreen extends StatelessWidget {
  const AdminAIRestorationScreen({super.key});

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
        title: const Text("Restoration Engine", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Manage image restoration models.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: ListTile(
                leading: const Icon(Icons.brush, color: Colors.purple),
                title: const Text("Default Model",
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text("GFPGAN v1.4",
                    style: TextStyle(color: Colors.white60)),
                trailing: const Icon(Icons.settings, color: Colors.white54),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
