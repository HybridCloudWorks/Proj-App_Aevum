import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../widgets/glass_card.dart';
import '../../theme/app_theme.dart';

class AdminInfrastructure1 extends StatefulWidget {
  const AdminInfrastructure1({Key? key}) : super(key: key);

  @override
  State<AdminInfrastructure1> createState() => _AdminInfrastructure1State();
}

class _AdminInfrastructure1State extends State<AdminInfrastructure1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          // Ambient Glow
          Positioned(
            top: 100,
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

          // Main Content
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [AppTheme.primary.withOpacity(0.2), const Color(0xFF8B5CF6).withOpacity(0.2)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white.withOpacity(0.05)),
                            ),
                            child: const Icon(Icons.rocket_launch, color: AppTheme.primary, size: 24),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deployment',
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
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981), // success
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(color: const Color(0xFF10B981).withOpacity(0.7), blurRadius: 4),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Live: Alpha v0.9.2',
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
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.notifications, color: Colors.grey[400], size: 20),
                      ),
                    ],
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    child: Column(
                      children: [
                        // Current Build Card
                        GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.white.withOpacity(0.03),
                          borderColor: Colors.white.withOpacity(0.08),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'CURRENT BUILD',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[400],
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
                                    ),
                                    child: Text(
                                      'PASSING',
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 10,
                                        color: const Color(0xFF10B981),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'build-8924x',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  text: 'Commit: ',
                                  style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.grey[400]),
                                  children: [
                                    TextSpan(
                                      text: '7f2a9c',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    const TextSpan(text: ' • Master Branch'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildProgressBar('Unit Tests', '142/142', 1.0, const Color(0xFF10B981)),
                              const SizedBox(height: 12),
                              _buildProgressBar('Integration', 'Running...', 0.65, AppTheme.primary, animated: true),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Grid: App Store & Testers
                        Row(
                          children: [
                            Expanded(
                              child: GlassCard(
                                borderRadius: 16,
                                padding: const EdgeInsets.all(16),
                                backgroundColor: Colors.white.withOpacity(0.03),
                                child: SizedBox(
                                  height: 120,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.ios_share, size: 18, color: Colors.grey[400]),
                                          const SizedBox(width: 8),
                                          Text(
                                            'APP STORE',
                                            style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Syncing', style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                                          Text('Processing binary...', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.grey[400])),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              const Icon(Icons.sync, size: 12, color: AppTheme.primary),
                                              const SizedBox(width: 4),
                                              Text('Estimated 4m', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: AppTheme.primary)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GlassCard(
                                borderRadius: 16,
                                padding: const EdgeInsets.all(16),
                                backgroundColor: Colors.white.withOpacity(0.03),
                                child: SizedBox(
                                  height: 120,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.group_add, size: 18, color: Colors.grey[400]),
                                          const SizedBox(width: 8),
                                          Text(
                                            'TESTERS',
                                            style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text('128', style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                                              const SizedBox(width: 4),
                                              Text('+12%', style: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF10B981))),
                                            ],
                                          ),
                                          Text('Active Alpha Users', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.grey[400])),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            height: 20,
                                            child: Stack(
                                              children: [
                                                Container(width: 20, height: 20, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[700], border: Border.all(color: Colors.grey[800]!))),
                                                Positioned(left: 14, child: Container(width: 20, height: 20, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[600], border: Border.all(color: Colors.grey[800]!)))),
                                                Positioned(left: 28, child: Container(width: 20, height: 20, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[500], border: Border.all(color: Colors.grey[800]!)))),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Crash Analytics
                        GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.white.withOpacity(0.03),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.bug_report, size: 18, color: Colors.grey[400]),
                                      const SizedBox(width: 8),
                                      Text(
                                        'CRASH ANALYTICS',
                                        style: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                                      ),
                                    ],
                                  ),
                                  Text('Last 24h', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.grey[500])),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Bar Chart Placeholder
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _buildBar(0.2),
                                  _buildBar(0.4),
                                  _buildBar(0.1),
                                  _buildBar(0.3),
                                  _buildBar(0.8, isPeak: true),
                                  _buildBar(0.25),
                                  _buildBar(0.15),
                                  _buildBar(0.05),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.trending_down, size: 14, color: Color(0xFF10B981)),
                                      const SizedBox(width: 4),
                                      Text('99.8% Stability', style: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF10B981))),
                                    ],
                                  ),
                                  Text('0 Critical', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.grey[500])),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Alpha Feedback
                        GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.white.withOpacity(0.03),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.forum, size: 18, color: Colors.grey[400]),
                                      const SizedBox(width: 8),
                                      Text(
                                        'ALPHA FEEDBACK',
                                        style: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                                      ),
                                    ],
                                  ),
                                  Text('View All', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: AppTheme.primary)),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _buildFeedbackItem('JD', Colors.orange, 'UI Glitch in Family Tree', 'The connecting lines disappear...', '2m ago'),
                              const SizedBox(height: 12),
                              _buildFeedbackItem('AS', Colors.blue, 'Photo Upload Failed', 'Getting a 504 error...', '1h ago'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Actions
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFF0F172A), Color(0xF20F172A), Colors.transparent],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
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
                              Text('Rollback', style: GoogleFonts.spaceGrotesk(color: Colors.grey[300], fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444), // danger
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: const Color(0xFFEF4444).withOpacity(0.3), blurRadius: 20)],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.emergency, color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              Text('Deploy Hotfix', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Production environment: eu-central-1',
                    style: GoogleFonts.spaceMono(fontSize: 10, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(String label, String value, double progress, Color color, {bool animated = false}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.grey[300])),
            Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: animated ? Colors.white : const Color(0xFF10B981))),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(999),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBar(double heightFactor, {bool isPeak = false}) {
    return Expanded(
      child: Container(
        height: 64 * heightFactor,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isPeak ? AppTheme.primary.withOpacity(0.8) : Colors.white.withOpacity(0.05),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
        ),
      ),
    );
  }

  Widget _buildFeedbackItem(String initials, Color color, String title, String subtitle, String time) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Center(
              child: Text(initials, style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
                    Text(time, style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.grey[500])),
                  ],
                ),
                Text(subtitle, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.grey[400]), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
