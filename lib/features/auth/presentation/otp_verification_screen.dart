import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yum_gott_app/core/constants/app_constants.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/routes.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  String _phoneNumber = '';
  int _resendSeconds = 44;
  bool _isResendActive = false;

  @override
  void initState() {
    super.initState();
    // Get phone number from arguments
    if (Get.arguments != null) {
      _phoneNumber = Get.arguments as String;
    }
    
    // Start countdown for resend code
    _startResendTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_resendSeconds > 0) {
            _resendSeconds--;
            _startResendTimer();
          } else {
            _isResendActive = true;
          }
        });
      }
    });
  }

  void _resendCode() {
    if (_isResendActive) {
      // TODO: Implement resend code functionality
      setState(() {
        _resendSeconds = 44;
        _isResendActive = false;
      });
      _startResendTimer();
    }
  }

  void _verifyOtp() {
    if (_otpController.text.length == 4) {
      // TODO: Implement OTP verification
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar(
        'Error',
        'Please enter a valid OTP code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
          decoration: const BoxDecoration(
            color: AppTheme.darkBackground,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  
                  // Back button and title
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: AppTheme.lightGreyColor,
                            size: 20,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Verified Code',
                        style: AppTheme.headingSmall.copyWith(
                          color: AppTheme.lightGreyColor,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 40), // For balance
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // OTP sent message
                  Text(
                    'OTP code has been send to $_phoneNumber',
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.greyTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Resend code timer
                  GestureDetector(
                    onTap: _resendCode,
                    child: Text(
                      _isResendActive
                          ? 'Resend code'
                          : 'Resend code in ${_resendSeconds}s',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.lightGreyColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // PIN code fields
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      controller: _otpController,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 60,
                        fieldWidth: 80,
                        activeFillColor: Colors.white.withOpacity(0.04),
                        inactiveFillColor: Colors.white.withOpacity(0.1),
                        selectedFillColor: Colors.white.withOpacity(0.04),
                        activeColor: Colors.grey,
                        inactiveColor: Colors.grey,
                        selectedColor: AppTheme.primaryColor,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      onCompleted: (value) {
                        // Auto verify when complete
                        _verifyOtp();
                      },
                      onChanged: (value) {
                        // No need to do anything here
                      },
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Verify button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Verify',
                        style: AppTheme.buttonText,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}