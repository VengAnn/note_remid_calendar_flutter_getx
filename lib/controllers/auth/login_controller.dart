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
        SharedPreferencesService.saveToken(user.token!);

        // save user id
        SharedPreferencesService.saveUserId(user.user!.userId!);

        Get.offAllNamed(RouteHelper.getCalenderPage());
        // delay a bit to something smooth
        await Future.delayed(const Duration(milliseconds: 200));

        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();

        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.warning,
          text: 'email, password went wrong OR something is wrong!',
        );
      }
    } catch (e) {
      isLoading = false;
      update();

      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        text: 'error: $e',
      );
    }
  }

  void logout() async {
    try {
      isLoading = true;
      update();

      bool success = await authRepoImpl!.logout();
      if (success) {
        SharedPreferencesService.clearToken();
        await Get.offAllNamed(RouteHelper.getLoginPage());
        // when logout is successfully clear something from local storage
        SharedPreferencesService.clearUserId();
        SharedPreferencesService.clearToken();

        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();

        Dialogs.showSnackBar("can't logout Something went wrong!");
      }
    } catch (e) {
      isLoading = false;
      update();

      Dialogs.showSnackBar("Error: $e");
    }
  }

  // auth google authentication with my personal backend
  void loginWithGoogle(String email, String name) async {
    try {
      isLoading = true;
      update();

      final Map<String, dynamic> response = await authGoogleImpl
          .authGoogleRegisterToMyBackend(email: email, name: name);

      // ignore: unnecessary_null_comparison
      if (response != null && response['success'].containsKey('token')) {
        // save user id to local storage
        String userId = response['success']['user_id'];
        SharedPreferencesService.saveUserId(int.parse(userId));

        // If successfully logged in
        // First we need to save token
        String token = response['success']['token'];
        SharedPreferencesService.saveToken(token);
        Get.offAllNamed(RouteHelper.getCalenderPage());

        // Stop loading after a slight delay to ensure navigation is complete
        await Future.delayed(const Duration(milliseconds: 200));
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
