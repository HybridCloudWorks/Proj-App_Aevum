import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminInfrastructureControlScreen extends StatelessWidget {
  const AdminInfrastructureControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1121),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1173d4),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shield, color: Colors.white, size: 16),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Infrastructure Control",
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "Secure Connection",
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.lock_outline,
              color: Colors.white54,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildStatsHeader(),
            const SizedBox(height: 24),
            _buildStorageStrategy(),
            const SizedBox(height: 24),
            _buildAIEngineOptimization(),
            const SizedBox(height: 24),
            _buildRedundancyLayer(),
            const SizedBox(height: 24),
            _buildSentinelProtocol(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsHeader() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            "UPTIME",
            "99.99%",
            "+0.01% vs last week",
            Icons.reorder,
            Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _statCard(
            "STORAGE",
            "42.8 GB",
            "",
            Icons.storage,
            const Color(0xFF1173d4),
            showProgress: true,
            progress: 0.7,
          ),
        ),
      ],
    );
  }

  Widget _statCard(
    String label,
    String value,
    String sub,
    IconData icon,
    Color color, {
    bool showProgress = false,
    double progress = 0,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Colors.white38,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          if (sub.isNotEmpty)
            Text(
              sub,
              style: GoogleFonts.manrope(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (showProgress) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withOpacity(0.05),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStorageStrategy() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.cloud_queue, color: Color(0xFF1173d4)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Storage Strategy",
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Bring Your Own Bucket (BYOB)",
                        style: GoogleFonts.manrope(
                          fontSize: 11,
                          color: Colors.white38,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "CONFIGURE",
                  style: GoogleFonts.manrope(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _providerTab("AWS S3", Icons.hexagon, true),
              const SizedBox(width: 12),
              _providerTab("AZURE", Icons.grid_view_rounded, false),
              const SizedBox(width: 12),
              _providerTab("GCP", Icons.cloud, false),
            ],
          ),
          const SizedBox(height: 24),
          _catalogingConsole(),
        ],
      ),
    );
  }

  Widget _providerTab(String name, IconData icon, bool isActive) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF1173d4).withOpacity(0.2)
              : Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? const Color(0xFF1173d4)
                : Colors.white.withOpacity(0.05),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : Colors.white38,
              size: 20,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: GoogleFonts.manrope(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: isActive ? Colors.white : Colors.white38,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _catalogingConsole() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "CATALOGING ENGINE",
                style: GoogleFonts.manrope(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: Colors.white38,
                  letterSpacing: 1,
                ),
              ),
              Text(
                "RUNNING_TASK_ID: 8FC2",
                style: GoogleFonts.manrope(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _consoleProgress(
            "Thumbnail Generation",
            "1,342 / 1,500",
            0.85,
            Colors.greenAccent,
          ),
          const SizedBox(height: 12),
          _consoleProgress(
            "AI Metadata Indexing",
            "Processing...",
            0.4,
            const Color(0xFF1173d4),
          ),
        ],
      ),
    );
  }

  Widget _consoleProgress(
    String label,
    String val,
    double progress,
    Color color,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.manrope(fontSize: 11, color: Colors.white70),
            ),
            Text(
              val,
              style: GoogleFonts.manrope(
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withOpacity(0.05),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildAIEngineOptimization() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1173d4).withOpacity(0.1),
            Colors.black.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFF1173d4).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "AI Engine Optimization",
                style: GoogleFonts.manrope(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1173d4).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "ACTIVE",
                  style: GoogleFonts.manrope(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1173d4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _toggleTab("Narrative v6.0", true)),
              const SizedBox(width: 12),
              Expanded(child: _toggleTab("Fact Check", false)),
            ],
          ),
          const SizedBox(height: 24),
          _accuracyChart(),
        ],
      ),
    );
  }

  Widget _toggleTab(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF1173d4).withOpacity(0.3)
            : Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? const Color(0xFF1173d4) : Colors.transparent,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.white38,
          ),
        ),
      ),
    );
  }

  Widget _accuracyChart() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _chartBar(40),
              _chartBar(60),
              _chartBar(30),
              _chartBar(80),
              _chartBar(55),
              _chartBar(90),
              _chartBar(45),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "98%",
              style: GoogleFonts.manrope(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Text(
              "Accuracy Score",
              style: GoogleFonts.manrope(fontSize: 10, color: Colors.white38),
            ),
          ],
        ),
      ],
    );
  }

  Widget _chartBar(double height) {
    return Container(
      width: 12,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF1173d4).withOpacity(0.4),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildRedundancyLayer() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Redundancy Layer",
                style: GoogleFonts.manrope(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Icon(Icons.cloud_sync, color: Colors.white38, size: 20),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _networkNode("US-East", false),
              _nodeConnector(true),
              _networkNode("Core", true, isMain: true),
              _nodeConnector(false),
              _networkNode("EU-West", false, isWarn: true),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.greenAccent,
                  size: 16,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Mirroring active across 3 zones. Latency 24ms.",
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _networkNode(
    String label,
    bool isActive, {
    bool isMain = false,
    bool isWarn = false,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMain
                ? const Color(0xFF1173d4).withOpacity(0.2)
                : Colors.white.withOpacity(0.05),
            shape: BoxShape.circle,
            border: Border.all(
              color: isMain
                  ? const Color(0xFF1173d4)
                  : (isWarn ? Colors.orangeAccent : Colors.transparent),
            ),
          ),
          child: Icon(
            isMain ? Icons.hub : Icons.cloud,
            color: isMain
                ? const Color(0xFF1173d4)
                : (isWarn ? Colors.orangeAccent : Colors.white38),
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isMain ? Colors.white : Colors.white38,
          ),
        ),
      ],
    );
  }

  Widget _nodeConnector(bool isActive) {
    return Container(
      width: 40,
      height: 1.5,
      color: isActive
          ? const Color(0xFF1173d4).withOpacity(0.5)
          : Colors.white10,
    );
  }

  Widget _buildSentinelProtocol() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sentinel Protocol",
                style: GoogleFonts.manrope(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Icon(Icons.security, color: Colors.white38, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          _securityToggle(
            Icons.enhanced_encryption,
            "E2E Encryption",
            "AES-256 Enabled",
          ),
          const SizedBox(height: 12),
          _securityToggle(
            Icons.face_unlock,
            "Biometric Lock",
            "FaceID Required",
          ),
          const SizedBox(height: 24),
          Text(
            "ACCESS LOG",
            style: GoogleFonts.manrope(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: Colors.white38,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          _accessLogBox(),
          const SizedBox(height: 20),
          Center(
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.history, size: 16),
              label: Text(
                "View Audit History",
                style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
              ),
              style: TextButton.styleFrom(foregroundColor: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _securityToggle(IconData icon, String title, String sub) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white70, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  sub,
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: true,
            onChanged: (v) {},
            activeColor: const Color(0xFF1173d4),
          ),
        ],
      ),
    );
  }

  Widget _accessLogBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _logLine(
            "18:42:35",
            "LogIn: Admin (Pack32) verified",
            Colors.greenAccent,
          ),
          const SizedBox(height: 6),
          _logLine("18:41:02", "System check: Integrity 100%", Colors.white70),
          const SizedBox(height: 6),
          _logLine(
            "09:35:11",
            "Sync: US-East -> Core complete",
            Colors.white70,
          ),
          const SizedBox(height: 6),
          _logLine(
            "08:20:05",
            "Warn: Latency spike EU-West",
            Colors.orangeAccent,
          ),
        ],
      ),
    );
  }

  Widget _logLine(String time, String msg, Color color) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.fira_code(fontSize: 10),
        children: [
          TextSpan(
            text: "$time  ",
            style: const TextStyle(color: Colors.white24),
          ),
          TextSpan(
            text: msg,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
