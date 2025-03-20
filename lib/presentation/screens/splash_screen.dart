import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopx/core/theme/app_colors.dart';
import 'package:shopx/core/utils/shared_prefs.dart';
import 'package:shopx/presentation/screens/auth/login_screen.dart';
import 'package:shopx/presentation/screens/navigation/custom_navigation.dart';
import 'package:shopx/presentation/screens/onboarding_screen.dart';

import '../../core/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final isOnboardingShown = await SharedPrefs.isOnboardingShown();
    await Future.delayed(Duration(seconds: 2));

    if (mounted) {
      debugPrint("isLoggedIn - $isLoggedIn");
      if (isLoggedIn) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => ShopXNavigation()));
      } else {
        if (!isOnboardingShown) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => OnboardingScreen()),
          );
        } else {
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Sizecf().init(context);
    return Scaffold(
      body: Center(
        child: Text(
          "SHOPX",
          style: TextStyle(
            fontSize: Sizecf.blockSizeHorizontal! * 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primarycolor,
          ),
        ),
      ),
    );
  }
}
