import 'package:note_schedule_reminder/models/auth_models/user_auth_res.dart';

abstract class AuthGoogleRepo {
  Future<UserAuthRes?> authGoogleRegisterToMyBackend({
    required String email,
    required String name,
    String? photoUrl,
  });
}
