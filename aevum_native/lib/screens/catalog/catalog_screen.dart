import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../widgets/glass_card.dart';
import '../../theme/app_theme.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.grid_view, color: AppTheme.primary, size: 24),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Aevum Engine',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.0,
                                ),
                              ),
                              Text(
                                'V2.4 // BUILD 892',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[400],
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.green.withOpacity(0.2)),
                        ),
                        child: Row(
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
                              'ONLINE',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Cataloging &\nIndexing',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    child: Column(
                      children: [
                        // Storage Path Card
                        GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.white.withOpacity(0.03),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'STORAGE PATH',
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[400],
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                      Text(
                                        'High-Res Vault',
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.cloud_upload, color: AppTheme.primary.withOpacity(0.8)),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                height: 128,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white.withOpacity(0.05),
                                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                                  image: const DecorationImage(
                                    image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDboHInGxe63iPNEbsLh5xcXR14DFxxtfFKFe1r9GmUhnoM1lP1df3ePk9RHUUAgVSomUQFxFpHJFEtbbRWw2bYzoXMNVRTwkY4_JnkLvJlXT4JL939aD64el3ZFOXfNqK-NeGzlPxXVs_4RtjvqmytIM2wlrfd7mrXAV_oO_E6PWFwALHdJvEqVBg8tnsdIk4hWpT3ItAo8jwamk51MXQGFZbVbQfiKsvMmkhJWjJdmBJt8F6BsPELRcTU38Oqhyv47O5rjOCrgm4'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [const Color(0xFF101922).withOpacity(0.9), Colors.transparent],
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Throughput', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.white70)),
                                          Text('45 MB/s', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: AppTheme.primary)),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(999),
                                        child: LinearProgressIndicator(
                                          value: 0.75,
                                          backgroundColor: Colors.white.withOpacity(0.1),
                                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                                          minHeight: 4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.dns, size: 14, color: Colors.grey),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('AWS S3 (us-east-1)', style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                                            Text('Managed Cloud • Encrypted', style: GoogleFonts.spaceGrotesk(fontSize: 8, color: Colors.grey)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: AppTheme.primary,
                                        shape: BoxShape.circle,
                                        boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.6), blurRadius: 8)],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Stats Grid
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('INDEXED', style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                                          const Icon(Icons.perm_media, size: 14, color: Colors.grey),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('14,203', style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                                          Row(
                                            children: [
                                              const Icon(Icons.trending_up, size: 12, color: Colors.green),
                                              const SizedBox(width: 4),
                                              Text('+120 today', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.green)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('VOLUME', style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                                          const Icon(Icons.storage, size: 14, color: Colors.grey),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: '452',
                                              style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                                              children: [TextSpan(text: 'GB', style: TextStyle(fontSize: 14, color: Colors.grey[500]))],
                                            ),
                                          ),
                                          Text('Of 2TB Allocation', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.grey[400])),
                                          const SizedBox(height: 4),
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(999),
                                            child: LinearProgressIndicator(
                                              value: 0.22,
                                              backgroundColor: Colors.white.withOpacity(0.1),
                                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.grey),
                                              minHeight: 4,
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

                        const SizedBox(height: 16),

                        // Neural Processing
                        GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.white.withOpacity(0.03),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.psychology, color: AppTheme.primary, size: 18),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Neural Processing',
                                        style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
                                    ),
                                    child: Text('ACTIVE', style: GoogleFonts.spaceMono(fontSize: 10, color: AppTheme.primary)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Stack(
                                children: [
                                  Positioned(left: 7, top: 8, bottom: 8, width: 1, child: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppTheme.primary, AppTheme.primary.withOpacity(0.2), Colors.transparent])))),
                                  Column(
                                    children: [
                                      _buildStep('EXIF Extraction', '12ms', 'Parsing metadata, geolocation...', isDone: true),
                                      const SizedBox(height: 20),
                                      _buildStep('WebP Optimization', '85% Ratio', null, isDone: true, showImages: true),
                                      const SizedBox(height: 20),
                                      _buildStep('Vector Embedding', 'Queue: 4', 'Generative 1536-dim vectors', isDone: false),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Semantic Readiness
                        GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.white.withOpacity(0.03),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 48,
                                height: 48,
                                child: Stack(
                                  children: [
                                    const CircularProgressIndicator(
                                      value: 0.98,
                                      strokeWidth: 4,
                                      backgroundColor: Colors.white10,
                                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
                                    ),
                                    Center(child: Text('98%', style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white))),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Semantic Readiness', style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                                    Text('Search index is healthy and optimized.', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.grey[400])),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Terminal
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withOpacity(0.05)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                                  const SizedBox(width: 4),
                                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.yellow, shape: BoxShape.circle)),
                                  const SizedBox(width: 4),
                                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                                  const SizedBox(width: 8),
                                  Text('SYSTEM LOG', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              _buildLogLine('14:23:01', '[IMG_2901] Upload complete', Colors.blue),
                              _buildLogLine('14:23:02', '[IMG_2901] EXIF: lat:40.7128, long:-74.0060', Colors.blue),
                              _buildLogLine('14:23:04', '[IMG_2900] Vector embedding generated', Colors.purple),
                              _buildLogLine('14:23:05', 'Index update: +1 item', Colors.green),
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

          // Floating Nav
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
              height: 64,
              constraints: const BoxConstraints(maxWidth: 380),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 30, offset: const Offset(0, 4))],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.home, color: Colors.grey),
                      const Icon(Icons.search, color: Colors.grey),
                      Container(
                        width: 48,
                        height: 48,
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF101922), width: 4),
                          boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.5), blurRadius: 15)],
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.grid_view, color: Colors.white, size: 20),
                      ),
                      const Icon(Icons.settings, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String title, String status, String? desc, {required bool isDone, bool showImages = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4, right: 12),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: const Color(0xFF101922),
            shape: BoxShape.circle,
            border: Border.all(color: isDone ? AppTheme.primary : Colors.grey[700]!, width: 2),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(status, style: GoogleFonts.spaceMono(fontSize: 10, color: isDone ? Colors.green : Colors.grey)),
                ],
              ),
              if (desc != null)
                Text(desc, style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.grey[400])),
              if (showImages)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: const Icon(Icons.image, size: 14, color: Colors.white24),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.arrow_right_alt, size: 16, color: Colors.grey),
                      ),
                      Container(
                        width: 40,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppTheme.primary.withOpacity(0.3)),
                        ),
                        child: const Icon(Icons.image, size: 14, color: AppTheme.primary),
                      ),
                    ],
                  ),
                ),
              if (!isDone && desc != null && desc.contains('1536-dim')) // Hack for vector embedding step progress
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: 0.65,
                      backgroundColor: Colors.white.withOpacity(0.05),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
                      minHeight: 4,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogLine(String time, String text, Color timeColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: RichText(
        text: TextSpan(
          text: '$time ',
          style: GoogleFonts.spaceMono(fontSize: 10, color: timeColor),
          children: [
            TextSpan(text: text, style: TextStyle(color: Colors.grey[400])),
          ],
        ),
      ),
    );
  }
}
