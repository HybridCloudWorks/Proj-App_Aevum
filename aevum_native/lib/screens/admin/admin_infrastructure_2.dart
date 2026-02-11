import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../widgets/glass_card.dart';
import '../../theme/app_theme.dart';

class AdminInfrastructure2 extends StatefulWidget {
  const AdminInfrastructure2({Key? key}) : super(key: key);

  @override
  State<AdminInfrastructure2> createState() => _AdminInfrastructure2State();
}

class _AdminInfrastructure2State extends State<AdminInfrastructure2> {
  bool _e2eEncryption = true;
  bool _biometricLock = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          // Ambient Glow
          Positioned(
            top: 200,
            left: MediaQuery.of(context).size.width / 2 - 150,
            width: 300,
            height: 300,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Color(0x261173D4), Color(0x0D8B5CF6), Colors.transparent],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.verified_user, color: AppTheme.primary, size: 24),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Infrastructure Control',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Colors.teal,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Secure Connection',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Icon(Icons.lock, color: Colors.grey[400], size: 20),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // System Status Grid
                        Row(
                          children: [
                            Expanded(
                              child: GlassCard(
                                borderRadius: 16,
                                padding: const EdgeInsets.all(16),
                                backgroundColor: Colors.white.withOpacity(0.03),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.show_chart, color: AppTheme.primary, size: 20), // activity_zone
                                        const SizedBox(width: 8),
                                        Text('UPTIME', style: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[400])),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text('99.99%', style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                                    Text('+0.01% vs last week', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.teal, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: GlassCard(
                                borderRadius: 16,
                                padding: const EdgeInsets.all(16),
                                backgroundColor: Colors.white.withOpacity(0.03),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.dns, color: AppTheme.primary, size: 20), // database
                                        const SizedBox(width: 8),
                                        Text('STORAGE', style: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[400])),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text('42.8 GB', style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                                    const SizedBox(height: 4),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(999),
                                      child: LinearProgressIndicator(
                                        value: 0.45,
                                        backgroundColor: Colors.white.withOpacity(0.1),
                                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                                        minHeight: 6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // AI Engine Optimization
                        GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.white.withOpacity(0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'AI Engine Optimization',
                                        style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      Text(
                                        'Generative Model Configuration',
                                        style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.grey[400]),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primary.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: AppTheme.primary.withOpacity(0.3)),
                                    ),
                                    child: Text('ACTIVE', style: GoogleFonts.spaceMono(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Model Selector
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primary.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(color: AppTheme.primary.withOpacity(0.3)),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text('Narrative v4.0', style: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        alignment: Alignment.center,
                                        child: Text('Fact Check', style: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey[400])),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Processing Load', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.grey[400])),
                                        const SizedBox(height: 4),
                                        SizedBox(
                                          height: 64,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              _buildBar(0.4),
                                              _buildBar(0.6),
                                              _buildBar(0.3),
                                              _buildBar(0.75),
                                              _buildBar(0.5, isPeak: true),
                                              _buildBar(0.8),
                                              _buildBar(0.45),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: '98',
                                          style: GoogleFonts.spaceGrotesk(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                                          children: [TextSpan(text: '%', style: TextStyle(fontSize: 18, color: Colors.grey[400]))],
                                        ),
                                      ),
                                      Text('Accuracy Score', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.grey[400])),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Redundancy Layer
                        GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.white.withOpacity(0.03),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Redundancy Layer',
                                    style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  const Icon(Icons.cloud_sync, color: Colors.grey),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildNode(Icons.cloud, 'US-East', Colors.teal),
                                  Expanded(child: Container(height: 1, color: AppTheme.primary.withOpacity(0.5))),
                                  _buildNode(Icons.hub, 'Core', Colors.teal, isCenter: true),
                                  Expanded(child: Container(height: 1, color: AppTheme.primary.withOpacity(0.5))),
                                  _buildNode(Icons.cloud_queue, 'EU-West', Colors.amber),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_circle, size: 16, color: Colors.teal),
                                    const SizedBox(width: 8),
                                    Text('Mirroring active across 3 zones. Latency 24ms.', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.grey[300])),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Security Protocol
                        GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.white.withOpacity(0.03),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sentinel Protocol',
                                    style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  const Icon(Icons.verified_user, color: Colors.grey),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildToggle('E2E Encryption', 'AES-256 Enabled', Icons.key, AppTheme.primary, _e2eEncryption, (v) => setState(() => _e2eEncryption = v)),
                              const SizedBox(height: 12),
                              _buildToggle('Biometric Lock', 'FaceID Required', Icons.fingerprint, Colors.amber, _biometricLock, (v) => setState(() => _biometricLock = v)),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('ACCESS LOG', style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[500], letterSpacing: 1.0)),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 112,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                                ),
                                child: Column(
                                  children: [
                                    _buildLogLine('10:42:15', 'Login: Admin (FaceID) verified', Colors.tealAccent),
                                    _buildLogLine('10:41:02', 'System check: Integrity 100%', Colors.grey[300]!),
                                    _buildLogLine('09:15:22', 'Sync: US-East -> Core complete', Colors.grey[300]!),
                                    _buildLogLine('08:30:05', 'Warn: Latency spike EU-West', Colors.amberAccent),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Bottom Button
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.history, color: Colors.grey, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'View Audit History',
                                style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
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

  Widget _buildBar(double heightFactor, {bool isPeak = false}) {
    return Expanded(
      child: Container(
        height: 64 * heightFactor,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isPeak ? AppTheme.primary : AppTheme.primary.withOpacity(0.3 + (heightFactor * 0.4)),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildNode(IconData icon, String label, Color statusColor, {bool isCenter = false}) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: isCenter ? 56 : 48,
              height: isCenter ? 56 : 48,
              decoration: BoxDecoration(
                color: isCenter ? AppTheme.primary.withOpacity(0.2) : Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
                border: Border.all(color: isCenter ? AppTheme.primary.withOpacity(0.5) : Colors.white.withOpacity(0.1)),
                boxShadow: isCenter ? [BoxShadow(color: AppTheme.primary.withOpacity(0.3), blurRadius: 15)] : [],
              ),
              child: Icon(icon, color: Colors.white, size: isCenter ? 28 : 24),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0F172A), width: 2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 10,
            fontWeight: isCenter ? FontWeight.bold : FontWeight.normal,
            color: isCenter ? Colors.white : Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildToggle(String title, String subtitle, IconData icon, Color iconColor, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(subtitle, style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.grey[400])),
                ],
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildLogLine(String time, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Text(time, style: GoogleFonts.spaceMono(fontSize: 10, color: color.withOpacity(0.5))),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: GoogleFonts.spaceMono(fontSize: 10, color: color), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
