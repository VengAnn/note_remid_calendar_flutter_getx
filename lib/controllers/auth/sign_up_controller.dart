import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_schedule_reminder/data/repository_impl/auth/auth_repo_impl.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class SignUpController extends GetxController {
  File? profile;
  final ImagePicker _imagePicker = ImagePicker();
  AuthRepoImpl authRepoImpl = AuthRepoImpl();
  bool isLoading = false;

  Future<void> setImageGallery() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (image != null) {
      profile = File(image.path); // Convert XFile to File
      update(); // Trigger UI update
    }
  }

  Future<void> setImageCamera() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (image != null) {
      profile = File(image.path); // Convert XFile to File
      update(); // Trigger UI update
    }
  }

  // register
  Future<void> register(String username, String email, String password) async {
    try {
      isLoading = true;
      update();
      Map<String, dynamic>? data;

      if (profile != null) {
        data = await authRepoImpl.register(
            username: username,
            email: email,
            password: password,
            profile: profile);
      } else {
        data = await authRepoImpl.register(
            username: username, email: email, password: password);
      }

      // ignore: unnecessary_null_comparison
      if (data != null) {
        // success clear image profile
        profile = null;

        // register success go to login
        Get.toNamed(RouteHelper.getLoginPage());

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
