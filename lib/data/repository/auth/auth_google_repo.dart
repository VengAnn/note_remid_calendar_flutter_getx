abstract class AuthGoogleRepo {
  Future<Map<String, dynamic>> authGoogleRegisterToMyBackend({
    required String email,
    required String name,
    String? photoUrl,
  });
}
