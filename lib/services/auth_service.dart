import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_schedule_reminder/components/dialogs.dart';

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  // to return current user
  static User get user => auth.currentUser!;

  // Google sign in
  static signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Begin interactive sign-in process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If the user cancels the sign-in process
      if (googleUser == null) {
        Dialogs.showSnackBar('Sign in aborted by user');
        return null;
      }

      // Obtain auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create credentials for the user
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Finally, let's sign in
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      // // If sign-in is successful, return the userCredential
      if (userCredential.user != null) {
        return userCredential;
      } else {
        Dialogs.showSnackBar(' Something Went Wrong!');
        return null;
      }
    } catch (e) {
      log('Error: ${e.toString()}');
      Dialogs.showSnackBar(' Something Went Wrong (Check Internet!)');
      //return 'Error: ${e.toString()}';
    }
  }
}
