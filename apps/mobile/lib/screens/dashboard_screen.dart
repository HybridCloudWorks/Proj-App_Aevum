import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:aevum_native/widgets/smart_navigation_wrapper.dart';
import 'package:aevum_native/widgets/heritage_bottom_nav.dart';
import 'package:aevum_native/widgets/heritage_top_nav.dart';
import 'package:aevum_native/services/database_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      body: SmartNavigationWrapper(
        topNav: const HeritageTopNav(
          title: "AEVUM",
          subtitle: "Preserving your legacy",
          showBack: false,
        ),
        bottomNav: const HeritageBottomNav(activeIndex: 0),
        child: Stack(
          children: [
            _buildBackdrop(),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const SizedBox(height: 80), // Spacer for topNav
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          _buildHeroCard(context),
                          const SizedBox(height: 16),
                          _buildBentoGrid(context),
                          const SizedBox(height: 16),
                          _buildMemoriesSection(),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackdrop() {
    return Stack(
      children: [
        // Blue blob top-left
        Positioned(
          top: -100,
          left: -100,
          child: _blurBlob(const Color(0xFF2563EB).withValues(alpha: 0.3), 300),
        ),
        // Purple blob bottom-right
        Positioned(
          bottom: -100,
          right: -100,
          child: _blurBlob(const Color(0xFF9333EA).withValues(alpha: 0.3), 300),
        ),
        // Pink blob mid-left
        Positioned(
          top: 200,
          left: -50,
          child: _blurBlob(const Color(0xFFEC4899).withValues(alpha: 0.2), 250),
        ),
        // Overlay
        Positioned.fill(
          child: Container(color: Colors.black.withValues(alpha: 0.1)),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }

  Widget _blurBlob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        color: Colors.white.withValues(alpha: 0.03),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background Image/Visualization
            Positioned.fill(
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuCPahOG810tTA0CDJ7hQ78KbqeMIHCm353JThEuV8KMDo6TMp0GE5bt2WCvf0aOGkzAAuXqC_GK5Hf_1M_e_XTmBVoYw7wFLaIde2L2Dn2NZF3N4Y3Fve7iqCFFFwyw3IydRYQvrSYh8RJL03rL6xX5A4y6Pj8KxVvzqybyLwFAUBwkuKWtKsiSiodFj77JYYwJOA2zzf69Dc-kk28VcIE7TULK8C8xSQkOLqoO9cPQ2idl1OwX55upHy-wWdt1pm0sDlb7h-CSPYs",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // Botanical Mesh Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color(0xFF101922).withValues(alpha: 0.9),
                      const Color(0xFF101922).withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1173D4).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(
                              0xFF1173D4,
                            ).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          "QUICK PAN",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF60A5FA),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const Spacer(),
                      _heroActionIcon(
                        context,
                        Icons.search,
                        () => Navigator.pushNamed(context, '/search'),
                      ),
                      const SizedBox(width: 8),
                      _heroActionIcon(
                        context,
                        Icons.add_circle_outline,
                        () => Navigator.pushNamed(context, '/plant-branch'),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "Family Tree",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                      letterSpacing: -1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.update, color: Colors.white30, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        "Last edited 2h ago by Sarah",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, '/tree'),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "ENTER EXPLORER",
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heroActionIcon(
    BuildContext context,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Icon(icon, color: Colors.white70, size: 18),
      ),
    );
  }

  Widget _buildBentoGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Growth Card
            Expanded(
              child: StreamBuilder<int>(
                stream: DatabaseService().getMemberCountStream(),
                builder: (context, snapshot) {
                  final count = snapshot.data ?? 0;
                  return Container(
                    height: 176, // h-44
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -16,
                          right: -16,
                          child: Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.spa,
                                  color: Colors.greenAccent,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "GROWTH",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200],
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  count.toString(),
                                  style: GoogleFonts.publicSans(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: -1.0,
                                    height: 1,
                                  ),
                                ),
                                Text(
                                  "Members added",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                            // Progress
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 6,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: (count / 50).clamp(0.05, 1.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "+$count this month",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            // AI Tasks Card
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: DatabaseService().getAITasksStream(),
                builder: (context, snapshot) {
                  final tasks = snapshot.data ?? [];
                  final task = tasks.isNotEmpty ? tasks.first : null;

                  return GestureDetector(
                    onTap: () {
                      if (tasks.isEmpty) {
                        DatabaseService().createMockTask();
                      } else {
                        Navigator.pushNamed(context, '/vault-health');
                      }
                    },
                    child: Container(
                      height: 176, // h-44
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -16,
                            left: -16,
                            child: Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                color: Colors.purple.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 20,
                                  sigmaY: 20,
                                ),
                                child: Container(color: Colors.transparent),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.auto_fix_high,
                                        color: Colors.purpleAccent,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "AI TASKS",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[200],
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: tasks.isEmpty
                                          ? Colors.grey[600]
                                          : Colors.red[500],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      tasks.length.toString(),
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Task Item
                              if (task != null)
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.05,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[600],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Image.network(
                                            task['imageUrl'] ?? "",
                                            fit: BoxFit.cover,
                                            color: Colors.white.withValues(
                                              alpha: 0.8,
                                            ),
                                            colorBlendMode: BlendMode.modulate,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              task['title'] ?? "Unknown",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              task['type'] ?? "Processing",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.purple[200],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Text(
                                  "No pending tasks",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    color: Colors.white38,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              // Button
                              GestureDetector(
                                onTap: task != null
                                    ? () {
                                        DatabaseService().updateTaskStatus(
                                          task['id'],
                                          "running",
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Restoration started...",
                                            ),
                                          ),
                                        );
                                      }
                                    : () => DatabaseService().createMockTask(),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.purple.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      task != null
                                          ? "START RESTORE"
                                          : "CREATE TASK",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple[100],
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Additional Grid Items (Invite/Record)
        Row(
          children: [
            Expanded(
              child: _glassActionCard(
                Icons.person_add,
                Colors.blueAccent,
                "INVITE",
                "to Aevum",
                Colors.blue[500]!.withValues(alpha: 0.2),
                Colors.blue[400]!,
                onTap: () => _showInvitePopup(context),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _glassActionCard(
                Icons.shield,
                const Color(0xFF00E0FF),
                "VAULT",
                "Status & Sync",
                const Color(0xFF00E0FF).withValues(alpha: 0.1),
                const Color(0xFF00E0FF),
                onTap: () => Navigator.pushNamed(context, '/cloud-redundancy'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // New Row: Messages & Favorites
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: _buildMessagesCard(context)),
            const SizedBox(width: 16),
            Expanded(flex: 2, child: _buildFavoritesCard(context)),
          ],
        ),
      ],
    );
  }

  Widget _buildMessagesCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/messenger'),
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.forum_rounded,
                        color: Colors.blueAccent,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "MESSAGES",
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[200],
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "2",
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF97316),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white24),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&h=100&fit=crop",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sarah",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "\"Did you see the photo I uploade...\"",
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.grey[400],
                            fontStyle: FontStyle.italic,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tagging/Favorites logic to be implemented
      },
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF472B6).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_rounded,
                color: Color(0xFFF472B6),
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "FAVORITES",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "View saved",
              style: GoogleFonts.montserrat(
                fontSize: 10,
                color: Colors.grey[400],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassActionCard(
    IconData icon,
    Color iconColor,
    String title,
    String sub,
    Color bg,
    Color textC, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 96, // roughly h-24
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
              child: Icon(icon, color: textC, size: 24),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  sub,
                  style: GoogleFonts.montserrat(
                    fontSize: 10,

                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoriesSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.history_edu,
                    color: Colors.orangeAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "RECENT MEMORIES",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[200],
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Text(
                "VIEW ALL",
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _memoryCard(
                  "1985",
                  "Summer Wedding",
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuDL0ASC5yYi1mDVBhtxP-NWj91-XxfHOUjRJ6xAx69QDglsj3aDqdKWm7cW75kCSWIFX5TjbgNY6SmkePMgb4ZXVHhOMhVUwCBSaXlJjvXb2UeomYB4IxzxWwGaeUkiTvNvFIFyDsPGQW_ca_rn0JU14iyPn5p83rabQcLsLow3LwHlTNOf3nXbFppOC1vE3XQIjJnYnpl-hjGoG3uZxRmH93UmPcLqEgcWK3v1oyX-tcrPXi3c8Ag2nJMC-SvVEuK0FzmGQ_X9yGo",
                ),
                const SizedBox(width: 12),
                _memoryCard(
                  "1992",
                  "First Grade",
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuAtpb0MC0tKaL9Q-459mrQe_yyMmwEgudC0PTs-yip4CCbJIli4jqQY_Fy23VplbWrUM0oF4zM2hvlX9z2yVZQaGTw4MZih0VO3XeRARLIEnWC-N1O145KuwhOFKZEA8A9vO-tPhktc-XaDZtks0OzL_rYm1GMuRxMoWGUg_nahXJpfgZi_Ru9Y89u-JnYZcBsyui2D1YCV2h5uYug2xIGbKlVgNtn0CEIWS1K0axWMAQyFaIKfK6kSi8Cexc0tGgU-VYdNrCsn884",
                ),
                const SizedBox(width: 12),
                _addMemoryCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _memoryCard(String year, String title, String url) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 128, // w-32
          height: 160, // h-40
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Text(
                  year,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 128,
          child: Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[300],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _addMemoryCard() {
    return Column(
      children: [
        Container(
          width: 128,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Center(
            child: Icon(
              Icons.add_a_photo,
              color: Colors.white.withValues(alpha: 0.5),
              size: 32,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Add New",
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  void _showInvitePopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: const Color(0xFF101922).withValues(alpha: 0.9),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  "Extend Your Living History",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Choose how you would like to grow your Aevum family tree today.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white60,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 32),
                _popupActionCard(
                  context,
                  icon: Icons.person_add,
                  title: "Family Member",
                  subtitle: "Invite an individual to your family tree",
                  color: const Color(0xFF1173D4),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/invite');
                  },
                ),
                const SizedBox(height: 16),
                _popupActionCard(
                  context,
                  icon: Icons.account_tree,
                  title: "Family Branch",
                  subtitle: "Create a new ancestral line or branch",
                  color: Colors.purpleAccent,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/family-branches');
                  },
                ),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Maybe Later",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _popupActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white24),
          ],
        ),
      ),
    );
  }
}
