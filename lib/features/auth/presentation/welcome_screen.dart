import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yum_gott_app/core/constants/app_constants.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('${AppConstants.imagePath}background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppTheme.darkBackground,
              ],
              stops: const [0.0, 0.8],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Language selector
                  Align(
                    alignment: Alignment.topRight,
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
                  
                  const Spacer(),
                  
                  // App logo
                  Image.asset(
                    '${AppConstants.imagePath}logo.png',
                    height: 88,
                    width: 278,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // App name
                  Text(
                    'Share Your Taste',
                    style: AppTheme.headingLarge,
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Sign up button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed(AppRoutes.register),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Sign up free',
                        style: AppTheme.buttonText,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Continue with phone number
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Get.toNamed(AppRoutes.login),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.white30,
                          width: 1,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Continue with phone number',
                        style: AppTheme.bodyLarge,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Social login options
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // TODO: Implement Google login
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.white30,
                              width: 1,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                '${AppConstants.iconPath}google.png',
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Google',
                                style: AppTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // TODO: Implement Facebook login
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.white30,
                              width: 1,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                '${AppConstants.iconPath}facebook.png',
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Facebook',
                                style: AppTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Login text
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.login),
                    child: Text(
                      'Log in',
                      style: AppTheme.headingSmall,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Continue as guest
                  TextButton(
                    onPressed: () {
                      // Navigate to feed screen instead of home
                      Get.offAllNamed(AppRoutes.feed);
                    },
                    child: Text(
                      'Or Continue? As Guest',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.lightTextColor.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}