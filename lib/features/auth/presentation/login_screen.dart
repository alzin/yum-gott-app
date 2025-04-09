import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yum_gott_app/core/constants/app_constants.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPhoneLogin = true; // Toggle between phone and email login

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _toggleLoginMethod() {
    setState(() {
      _isPhoneLogin = !_isPhoneLogin;
    });
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // For demo purposes, navigate to OTP screen
      if (_isPhoneLogin) {
        Get.toNamed(AppRoutes.otpVerification, arguments: _phoneController.text);
      } else {
        // TODO: Implement email login
        Get.offAllNamed(AppRoutes.home);
      }
    }
  }

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
              stops: const [0.0, 0.6],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
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
                    
                    const SizedBox(height: 24),
                    
                    // App logo
                    Image.asset(
                      '${AppConstants.imagePath}logo.png',
                      height: 88,
                      width: 278,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // App name
                    Text(
                      'Share Your Taste',
                      style: AppTheme.headingLarge,
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Login title
                    Text(
                      _isPhoneLogin ? 'Log in With Phone Number' : 'Log in With your Email & Pass',
                      style: AppTheme.headingSmall.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Login form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (_isPhoneLogin) ...[
                            // Phone input
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: AppTheme.bodyMedium,
                              decoration: InputDecoration(
                                hintText: 'Phone',
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: AppTheme.lightTextColor.withOpacity(0.5),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                          ] else ...[
                            // Email input
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: AppTheme.bodyMedium,
                              decoration: InputDecoration(
                                hintText: 'Email Address',
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: AppTheme.lightTextColor.withOpacity(0.5),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Password input
                            TextFormField(
                              obscureText: true,
                              style: AppTheme.bodyMedium,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: AppTheme.lightTextColor.withOpacity(0.5),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ],
                          
                          const SizedBox(height: 24),
                          
                          // Sign in button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                'Sign in',
                                style: AppTheme.buttonText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Or continue with
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or continue with',
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.lightTextColor.withOpacity(0.7),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Social login options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google
                        GestureDetector(
                          onTap: () {
                            // TODO: Implement Google login
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              '${AppConstants.iconPath}google.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 24),
                        
                        // Facebook
                        GestureDetector(
                          onTap: () {
                            // TODO: Implement Facebook login
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              '${AppConstants.iconPath}facebook.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Register link
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.register),
                      child: Text(
                        'Don\'t have an account? Register',
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.lightTextColor.withOpacity(0.7),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Toggle login method
                    TextButton(
                      onPressed: _toggleLoginMethod,
                      child: Text(
                        _isPhoneLogin
                            ? 'Login with Email & Password'
                            : 'Login with Phone Number',
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.primaryColor,
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
      ),
    );
  }
}