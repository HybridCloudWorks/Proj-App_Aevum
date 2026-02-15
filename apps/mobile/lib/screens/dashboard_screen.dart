import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/glass_card.dart';
import '../widgets/heritage_top_nav.dart';
import '../widgets/heritage_bottom_nav.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const HeritageTopNav(title: "AEVUM", showBack: false),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeHeader(),
                const SizedBox(height: 24),
                _buildQuickActions(context),
                const SizedBox(height: 24),
                _buildRecentMemories(context),
                const SizedBox(height: 24),
                _buildFamilyStatus(),
                const SizedBox(height: 24),
                _buildAIInsights(context),
                const SizedBox(height: 24),
                _buildInfrastructureStatus(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const HeritageBottomNav(selectedIndex: 0),
    );
  }

  Widget _buildWelcomeHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Evening,",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
            const Text(
              "Eleanor",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionItem(context, Icons.person_add, "Invite", Colors.blue,
            () => context.push('/invite')),
        _actionItem(context, Icons.upload_file, "Upload", Colors.purple,
            () => context.push('/upload')),
        _actionItem(context, Icons.mic, "Story", Colors.orange,
            () => context.push('/family-branches')),
        _actionItem(context, Icons.search, "Search", Colors.teal,
            () => context.push('/search')),
      ],
    );
  }

  Widget _actionItem(BuildContext context, IconData icon, String label,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildRecentMemories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Recent Memories",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () => context.push('/memories'),
              child: const Text("View All"),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => context.push(
                  '/media-detail',
                  extra: 'https://picsum.photos/400/600?random=$index',
                ),
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://picsum.photos/400/600?random=$index'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFamilyStatus() {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircularProgressIndicator(
              value: 0.75,
              backgroundColor: Colors.white10,
              color: Colors.greenAccent,
            ),
            const SizedBox(width: 16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Family Tree Status",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text("1,240 Members • 75% Verified",
                    style: TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAIInsights(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/ai-chronicles'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade900, Colors.blue.shade900],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.amber),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("AI Discovery Found",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("We found 3 new connections in the 1920 census records.",
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfrastructureStatus(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("System Health",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => context.push('/vault-health'),
                child: GlassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const Icon(Icons.security,
                            color: Colors.green, size: 28),
                        const SizedBox(height: 8),
                        const Text("Vault",
                            style: TextStyle(color: Colors.white70)),
                        const Text("Secure",
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => context.push('/cloud-redundancy'),
                child: GlassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const Icon(Icons.cloud_done,
                            color: Colors.blue, size: 28),
                        const SizedBox(height: 8),
                        const Text("Cloud",
                            style: TextStyle(color: Colors.white70)),
                        const Text("Synced",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
