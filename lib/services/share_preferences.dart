import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService extends GetxService {
  Future<void> saveSelectedLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('selectedLanguage', languageCode);
  }

  Future<String?> loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedLanguage');
  }

  /// Saves onboard is exists
  static Future<void> saveOnboardingExist(bool isExist) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("onboardingExist", isExist);
  }

  // load or get OnboardingExist
  static Future<bool> loadOnboardingExist() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("onboardingExist") ?? false;
  }
}
