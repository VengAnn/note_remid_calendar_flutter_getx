import 'dart:developer';
import 'dart:io';

import 'package:note_schedule_reminder/data/repository/auth/auth_repo.dart';
import 'package:note_schedule_reminder/data/api/api_client.dart';
import 'package:note_schedule_reminder/models/auth_models/user_auth_res.dart';
import 'package:note_schedule_reminder/services/share_preferences.dart';
import 'package:note_schedule_reminder/utils/app_constant.dart';

class AuthRepoImpl extends AuthRepo {
  final ApiClient _apiClient = ApiClient(); // Inject ApiClient instance

  //AuthRepoImpl(this._apiClient);
  @override
  Future<UserAuthRes?> login(String email, String password) async {
    log("email: " + email + " password: " + password);
    try {
      final response = await _apiClient.postData(
        endpoint: AppConstant.Login_EndPoint,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        log("response: ${response.data}");
        
        UserAuthRes userAuthRes = UserAuthRes.fromJson(response.data);
        return userAuthRes;
      } else {
        throw Exception("Error : ${response.data}");
      }
    } catch (error) {
      print("error: $error");
      throw Exception("Error: $error");
    }
  }

  @override
  Future<bool> logout() async {
    try {
      final String? token = await SharedPreferencesService.getToken();

      final response = await _apiClient.postData(
        endpoint: AppConstant.Logout_EndPoint,
        token: token ?? "",
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    File? profile,
  }) async {
    try {
      final response = await _apiClient.postDataRegister(
        endpoint: AppConstant.Register_EndPoint,
        username: username,
        email: email,
        password: password,
        profileImage: profile,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Response data is null ${response.data}');
      }
    } catch (e) {
      throw Exception("error $e");
    }
  }
}
