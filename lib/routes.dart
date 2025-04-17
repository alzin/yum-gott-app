import 'package:get/get.dart';
import 'package:yum_gott_app/features/auth/presentation/login_screen.dart';
import 'package:yum_gott_app/features/auth/presentation/otp_verification_screen.dart';
import 'package:yum_gott_app/features/auth/presentation/register_screen.dart';
import 'package:yum_gott_app/features/auth/presentation/welcome_screen.dart';
import 'package:yum_gott_app/features/camera/presentation/camera_screen.dart';
import 'package:yum_gott_app/features/camera/presentation/flutter_camera_screen.dart';
import 'package:yum_gott_app/features/feed/presentation/feed_screen.dart';
import 'package:yum_gott_app/features/onboarding/presentation/onboarding_screen.dart';

class AppRoutes {
  // Route names
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpVerification = '/otp-verification';
  static const String feed = '/feed';
  static const String camera = '/camera';

  // Get pages for GetX navigation
  static List<GetPage> pages = [
    GetPage(
      name: onboarding,
      page: () => const OnboardingScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: welcome,
      page: () => const WelcomeScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: otpVerification,
      page: () => const OtpVerificationScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: feed,
      page: () => const FeedScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: camera,
      page: () => const FlutterCameraScreen(),
      transition: Transition.rightToLeft,
    )
  ];
}