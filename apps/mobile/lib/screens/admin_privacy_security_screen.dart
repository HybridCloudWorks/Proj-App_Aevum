import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/glass_card.dart';

class AdminPrivacySecurityScreen extends StatelessWidget {
  const AdminPrivacySecurityScreen({super.key});

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
        title: const Text("Privacy & Security",
            style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection(
              title: "Data Access",
              children: [
                _buildToggle("Require Admin Approval", true),
                _buildToggle("Allow Public Search", false),
                _buildToggle("Encrypt Metadata", true),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: "AI Compliance",
              children: [
                _buildToggle("Face Recognition Consent", true),
                _buildToggle("Automated Tagging", true),
                _buildToggle("Data Training Opt-In", false),
              ],
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: ListTile(
                leading:
                    const Icon(Icons.download_outlined, color: Colors.blue),
                title: const Text("Export Audit Logs",
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text("CSV / JSON format",
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

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GlassCard(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildToggle(String title, bool value) {
    return SwitchListTile(
      value: value,
      onChanged: (val) {},
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      activeColor: Colors.blue,
    );
  }
}
