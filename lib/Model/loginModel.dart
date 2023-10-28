import 'package:firebase_auth/firebase_auth.dart';

class LoginModel {
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;

    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}
