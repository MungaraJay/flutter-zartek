import 'dart:developer' as logger;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleHelper {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();

  static User? get user => auth.currentUser;

  static Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final User? user = await auth
          .signInWithCredential(authCredential)
          .then((result) => result.user);

      logger.log('Google user Signed In!! : $user');
      return user;
    } catch (googleError) {
      logger.log('googleError : $googleError');

      rethrow;
    }
  }

  static Future signOutGoogle() async {
    await auth.signOut();

    logger.log("User Signed Out!!");
  }
}
