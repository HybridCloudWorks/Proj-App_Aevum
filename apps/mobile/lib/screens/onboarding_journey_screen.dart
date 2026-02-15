import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingJourneyScreen extends StatefulWidget {
  const OnboardingJourneyScreen({super.key});

  @override
  State<OnboardingJourneyScreen> createState() =>
      _OnboardingJourneyScreenState();
}

class _OnboardingJourneyScreenState extends State<OnboardingJourneyScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildPage(
                title: "Welcome to Aevum",
                description:
                    "Your family's digital legacy, preserved for eternity.",
                image: Icons.family_restroom,
              ),
              _buildPage(
                title: "Preserve Memories",
                description:
                    "Store photos, videos, and stories in a secure, private vault.",
                image: Icons.photo_library,
              ),
              _buildPage(
                title: "Discover Connections",
                description:
                    "Let AI help you find lost relatives and build your tree.",
                image: Icons.share,
              ),
            ],
          ),
          Positioned(
            bottom: 48,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  TextButton(
                    onPressed: () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text("Back"),
                  )
                else
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text("Skip"),
                  ),
                Row(
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.blue
                            : Colors.white24,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_currentPage < 2) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      context.go('/auth');
                    }
                  },
                  child: Text(_currentPage < 2 ? "Next" : "Get Started"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
      {required String title,
      required String description,
      required IconData image}) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(image, size: 100, color: Colors.blueAccent),
          const SizedBox(height: 48),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
