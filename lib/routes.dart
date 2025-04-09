import 'package:get/get.dart';
import 'package:yum_gott_app/features/auth/presentation/login_screen.dart';
import 'package:yum_gott_app/features/auth/presentation/otp_verification_screen.dart';
import 'package:yum_gott_app/features/auth/presentation/register_screen.dart';
import 'package:yum_gott_app/features/auth/presentation/welcome_screen.dart';
import 'package:yum_gott_app/features/feed/presentation/feed_screen.dart';
import 'package:yum_gott_app/features/home/presentation/home_screen.dart';
import 'package:yum_gott_app/features/onboarding/presentation/onboarding_screen.dart';
import 'package:yum_gott_app/features/search/presentation/search_screen.dart';

class AppRoutes {
  // Route names
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpVerification = '/otp-verification';
  static const String home = '/home';
  static const String feed = '/feed';
  static const String search = '/search';
  static const String restaurantDetails = '/restaurant-details';
  static const String productDetails = '/product-details';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String addContent = '/add-content';
  static const String comments = '/comments';

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
      name: home,
      page: () => const HomeScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: feed,
      page: () => const FeedScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: search,
      page: () => const SearchScreen(),
      transition: Transition.rightToLeft,
    ),
    // TODO: Add other screens as they are implemented
    // GetPage(
    //   name: restaurantDetails,
    //   page: () => const RestaurantDetailsScreen(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: productDetails,
    //   page: () => const ProductDetailsScreen(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: cart,
    //   page: () => const CartScreen(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: profile,
    //   page: () => const ProfileScreen(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: addContent,
    //   page: () => const AddContentScreen(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: comments,
    //   page: () => const CommentsScreen(),
    //   transition: Transition.rightToLeft,
    // ),
  ];
}