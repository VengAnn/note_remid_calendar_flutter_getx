import 'package:get/get.dart';
import 'package:note_schedule_reminder/pages/auth/login_page.dart';
import 'package:note_schedule_reminder/pages/home/calender_page.dart';
import 'package:note_schedule_reminder/pages/onboarding/onboarding_language_page.dart';
import 'package:note_schedule_reminder/pages/onboarding/onboarding_page.dart';
import 'package:note_schedule_reminder/pages/onboarding/onboarding_three.dart';
import 'package:note_schedule_reminder/pages/onboarding/onboarding_two.dart';
import 'package:note_schedule_reminder/pages/splash/splash_page.dart';

class RouteHelper {
  static const _initial = "/";
  static const String _splashPage = "/splash-page";
  static const String _onBoardingLanguagePage = "/onboarding-language-page";
  static const String _onBoardingPage = "/onboarding-page";
  static const String _onBoardingOne = "/onboarding-one";
  static const String _onBoardingTwo = "/onboarding-two";
  static const String _onBoardingThree = "/onboarding-three";
  static const String _loginPage = "/login-page";

  // get all route
  static String getInitial() => _initial;
  static String getSplashPage() => _splashPage;
  // on boarding
  static String getOnBoardingLanguagePage() => _onBoardingLanguagePage;
  static String getOnBoardingPage() => _onBoardingPage;
  static String getOnBoardingOne() => _onBoardingOne;
  static String getOnBoardingTwo() => _onBoardingTwo;
  static String getOnBoardingThree() => _onBoardingThree;
  // auth
  static String getLoginPage() => _loginPage;

  static List<GetPage> routes = [
    GetPage(name: _splashPage, page: () => const SplashPage()),
    GetPage(
      name: _initial,
      page: () => const CalendarPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _onBoardingLanguagePage,
      page: () => const OnBoardingLanguagePage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _onBoardingPage,
      page: () => const OnBoardingPage(),
      transition: Transition.fade,
    ),
    // get page on boarding one
    GetPage(
      name: _onBoardingOne,
      page: () => const OnBoardingPageTwo(),
      transition: Transition.fade,
    ),
    // get page on boarding two
    GetPage(
      name: _onBoardingTwo,
      page: () => const OnBoardingPageThree(),
      transition: Transition.fade,
    ),
    // get page on boarding three
    GetPage(
      name: _onBoardingThree,
      page: () => const OnBoardingPageThree(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _loginPage,
      page: () => const LoginPage(),
      transition: Transition.fade,
    ),
  ];
}
