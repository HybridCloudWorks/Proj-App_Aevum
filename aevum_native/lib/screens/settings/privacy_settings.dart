import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/glass_card.dart';
import '../../theme/app_theme.dart';

class PrivacySettings extends StatefulWidget {
  const PrivacySettings({Key? key}) : super(key: key);

  @override
  State<PrivacySettings> createState() => _PrivacySettingsState();
}

class _PrivacySettingsState extends State<PrivacySettings> {
  bool _biometricEnabled = true;
  int _visibilityValue = 0; // 0: Immediate, 1: Extended, 2: Public
  bool _dnaMatches = true;
  bool _treeUpdates = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0F172A), Color(0xFF1E1B4B)],
              ),
            ),
          ),

          // Decorative Orbs
          Positioned(
            top: -50,
            left: -50,
            width: 500,
            height: 500,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primary.withOpacity(0.1),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                      Text(
                        'Privacy & Security',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Save',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Top Grid
                        Row(
                          children: [
                            Expanded(
                              child: GlassCard(
                                borderRadius: 16,
                                padding: const EdgeInsets.all(16),
                                backgroundColor: Colors.white.withOpacity(0.05),
                                child: SizedBox(
                                  height: 128,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.05),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Icon(Icons.face, color: AppTheme.primary, size: 28),
                                          ),
                                          Switch(
                                            value: _biometricEnabled,
                                            onChanged: (v) => setState(() => _biometricEnabled = v),
                                            activeColor: AppTheme.primary,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Biometric Vault', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                                          Text('Secure with FaceID', style: GoogleFonts.inter(fontSize: 12, color: Colors.white54)),
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
                                backgroundColor: Colors.white.withOpacity(0.05),
                                child: SizedBox(
                                  height: 128,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.05),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: const Icon(Icons.phonelink_lock, color: Colors.tealAccent, size: 28),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.teal.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(999),
                                              border: Border.all(color: Colors.teal.withOpacity(0.2)),
                                            ),
                                            child: Text('Active', style: GoogleFonts.inter(fontSize: 12, color: Colors.tealAccent, fontWeight: FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('2-Step Verification', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                                          Text('Added security layer', style: GoogleFonts.inter(fontSize: 12, color: Colors.white54)),
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

                        // Archive Export
                        GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.white.withOpacity(0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.05),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.folder_zip, color: Colors.lightBlueAccent, size: 24),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Genealogy Archive', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                      Text('Export GEDCOM data', style: GoogleFonts.inter(fontSize: 14, color: Colors.white54)),
                                    ],
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primary,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                ),
                                child: Text('Export', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Personal Visibility
                        Row(
                          children: [
                            const Icon(Icons.visibility, color: Colors.white70, size: 20),
                            const SizedBox(width: 8),
                            Text('Personal Visibility', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        GlassCard(
                          borderRadius: 16,
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.white.withOpacity(0.05),
                          child: Column(
                            children: [
                              _buildVisibilityOption(0, Icons.diversity_1, Colors.indigoAccent, 'Immediate Family', 'Parents, Siblings, Children', 'Full Access'),
                              Divider(height: 1, color: Colors.white.withOpacity(0.05)),
                              _buildVisibilityOption(1, Icons.diversity_3, Colors.orangeAccent, 'Extended Family', 'Cousins, Aunts, Uncles', 'Limited'),
                              Divider(height: 1, color: Colors.white.withOpacity(0.05)),
                              _buildVisibilityOption(2, Icons.public_off, Colors.redAccent, 'Public', 'Strangers, Search Engines', 'Hidden'),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Notifications
                        Row(
                          children: [
                            const Icon(Icons.notifications, color: Colors.white70, size: 20),
                            const SizedBox(width: 8),
                            Text('Alert Preferences', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.white.withOpacity(0.05),
                          child: Column(
                            children: [
                              _buildToggleRow('DNA Matches', 'New genetic relatives found', _dnaMatches, (v) => setState(() => _dnaMatches = v)),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Divider(height: 1, color: Colors.white.withOpacity(0.1)),
                              ),
                              _buildToggleRow('Tree Updates', 'Changes by family members', _treeUpdates, (v) => setState(() => _treeUpdates = v)),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.delete, color: Colors.redAccent, size: 18),
                          label: Text('Delete Account & Data', style: GoogleFonts.inter(color: Colors.redAccent, fontWeight: FontWeight.w500)),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            backgroundColor: Colors.redAccent.withOpacity(0.1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Nav
                Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xB3111928),
                    border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.account_tree, 'Tree'),
                      _buildNavItem(Icons.search, 'Search'),
                      _buildNavItem(Icons.mail, 'Inbox'),
                      _buildNavItem(Icons.person, 'Profile', isActive: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisibilityOption(int value, IconData icon, Color color, String title, String subtitle, String status) {
    return InkWell(
      onTap: () => setState(() => _visibilityValue = value),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                  Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: Colors.white54)),
                ],
              ),
            ),
            if (MediaQuery.of(context).size.width > 360)
              Text(status, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: color)),
            const SizedBox(width: 12),
            Radio(
              value: value,
              groupValue: _visibilityValue,
              onChanged: (v) => setState(() => _visibilityValue = v as int),
              activeColor: AppTheme.primary,
              fillColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? AppTheme.primary : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
            Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: Colors.white54)),
          ],
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.primary,
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isActive ? AppTheme.primary : Colors.white38, size: 24),
        Text(label, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, color: isActive ? AppTheme.primary : Colors.white38)),
      ],
    );
  }
}
