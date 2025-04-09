import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yum_gott_app/core/constants/app_constants.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TabController _tabController;
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement registration
      Get.offAllNamed(AppRoutes.home);
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
                    
                    // Register title
                    Text(
                      'Sign up Free',
                      style: AppTheme.headingSmall.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Tab bar for user/restaurant
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F0F0F),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: const Color(0xFF272727),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: const Color(0xFF57A0BA),
                        labelStyle: AppTheme.bodyLarge.copyWith(
                          fontFamily: 'Vazirmatn',
                          fontWeight: FontWeight.w500,
                        ),
                        tabs: const [
                          Tab(text: 'User'),
                          Tab(text: 'Restaurant'),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Registration form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Name input
                          TextFormField(
                            controller: _nameController,
                            style: AppTheme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: AppTheme.lightTextColor.withOpacity(0.5),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Email input
                          TextFormField(
                            controller: _emailController,
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
                              // Simple email validation
                              if (!value.contains('@') || !value.contains('.')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Phone input
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            style: AppTheme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: 'Mobile Number',
                              prefixIcon: Icon(
                                Icons.phone_outlined,
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
                          
                          const SizedBox(height: 16),
                          
                          // Password input
                          TextFormField(
                            controller: _passwordController,
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
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 32),
                          
                          // Sign in button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _register,
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
                    
                    // Login link
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.login),
                      child: Text(
                        'Don\'t have an account? Register',
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
      ),
    );
  }
}