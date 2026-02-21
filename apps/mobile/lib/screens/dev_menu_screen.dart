import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/glass_card.dart';

class DevMenuScreen extends StatelessWidget {
  const DevMenuScreen({super.key});

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
        title: const Text("Developer Menu", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection("AI & Engine", [
            _devItem(context, "AI Restoration", '/admin-ai-restoration'),
            _devItem(context, "Identity Matcher", '/ai-identity'),
            _devItem(context, "Semantic Discovery", '/discovery'),
          ]),
          const SizedBox(height: 24),
          _buildSection("Infrastructure", [
            _devItem(context, "Storage Architecture", '/admin-architecture'),
            _devItem(context, "Vault Health", '/vault-health'),
            _devItem(context, "Sync Conflicts", '/admin-sync'),
          ]),
          const SizedBox(height: 24),
          _buildSection("Admin Tools", [
            _devItem(context, "Delegation", '/admin-delegation'),
            _devItem(context, "Privacy & Security", '/admin-privacy'),
            _devItem(context, "Legacy Handover", '/legacy-handover'),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _devItem(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GlassCard(
        child: ListTile(
          title: Text(title, style: const TextStyle(color: Colors.white)),
          trailing: const Icon(Icons.arrow_forward, color: Colors.white54),
          onTap: () => context.push(route),
        ),
      ),
    );
  }
}
