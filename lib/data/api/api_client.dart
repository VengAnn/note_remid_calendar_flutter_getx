import 'dart:io';

import 'package:dio/dio.dart';
import 'package:note_schedule_reminder/utils/app_constant.dart';

class ApiClient {
  // final Dio _dio = Dio();
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConstant.Base_Url,
    connectTimeout: const Duration(seconds: 25), // 25 seconds
    receiveTimeout: const Duration(seconds: 25), // 25 seconds
  ));
  final String _baseUrl = AppConstant.Base_Url;

  Future<Response> fetchData({required String endpoint}) async {
    try {
      final response = await _dio.get(_baseUrl + endpoint);
      return response;
    } catch (error) {
      throw Exception("error api client $error");
    }
  }

  Future<Response> postData({
    required String endpoint,
    dynamic data,
    String? token,
  }) async {
    try {
      final response = await _dio.post(
        _baseUrl + endpoint,
        data: data,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": token != null ? "Bearer $token" : null,
          },
          followRedirects: false,
          validateStatus: (status) => status! <= 500,
        ),
      );
      return response;
    } catch (error) {
      throw Exception("error api client $error");
    }
  }

  // register
  Future<Response> postDataRegister({
    required String endpoint,
    required String username,
    required String email,
    required String password,
    File? profileImage,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "name": username,
        "email": email,
        "password": password,
      });

      if (profileImage != null) {
        formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(profileImage.path,
              filename: 'profileImage.jpg'),
        ));
      }

      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status! <= 500,
        ),
      );
      return response;
    } catch (error) {
      throw Exception("error api client $error");
    }
  }
}
