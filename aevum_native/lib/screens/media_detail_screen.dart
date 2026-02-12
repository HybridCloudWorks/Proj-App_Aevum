import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:aevum_native/widgets/smart_navigation_wrapper.dart';
import 'package:aevum_native/widgets/heritage_top_nav.dart';

class MediaDetailScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String year;
  final String location;
  final String? initialAiStory;

  const MediaDetailScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.year,
    required this.location,
    this.initialAiStory,
  });

  @override
  State<MediaDetailScreen> createState() => _MediaDetailScreenState();
}

class _MediaDetailScreenState extends State<MediaDetailScreen> {
  late String _currentStory;
  final TextEditingController _storyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentStory =
        widget.initialAiStory ??
        "In the golden light of 1968, this moment was captured near Tuscany. A gathering that whispered of heritage and the quiet strength of family roots.";
    _storyController.text = _currentStory;
  }

  void _showEditStorySheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 32,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF111827).withValues(alpha: 0.9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Family Story",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Refine the AI-generated narrative to better match your family's truth.",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white60,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _storyController,
                maxLines: 5,
                style: GoogleFonts.plusJakartaSans(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF6366F1)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentStory = _storyController.text;
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Save Story",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _showTagRelativeSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A).withValues(alpha: 0.9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tag a Relative",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _relativeItem(
                "Joseph Miller",
                "Grandfather",
                "https://i.pravatar.cc/150?u=jm",
              ),
              _relativeItem(
                "Eleanor Ricci",
                "Grandmother",
                "https://i.pravatar.cc/150?u=er",
              ),
              _relativeItem(
                "Maria Vance",
                "Mother",
                "https://i.pravatar.cc/150?u=mv",
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.plusJakartaSans(color: Colors.white54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _relativeItem(String name, String relation, String avatar) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(avatar), radius: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                relation,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.add_circle_outline, color: Color(0xFF0EA5E9)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F151B),
      body: SmartNavigationWrapper(
        topNav: HeritageTopNav(
          title: widget.title,
          subtitle: "${widget.year} • ${widget.location}",
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: widget.imageUrl,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(widget.imageUrl, fit: BoxFit.cover),
                    ),
                    _buildFaceBoundingBoxes(),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.4),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.9),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0EA5E9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.year,
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.people,
                                  color: Colors.white70,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "3 Tagged",
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white70,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.title,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white54,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.location,
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildFamilyStory(),
                      const SizedBox(height: 24),
                      _buildActionRow(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFamilyStory() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: Color(0xFF6366F1),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "FAMILY STORY",
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF6366F1),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: _showEditStorySheet,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    "EDIT",
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF6366F1),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _currentStory,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _showTagRelativeSheet,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_add_outlined,
                    color: Colors.white70,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Tag Relative",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0EA5E9), Color(0xFF2563EB)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                "Save Memory",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFaceBoundingBoxes() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            _faceBox(
              constraints.maxWidth * 0.45,
              constraints.maxHeight * 0.35,
              80,
              80,
              "Grandpa John",
            ),
            _faceBox(
              constraints.maxWidth * 0.65,
              constraints.maxHeight * 0.40,
              70,
              70,
              "Identify?",
            ),
          ],
        );
      },
    );
  }

  Widget _faceBox(
    double left,
    double top,
    double width,
    double height,
    String label,
  ) {
    bool isIdentified = label != "Identify?";
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () {
          if (!isIdentified) {
            _showTagRelativeSheet();
          }
        },
        child: Column(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isIdentified
                      ? Colors.blue
                      : Colors.white.withValues(alpha: 0.5),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: isIdentified
                  ? const Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isIdentified
                    ? Colors.blue.withValues(alpha: 0.9)
                    : Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
