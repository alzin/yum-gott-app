import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _goToPage(_currentPage + 1);
    } else {
      // Navigate to welcome screen if we're on the last page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const YumGottWelcomeScreen()),
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    }
  }

  void _skipToWelcome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const YumGottWelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for the three screens
          PageView(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              OnboardingPage(
                imageAsset: 'assets/images/food_background.jpg',
                title: 'Share videos',
                subtitle: 'for your food and get cashback',
                description: 'Share videos for your order and earn money for each order made through your content',
                currentPage: _currentPage,
                pageIndex: 0,
                onNext: _nextPage,
                onPrevious: _previousPage,
              ),
              OnboardingPage(
                imageAsset: 'assets/images/food_background_2.jpg',
                title: 'Get cashback',
                subtitle: 'for your Video Review',
                description: 'Share videos for your order and earn money for each order made through your content',
                currentPage: _currentPage,
                pageIndex: 1,
                onNext: _nextPage,
                onPrevious: _previousPage,
              ),
              OnboardingPage(
                imageAsset: 'assets/images/food_background_3.jpg',
                title: 'Get cashback',
                subtitle: 'for your Video Review',
                description: 'Share videos for your order and earn money for each order made through your content',
                currentPage: _currentPage,
                pageIndex: 2,
                onNext: _nextPage,
                onPrevious: _previousPage,
              ),
            ],
          ),
          
          // Language selector
          Positioned(
            top: 71,
            left: 17,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'EN',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Skip button
          Positioned(
            top: 71,
            right: 17,
            child: TextButton(
              onPressed: _skipToWelcome,
              child: const Text(
                'Skip',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          // Home indicator
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 134,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;
  final String description;
  final int currentPage;
  final int pageIndex;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const OnboardingPage({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.currentPage,
    required this.pageIndex,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageAsset),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay for better text readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
          ),
          
          // Content section
          Positioned(
            bottom: 132,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Pagination dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDot(0 == currentPage),
                      const SizedBox(width: 20),
                      _buildDot(1 == currentPage),
                      const SizedBox(width: 20),
                      _buildDot(2 == currentPage),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Main text content
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 39,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.17,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Navigation controls
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF222327),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 32,
                            offset: const Offset(0, 40),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: onPrevious,
                          ),
                          Container(
                            width: 1,
                            height: 24,
                            color: const Color(0xFFE6E8EC),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward, color: Colors.white),
                            onPressed: onNext,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      width: isActive ? 18 : 9,
      height: isActive ? 18 : 9,
      decoration: BoxDecoration(
        color: isActive ? Colors.transparent : Colors.white,
        shape: BoxShape.circle,
        border: isActive ? Border.all(color: Colors.white, width: 2) : null,
      ),
      child: isActive
          ? Center(
              child: Container(
                width: 13,
                height: 13,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
} 