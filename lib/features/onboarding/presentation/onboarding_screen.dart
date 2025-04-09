import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yum_gott_app/core/constants/app_constants.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/features/auth/presentation/welcome_screen.dart';
import 'package:yum_gott_app/features/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:yum_gott_app/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _numPages = 3;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Share videos for your food and get cashback',
      'description': 'Share videos for your order and earn money for each order made through your content',
      'image': '${AppConstants.imagePath}onboarding1.jpg',
    },
    {
      'title': 'Get Cashback for your Video Review',
      'description': 'Share videos for your order and earn money for each order made through your content',
      'image': '${AppConstants.imagePath}onboarding2.jpg',
    },
    {
      'title': 'Get Cashback for your Video Review',
      'description': 'Share videos for your order and earn money for each order made through your content',
      'image': '${AppConstants.imagePath}onboarding3.jpg',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  Future<void> _completeOnboarding() async {
    // Save that onboarding is completed
    final prefs = Get.find<SharedPreferences>();
    await prefs.setBool('showOnboarding', false);
    
    // Navigate to welcome screen
    Get.offAllNamed(AppRoutes.welcome);
  }

  void _nextPage() {
    if (_currentPage < _numPages - 1) {
      _pageController.nextPage(
        duration: AppConstants.defaultAnimationDuration,
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for onboarding pages
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _numPages,
            itemBuilder: (context, index) {
              return OnboardingPage(
                title: _onboardingData[index]['title']!,
                description: _onboardingData[index]['description']!,
                backgroundImage: _onboardingData[index]['image']!,
              );
            },
          ),
          
          // Skip button
          Positioned(
            top: 50,
            right: 24,
            child: TextButton(
              onPressed: _skipOnboarding,
              child: Text(
                'Skip',
                style: AppTheme.bodyLarge.copyWith(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          // Language selector
          Positioned(
            top: 50,
            left: 24,
            child: TextButton(
              onPressed: () {
                // TODO: Implement language selection
              },
              child: Text(
                'EN',
                style: AppTheme.bodyLarge.copyWith(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          // Navigation dots and next button
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Navigation dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _numPages,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? AppTheme.lightTextColor
                            : AppTheme.lightTextColor.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                
                // Navigation buttons
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(16),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _currentPage > 0
                            ? () {
                                _pageController.previousPage(
                                  duration: AppConstants.defaultAnimationDuration,
                                  curve: Curves.easeInOut,
                                );
                              }
                            : null,
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: _currentPage > 0
                              ? AppTheme.lightTextColor
                              : const Color(0xFF66676B),
                          size: 20,
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 20,
                        color: AppTheme.lightTextColor.withOpacity(0.2),
                      ),
                      IconButton(
                        onPressed: _nextPage,
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: AppTheme.lightTextColor,
                          size: 20,
                        ),
                      ),
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
}