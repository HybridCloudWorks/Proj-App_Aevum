import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/glass_card.dart';

class AdminStorageArchitectureScreen extends StatelessWidget {
  const AdminStorageArchitectureScreen({super.key});

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
        title: const Text("Storage Architecture",
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Manage storage tiers and policies.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: ListTile(
                leading: const Icon(Icons.storage, color: Colors.blue),
                title: const Text("Hot Storage (Standard)",
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text("For frequently accessed media",
                    style: TextStyle(color: Colors.white60)),
                trailing: const Icon(Icons.check_circle, color: Colors.green),
              ),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: ListTile(
                leading: const Icon(Icons.ac_unit, color: Colors.cyan),
                title: const Text("Cold Storage (Archive)",
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text("For older backups",
                    style: TextStyle(color: Colors.white60)),
                trailing: Switch(value: true, onChanged: (val) {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
