import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/glass_card.dart';

class FamilyBranchNavigatorScreen extends StatelessWidget {
  const FamilyBranchNavigatorScreen({super.key});

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
        title: const Text("Family Branches", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              context.push('/plant-branch');
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GlassCard(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.primaries[index % Colors.primaries.length],
                  child: Text(String.fromCharCode(65 + index)),
                ),
                title: Text("Branch ${String.fromCharCode(65 + index)}",
                    style: const TextStyle(color: Colors.white)),
                subtitle: const Text("12 Members • Last active 2d ago",
                    style: TextStyle(color: Colors.white60)),
                trailing: const Icon(Icons.arrow_forward_ios,
                    color: Colors.white54, size: 16),
                onTap: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
