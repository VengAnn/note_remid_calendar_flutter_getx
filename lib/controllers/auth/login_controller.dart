import 'dart:developer';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/components/dialogs.dart';
import 'package:note_schedule_reminder/data/repository_impl/auth/auth_google_impl.dart';
import 'package:note_schedule_reminder/data/repository_impl/auth/auth_repo_impl.dart';
import 'package:note_schedule_reminder/models/auth_models/user_auth_res.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:note_schedule_reminder/services/share_preferences.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginController extends GetxController {
  AuthRepoImpl? authRepoImpl = AuthRepoImpl();
  AuthGoogleImpl authGoogleImpl = AuthGoogleImpl();
  bool isLoading = false;

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  void login(String email, String password) async {
    isLoading = true;
    update();

    try {
      final UserAuthRes? user = await authRepoImpl!.login(email, password);

      if (user != null) {
        // If successfully logged in
        // First we need to save token
        await SharedPreferencesService.saveToken(user.token!);

        Get.offAllNamed(RouteHelper.getCalenderPage());
        // delay a bit to something smooth
        await Future.delayed(const Duration(milliseconds: 200));

        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
        Dialogs.showSnackBar(
            "email, password went wrong OR something is wrong!");
      }
    } catch (e) {
      isLoading = false;
      update();
      Dialogs.showSnackBar("Error: $e");
      log("Error: $e");
    }
  }

  void logout() async {
    isLoading = true;
    update();
    try {
      bool success = await authRepoImpl!.logout();
      if (success) {
        await SharedPreferencesService.clearToken();
        await Get.offAllNamed(RouteHelper.getLoginPage());

        isLoading = false;
        update();
      } else {
        Dialogs.showSnackBar("can't logout Something went wrong!");
        isLoading = false;
        update();
      }
    } catch (e) {
      log("Error: $e");
      isLoading = false;
      update();
      Dialogs.showSnackBar("Error: $e");
    }
  }

  // auth google authentication with my personal backend
  void loginWithGoogle(String email, String name, String? photoUrl) async {
    try {
      isLoading = true;
      update();

      final UserAuthRes? userAuthRes = await authGoogleImpl
          .authGoogleRegisterToMyBackend(email: email, name: name);

      if (userAuthRes != null) {
        // If successfully logged in
        // First we need to save token
        await SharedPreferencesService.saveToken(userAuthRes.token!);
        Get.offAllNamed(RouteHelper.getCalenderPage());

        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.warning,
          text: 'something went wrong !',
        );
      }
    } catch (e) {
      isLoading = false;
      update();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, something went wrong $e',
      );
    }
  }
}
