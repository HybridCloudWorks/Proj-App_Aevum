import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MediaDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String year;
  final String location;

  const MediaDetailScreen({
    super.key,
    required this.imageUrl,
    this.title = "Untitled",
    this.year = "Unknown Year",
    this.location = "Unknown Location",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              // Show metadata
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            },
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.broken_image, color: Colors.white54, size: 64),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: Colors.white70, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        year,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.location_on,
                          color: Colors.white70, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        location,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
