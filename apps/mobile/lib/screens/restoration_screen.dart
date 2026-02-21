import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/glass_card.dart';

class RestorationScreen extends StatelessWidget {
  const RestorationScreen({super.key});

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
        title: const Text("AI Restoration", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.image, size: 64, color: Colors.white24),
                  Positioned(
                    bottom: 16,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.upload_file),
                      label: const Text("Select Photo"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Enhancement Options",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _buildOption("Colorize", true),
                    _buildOption("Sharpen Details", true),
                    _buildOption("Remove Scratches", false),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Start Restoration"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String title, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70)),
        Switch(
          value: value,
          onChanged: (val) {},
          activeColor: Colors.blueAccent,
        ),
      ],
    );
  }
}
