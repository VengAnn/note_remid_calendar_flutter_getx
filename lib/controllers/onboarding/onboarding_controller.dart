import 'package:get/get.dart';

class OnboardingController extends GetxController {
  String selectedLanguage = "";

  void setSelectedLanguage(String lanuage) {
    selectedLanguage = lanuage;
    update();
  }
}
