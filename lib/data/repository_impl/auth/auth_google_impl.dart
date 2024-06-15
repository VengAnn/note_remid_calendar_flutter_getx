import 'package:note_schedule_reminder/data/api/api_client.dart';
import 'package:note_schedule_reminder/data/repository/auth/auth_google_repo.dart';
import 'package:note_schedule_reminder/utils/app_constant.dart';

class AuthGoogleImpl extends AuthGoogleRepo {
  ApiClient apiClient = ApiClient();

  @override
  Future<Map<String, dynamic>> authGoogleRegisterToMyBackend(
      {required String email, required String name, String? photoUrl}) async {
    try {
      final response = await apiClient
          .postData(endpoint: AppConstant.Register_google_EndPoint, data: {
        "email": email,
        "name": name,
      });

      //log("resposne auth google: $response");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data);
      }
    } catch (e) {
      throw Exception("error $e");
    }
  }
}
