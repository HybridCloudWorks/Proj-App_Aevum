import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminSyncConflictScreen extends StatefulWidget {
  const AdminSyncConflictScreen({super.key});

  @override
  State<AdminSyncConflictScreen> createState() =>
      _AdminSyncConflictScreenState();
}

class _AdminSyncConflictScreenState extends State<AdminSyncConflictScreen> {
  int selectedVersion =
      1; // 0 for John Doe, 1 for Sarah Miller (matching baseline's green Highlight)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1121),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.sync_problem, color: Colors.red, size: 20),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sync Conflict",
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Eleanor Rigby • 2 versions found",
              style: GoogleFonts.manrope(fontSize: 11, color: Colors.redAccent),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white54),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildConflictIndicator(),
            const SizedBox(height: 24),
            Text(
              "Resolve Data Mismatch",
              style: GoogleFonts.manrope(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Two admins edited this profile simultaneously.\nPlease select the correct version to keep.",
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 13,
                color: Colors.white54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),
            _buildVersionCard(
              index: 0,
              name: "John Doe",
              time: "10:42 AM",
              birthDate: "1924-04-12",
              birthPlace: "Liverpool, UK",
              notes:
                  "Updated birth records from parish register found in attic.",
              avatarUrl:
                  "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildVersionCard(
              index: 1,
              name: "Sarah Miller",
              time: "10:45 AM",
              birthDate: "1924-04-14",
              birthPlace: "Liverpool, UK",
              notes: "Corrected date based on birth certificate scan.",
              avatarUrl:
                  "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100",
              color: Colors.pink,
              isConflictField: true, // Matching baseline highlight
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: _buildEditButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: _buildBottomAction(),
    );
  }

  Widget _buildConflictIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.history, color: Colors.white70, size: 16),
          const SizedBox(width: 10),
          Text(
            "Conflict detected 12m ago",
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionCard({
    required int index,
    required String name,
    required String time,
    required String birthDate,
    required String birthPlace,
    required String notes,
    required String avatarUrl,
    required Color color,
    bool isConflictField = false,
  }) {
    bool isSelected = selectedVersion == index;
    return GestureDetector(
      onTap: () => setState(() => selectedVersion = index),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.06)
              : Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1173d4).withOpacity(0.5)
                : Colors.white.withOpacity(0.05),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: color.withOpacity(0.2),
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Updated by",
                        style: GoogleFonts.manrope(
                          fontSize: 10,
                          color: Colors.white38,
                        ),
                      ),
                      Text(
                        name,
                        style: GoogleFonts.manrope(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Timestamp",
                      style: GoogleFonts.manrope(
                        fontSize: 10,
                        color: Colors.white38,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            _dataField("BIRTH DATE", birthDate, highlight: isConflictField),
            const SizedBox(height: 12),
            _dataField("BIRTH PLACE", birthPlace),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notes Added",
                    style: GoogleFonts.manrope(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white38,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\"$notes\"",
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
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

  Widget _dataField(String label, String value, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.white38,
            letterSpacing: 1,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: highlight
                ? const Color(0xFF10B981).withOpacity(0.15)
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: highlight ? const Color(0xFF10B981) : Colors.white70,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.edit, color: Colors.white, size: 18),
                const SizedBox(width: 10),
                Text(
                  "Manually Edit",
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.merge_type),
        label: Text(
          "Merge Selected Version",
          style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 64),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
