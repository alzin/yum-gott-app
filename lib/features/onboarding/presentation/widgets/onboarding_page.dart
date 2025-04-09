import 'package:flutter/material.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String backgroundImage;
  final bool isDarkOverlay;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.backgroundImage,
    this.isDarkOverlay = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              isDarkOverlay 
                ? AppTheme.darkBackground
                : AppTheme.darkBackground.withOpacity(0.8),
            ],
            stops: const [0.0, 0.6],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Text(
                  title,
                  style: AppTheme.headingMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: AppTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}