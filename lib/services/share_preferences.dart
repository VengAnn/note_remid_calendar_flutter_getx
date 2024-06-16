import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    // initialize shared preferences
    _prefs = await SharedPreferences.getInstance();
  }

  static void saveSelectedLanguage(String languageCode) {
    _prefs.setString('selectedLanguage', languageCode);
  }

  static String? loadSelectedLanguage() {
    return _prefs.getString('selectedLanguage');
  }

  static void saveOnboardingExist(bool isExist) {
    _prefs.setBool("onboardingExist", isExist);
  }

  static bool loadOnboardingExist() {
    return _prefs.getBool("onboardingExist") ?? false;
  }

  static void saveToken(String token) {
    _prefs.setString("token", token);
  }

  static String? getToken() {
    return _prefs.getString("token");
  }

  static void clearToken() {
    _prefs.remove("token");
  }

  static void saveIsLoginWithGoogle(bool isLogin) {
    _prefs.setBool("isLoginWithGoogle", isLogin);
  }

  static void clearIsLoginWithGoogle() {
    _prefs.remove("isLoginWithGoogle");
  }

  // save user id int
  static void saveUserId(int userId) {
    _prefs.setInt("userId", userId);
  }

  // get user id int
  static int getUserId() {
    return _prefs.getInt("userId") ?? 0;
  }

  // clear user id int
  static void clearUserId() {
    _prefs.remove("userId");
  }

  // save profile
  static void saveProfile(String? profile) {
    _prefs.setString("profile", profile!);
  }

  // get profile
  static String? getProfile() {
    return _prefs.getString("profile");
  }

  // clear profile
  static void clearProfile() {
    _prefs.remove("profile");
  }
}
