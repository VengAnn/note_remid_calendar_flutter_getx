//
import 'dart:io';

import 'package:note_schedule_reminder/models/auth_models/user_auth_res.dart';

abstract class AuthRepo {
  Future<UserAuthRes?> login(String email, String password);
  Future<bool> logout();

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    File? profile,
  });
}
