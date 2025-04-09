import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yum_gott_app/core/constants/app_constants.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/features/onboarding/presentation/onboarding_screen.dart';
import 'package:yum_gott_app/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppTheme.darkBackground,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  // Initialize shared preferences
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if first launch to show onboarding or go directly to feed
    final prefs = Get.find<SharedPreferences>();
    final bool showOnboarding = prefs.getBool('showOnboarding') ?? true;
    
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: showOnboarding ? AppRoutes.onboarding : AppRoutes.feed,
      getPages: AppRoutes.pages,
      defaultTransition: Transition.rightToLeft,
    );
  }
}
