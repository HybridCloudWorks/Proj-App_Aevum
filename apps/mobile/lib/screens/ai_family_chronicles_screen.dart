import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/glass_card.dart';

class AIFamilyChroniclesScreen extends StatelessWidget {
  const AIFamilyChroniclesScreen({super.key});

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
        title: const Text("Family Chronicles", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "AI-Generated stories from your family history.",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 24),
          _buildStoryCard(
            "The Journey West",
            "Based on 1920 Census Data",
            "https://picsum.photos/400/200?random=1",
          ),
          const SizedBox(height: 16),
          _buildStoryCard(
            "Life in New York",
            "Based on Letters & Photos",
            "https://picsum.photos/400/200?random=2",
          ),
        ],
      ),
    );
  }

  Widget _buildStoryCard(String title, String subtitle, String imageUrl) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(imageUrl,
                height: 150, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.white60)),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Text("Read Story", style: TextStyle(color: Colors.blue)),
                    Icon(Icons.arrow_forward, color: Colors.blue, size: 16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
