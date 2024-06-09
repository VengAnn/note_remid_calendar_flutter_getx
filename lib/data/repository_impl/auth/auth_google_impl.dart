import 'package:note_schedule_reminder/data/api/api_client.dart';
import 'package:note_schedule_reminder/data/repository/auth/auth_google_repo.dart';
import 'package:note_schedule_reminder/models/auth_models/user_auth_res.dart';
import 'package:note_schedule_reminder/utils/app_constant.dart';

class AuthGoogleImpl extends AuthGoogleRepo {
  ApiClient apiClient = ApiClient();

  @override
  Future<UserAuthRes?> authGoogleRegisterToMyBackend(
      {required String email, required String name, String? photoUrl}) async {
    try {
      final response = await apiClient
          .postData(endpoint: AppConstant.Register_google_EndPoint, data: {
        "email",
        email,
        "name",
        name,
        "photoUrl",
        photoUrl,
      });
      if (response.statusCode == 200) {
        return UserAuthRes.fromJson(response.data);
      } else {
        throw Exception(response.data);
      }
    } catch (e) {
      throw Exception("error $e");
    }
  }
}
