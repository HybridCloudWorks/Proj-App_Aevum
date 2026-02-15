import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/glass_card.dart';

class AdminRoleManagementScreen extends StatelessWidget {
  const AdminRoleManagementScreen({super.key});

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
        title: const Text("Role Management", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Assign and manage user roles.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: ListTile(
                leading: const Icon(Icons.security, color: Colors.red),
                title: const Text("Super Admin",
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text("Full system access",
                    style: TextStyle(color: Colors.white60)),
                trailing: const Icon(Icons.arrow_forward_ios,
                    color: Colors.white54, size: 16),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text("Editor",
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text("Can edit content",
                    style: TextStyle(color: Colors.white60)),
                trailing: const Icon(Icons.arrow_forward_ios,
                    color: Colors.white54, size: 16),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
