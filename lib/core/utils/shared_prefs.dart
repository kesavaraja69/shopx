import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _keyOnboardingShown = 'onboarding_shown';

  static Future<bool> isOnboardingShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingShown) ?? false;
  }

  static Future<void> setOnboardingShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingShown, true);
  }
}
