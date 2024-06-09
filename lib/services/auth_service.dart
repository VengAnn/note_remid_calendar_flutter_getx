import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  // to return current user
  static User get user => auth.currentUser!;

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null; // Authentication cancelled
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      return userCredential; // Return user credential
    } catch (e) {
      log('Error: ${e.toString()}');
      return null; // Return null in case of error
    }
  }
}
