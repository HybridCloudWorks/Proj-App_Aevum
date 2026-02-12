import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminCatalogEngineScreen extends StatelessWidget {
  const AdminCatalogEngineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D121D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1173d4).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.grid_view_rounded,
            color: Color(0xFF1173d4),
            size: 18,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Aevum Engine",
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "V1.4 // BUILD 892",
              style: GoogleFonts.manrope(
                fontSize: 9,
                color: Colors.white24,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        actions: [_onlineBadge(), const SizedBox(width: 16)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Cataloging &\nIndexing",
              style: GoogleFonts.manrope(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 32),
            _buildStorageSection(),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "INDEXED",
                    "14,203",
                    "+120 today",
                    Icons.folder_open,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildProgressCard(
                    "VOLUME",
                    "452",
                    "GB",
                    "of 1.2TB Allocation",
                    0.4,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildNeuralProcessingSection(),
            const SizedBox(height: 24),
            _buildSemanticReadiness(),
            const SizedBox(height: 24),
            _buildSystemLog(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _onlineBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF10B981),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            "ONLINE",
            style: GoogleFonts.manrope(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF10B981),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "STORAGE PATH",
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Colors.white24,
                  letterSpacing: 1,
                ),
              ),
              const Icon(
                Icons.cloud_done_rounded,
                color: Color(0xFF1173d4),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "High-Res Vault",
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "https://images.unsplash.com/photo-1558494949-ef010cbdcc51?w=600",
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Throughput",
                          style: GoogleFonts.manrope(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white38,
                          ),
                        ),
                        Text(
                          "45 MB/s",
                          style: GoogleFonts.manrope(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF1173d4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                        value: 0.6,
                        backgroundColor: Colors.white10,
                        valueColor: AlwaysStoppedAnimation(Color(0xFF1173d4)),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.storage, color: Colors.white38, size: 16),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AWS S3 (us-east-1)",
                        style: GoogleFonts.manrope(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        "ManagedCloud - Encrypted",
                        style: GoogleFonts.manrope(
                          fontSize: 9,
                          color: Colors.white24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1173d4),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String val, String sub, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.manrope(
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: Colors.white24,
                  letterSpacing: 1,
                ),
              ),
              Icon(icon, color: Colors.white10, size: 14),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            val,
            style: GoogleFonts.manrope(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.trending_up, color: Color(0xFF10B981), size: 12),
              const SizedBox(width: 4),
              Text(
                sub,
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(
    String label,
    String val,
    String unit,
    String sub,
    double progress,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.manrope(
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: Colors.white24,
                  letterSpacing: 1,
                ),
              ),
              const Icon(
                Icons.analytics_outlined,
                color: Colors.white10,
                size: 14,
              ),
            ],
          ),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: val,
                  style: GoogleFonts.manrope(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),
                TextSpan(
                  text: " $unit",
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sub,
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white24,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation(Colors.white30),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeuralProcessingSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.hub_rounded,
                    color: Color(0xFF1173d4),
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Neural Processing",
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1173d4).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "ACTIVE",
                  style: GoogleFonts.manrope(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1173d4),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _neuralStep(
            "EXIF Extraction",
            "Parsing metadata, geolocation, and device headers.",
            "1.2ms",
            true,
          ),
          _neuralStep(
            "WebP Optimization",
            "85% Ratio",
            "Active",
            true,
            isMiddle: true,
          ),
          _neuralStep(
            "Vector Embedding",
            "Generating 1536-dim vectors",
            "Queue: 4",
            false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _neuralStep(
    String title,
    String desc,
    String stat,
    bool isDone, {
    bool isMiddle = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDone ? const Color(0xFF1173d4) : Colors.white10,
                    width: 2,
                  ),
                  color: isDone
                      ? const Color(0xFF1173d4).withOpacity(0.2)
                      : Colors.transparent,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      stat,
                      style: GoogleFonts.manrope(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: isDone
                            ? const Color(0xFF10B981)
                            : Colors.white24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    color: Colors.white24,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSemanticReadiness() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              value: 0.95,
              strokeWidth: 8,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF1173d4)),
              strokeCap: StrokeCap.round,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Semantic Readiness",
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Search index is healthy and optimized.",
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemLog() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "SYSTEM LOG",
                style: GoogleFonts.firaCode(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.white24,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _logLine(
            "14:23:04",
            "[IMG_2931]",
            "Upload complete",
            const Color(0xFF1173d4),
          ),
          _logLine(
            "14:23:02",
            "[IMG_2931]",
            "EXIF: lat:40.7128, long:-74.0060",
            const Color(0xFF1173d4),
          ),
          _logLine(
            "14:23:01",
            "[IMG_2930]",
            "Vector embedding generated",
            const Color(0xFFA855F7),
          ),
          _logLine(
            "14:22:58",
            "STATUS",
            "Index update: +1 item",
            const Color(0xFF10B981),
          ),
        ],
      ),
    );
  }

  Widget _logLine(String time, String tag, String msg, Color tagColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.firaCode(fontSize: 10, height: 1.5),
          children: [
            TextSpan(
              text: "$time ",
              style: const TextStyle(color: Colors.white24),
            ),
            TextSpan(
              text: "$tag ",
              style: TextStyle(color: tagColor, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: msg,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 80,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1173d4).withOpacity(0.05),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.home_outlined, color: Colors.white24),
          const Icon(Icons.search, color: Colors.white24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF1173d4),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const Icon(Icons.grid_view_outlined, color: Colors.white),
          const Icon(Icons.settings_outlined, color: Colors.white24),
        ],
      ),
    );
  }
}
