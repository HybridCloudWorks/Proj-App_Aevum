import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LegacyHandoverScreen extends StatefulWidget {
  const LegacyHandoverScreen({super.key});

  @override
  State<LegacyHandoverScreen> createState() => _LegacyHandoverScreenState();
}

class _LegacyHandoverScreenState extends State<LegacyHandoverScreen> {
  double _waitPeriod = 6.0;
  bool _protocolActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1121),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Legacy Handover",
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.lock_person, color: Color(0xFF1173d4)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildProtocolStatusCard(),
            const SizedBox(height: 32),
            _buildSectionHeader("INACTIVITY TRIGGER", "Auto-detect"),
            const SizedBox(height: 16),
            _buildWaitPeriodSelector(),
            const SizedBox(height: 32),
            _buildSectionHeader(
              "DESIGNATED TRUSTEES",
              "+ Add New",
              isAction: true,
            ),
            const SizedBox(height: 16),
            _buildTrusteeTile(
              "Sarah Sterling",
              "Verified Trustee",
              "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100",
              true,
            ),
            const SizedBox(height: 12),
            _buildTrusteeTile(
              "James Sterling",
              "Pending Acceptance",
              "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
              false,
            ),
            const SizedBox(height: 32),
            _buildSectionHeader("FINAL INSTRUCTIONS", "Last edited 2 days ago"),
            const SizedBox(height: 16),
            _buildDigitalLetterCard(),
            const SizedBox(height: 32),
            _buildSecurityNotice(),
            const SizedBox(height: 24),
            _buildActionButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProtocolStatusCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF151C2E),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_user,
                  color: Colors.greenAccent,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Protocol Active",
                      style: GoogleFonts.manrope(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Vault Encrypted",
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _protocolActive,
                onChanged: (v) => setState(() => _protocolActive = v),
                activeThumbColor: const Color(0xFF1173d4),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "The Legacy Handover protocol monitors your activity. If triggered, your designated trustees will receive access to the vault.",
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.white54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    String extra, {
    bool isAction = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Colors.white38,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          extra,
          style: GoogleFonts.manrope(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: isAction ? const Color(0xFF1173d4) : Colors.white24,
          ),
        ),
      ],
    );
  }

  Widget _buildWaitPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wait period",
                style: GoogleFonts.manrope(fontSize: 14, color: Colors.white54),
              ),
              Text(
                "${_waitPeriod.toInt()} Months",
                style: GoogleFonts.manrope(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF1173d4),
              inactiveTrackColor: Colors.white.withValues(alpha: 0.05),
              thumbColor: Colors.white,
              overlayColor: const Color(0xFF1173d4).withValues(alpha: 0.2),
              trackHeight: 4,
            ),
            child: Slider(
              value: _waitPeriod,
              min: 1,
              max: 12,
              onChanged: (v) => setState(() => _waitPeriod = v),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1 Month",
                style: GoogleFonts.manrope(fontSize: 10, color: Colors.white24),
              ),
              Text(
                "1 Year",
                style: GoogleFonts.manrope(fontSize: 10, color: Colors.white24),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, color: Colors.white38, size: 16),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "We will attempt to contact you via email, SMS, and push notification 3 times before initiating the handover sequence.",
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: Colors.white38,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrusteeTile(
    String name,
    String status,
    String url,
    bool isVerified,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 24, backgroundImage: NetworkImage(url)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    if (isVerified)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.greenAccent,
                        size: 12,
                      )
                    else
                      const Icon(
                        Icons.pending,
                        color: Colors.orangeAccent,
                        size: 12,
                      ),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        color: isVerified
                            ? Colors.greenAccent
                            : Colors.orangeAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              isVerified ? Icons.more_horiz : Icons.refresh,
              color: Colors.white38,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDigitalLetterCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFA855F7).withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.mail_outline, color: Color(0xFFA855F7)),
                  const SizedBox(width: 12),
                  Text(
                    "My Digital Letter",
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.edit_note, color: Colors.white38),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "\"To my dearest family, if you are reading this, it means the time has come for you to take stewardship of our history. The vault key...\"",
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: Colors.white60,
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const LinearProgressIndicator(
                    value: 0.7,
                    backgroundColor: Colors.white10,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFA855F7),
                    ),
                    minHeight: 3,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Voice Note Attached",
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  color: Colors.white24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNotice() {
    return Center(
      child: Text(
        "Changes to the Legacy Handover protocol require biometric confirmation.",
        textAlign: TextAlign.center,
        style: GoogleFonts.manrope(fontSize: 11, color: Colors.white12),
      ),
    );
  }

  Widget _buildActionButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.fingerprint),
      label: Text(
        "Confirm & Save Settings",
        style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1173d4),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 64),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
      ),
    );
  }
}
