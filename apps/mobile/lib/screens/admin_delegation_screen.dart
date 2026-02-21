import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/glass_card.dart';

class AdminDelegationScreen extends StatelessWidget {
  const AdminDelegationScreen({super.key});

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
        title: const Text("Admin Delegation", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Assign administrative roles to family members.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text("JD"),
                ),
                title: const Text("John Doe", style: TextStyle(color: Colors.white)),
                subtitle: const Text("Editor", style: TextStyle(color: Colors.white60)),
                trailing: const Icon(Icons.edit, color: Colors.white54),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
