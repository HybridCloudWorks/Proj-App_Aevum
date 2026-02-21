import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/glass_card.dart';

class AdminSyncConflictScreen extends StatelessWidget {
  const AdminSyncConflictScreen({super.key});

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
        title: const Text("Sync Conflicts", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Resolve data synchronization issues.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: ListTile(
                leading: const Icon(Icons.sync_problem, color: Colors.red),
                title: const Text("Conflict: Profile Update",
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text("Local vs Remote Mismatch",
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
