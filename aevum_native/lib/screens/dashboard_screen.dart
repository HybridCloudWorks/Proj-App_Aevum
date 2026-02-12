import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827), // bg-gray-900
      body: Stack(
        children: [
          _buildBackdrop(),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _buildHeroCard(context),
                        const SizedBox(height: 16),
                        _buildBentoGrid(context),
                        const SizedBox(height: 16),
                        _buildMemoriesSection(),
                        // Add spacing for bottom floating nav
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildFloatingBottomNav(),
        ],
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
          child: _blurBlob(const Color(0xFF2563EB).withOpacity(0.3), 300),
        ),
        // Purple blob bottom-right
        Positioned(
          bottom: -100,
          right: -100,
          child: _blurBlob(const Color(0xFF9333EA).withOpacity(0.3), 300),
        ),
        // Pink blob mid-left
        Positioned(
          top: 200,
          left: -50,
          child: _blurBlob(const Color(0xFFEC4899).withOpacity(0.2), 250),
        ),
        // Overlay
        Positioned.fill(child: Container(color: Colors.black.withOpacity(0.1))),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Color(0xFF60A5FA), Color(0xFFA855F7)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/memories');
                  },
                  child: ClipOval(
                    child: Image.network(
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuCypW0HCtYaKHH0MjMWX5XSsEKnu7uoyRGpXiybm9VCSMSScwMkgC9ez5DGxTI5aZ9R8qtdmEhpP57FWjs1FEoF71D4bCGguhT8QavCYCK0Hq6QmPi5gBbq-toXZJYB2YAyY3ACa7I9D_xT4aNPKnATilfv4r2mIsfkVXaKiuzT4E6wh8xuMRQ2gs1XjSq71o-iw17bRamMPrWJPA1F8-lYYaF3HAZYx3KtIUk3CtH-NetUq8Av_FjlDt-4jo7Pxw5GiiDB9tT_y0w",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back",
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[300],
                      letterSpacing: 0.5,
                      textStyle: const TextStyle(height: 1),
                    ),
                  ),
                  Text(
                    "Alex",
                    style: GoogleFonts.publicSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "AEVUM",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(width: 16),
              _glassIconButton(Icons.notifications_outlined, badge: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _glassIconButton(IconData icon, {bool badge = false}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.8), size: 24),
          if (badge)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return Container(
      height: 224, // h-56
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        // Glass effect
        color: Colors.white.withOpacity(0.1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Opacity(
                opacity: 0.4,
                child: Image.network(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuB0w_7LgeGvO_40XKSE8_u9BlvBlyoFqmsb1rRwBgV3p4LIpenJmAItYk0k2ZIRvGLwhtqqGIt9Jlv7eLRCHRag_AyVxwGyInXcEdoNon2qyjhBmDwhrh5MmEBUUPeiAIJhY7byAEJWebCT44LqMdSrnmEFL8NvjlI4KwQla_aefPelwUwi4_hmF41W3_pkfzLbf8CDDmy2qvacKOnMMpvnvvqOb31CmqCzgLHtbuVMQ6Qj0p9Fhij8p0-UhJn1g9ODbjQORkH_uDU",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  ),
                ),
              ),
            ),
            // Content
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/tree');
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue[500]!.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.blue[400]!.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          "QUICK PAN",
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[100],
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      Text(
                        "Family Tree",
                        style: GoogleFonts.publicSans(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.1,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Last edited 2h ago by Sarah",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Icon Button
            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.open_in_full,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
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
              child: Container(
                height: 176, // h-44
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
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
                          color: Colors.green.withOpacity(0.2),
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
                              "142",
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
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: 0.75,
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
                              "+12 this month",
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
              ),
            ),
            const SizedBox(width: 16),
            // AI Tasks Card
            Expanded(
              child: Container(
                height: 176, // h-44
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
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
                          color: Colors.purple.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                color: Colors.red[500],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "3",
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
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.05),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.grey[600],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "https://lh3.googleusercontent.com/aida-public/AB6AXuCst1gIFGnX9hkdMwGTaxY6xjUlP-IAFFAh7ypfOuPKGVthwfRdOj01OQ5TVfUrQz3nmE7f3sWLFcEeZsZFJmMIX1GQYL3xDuFw49ZFBVnhAXd455GgLwYdqEj6VP9zHQjOLdbNqUtH9egfkXyq99VsuzDKq8pMEh8dCfPAv4XR6muac_M4rmeOXxkl_Ao8uGNz3sN9rMJ3IlXfIdezJzFvDSMtysjXO7GXs4B2tLwjld77v9VX3o4-npz_pJY5nIomO-I1vO1tcJ4",
                                    fit: BoxFit.cover,
                                    color: Colors.white.withOpacity(0.8),
                                    colorBlendMode: BlendMode.modulate,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Grandpa '54",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Enhance color",
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
                        ),
                        // Button
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.purple.withOpacity(0.3),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "START RESTORE",
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple[100],
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                Colors.blue[500]!.withOpacity(0.2),
                Colors.blue[400]!,
                onTap: () => Navigator.pushNamed(context, '/invite'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _glassActionCard(
                Icons.cloud_upload,
                Colors.orangeAccent,
                "UPLOAD",
                "Center",
                Colors.orange[500]!.withOpacity(0.2),
                Colors.orange[400]!,
                onTap: () => Navigator.pushNamed(context, '/upload'),
              ),
            ),
          ],
        ),
      ],
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
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
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
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
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
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Stack(
            children: [
              Container(
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
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Center(
            child: Icon(
              Icons.add_a_photo,
              color: Colors.white.withOpacity(0.5),
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

  Widget _buildFloatingBottomNav() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 72,
              width: 320, // Approx
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2), // Darker glass
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _bottomNavIcon(Icons.grid_view, true),
                  _bottomNavIcon(Icons.history),
                  // Floating FAB in middle
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF9333EA)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue[600]!.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFF111827),
                        width: 4,
                      ),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 32),
                  ),
                  _bottomNavIcon(Icons.search),
                  _bottomNavIcon(Icons.settings),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomNavIcon(IconData icon, [bool active = false]) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Center(
        child: Icon(
          icon,
          color: active
              ? Colors.grey[400]
              : Colors
                    .grey[600], // Active isn't blue in HTML code provided, just text-primary
          size: 28,
        ),
      ),
    );
  }
}
