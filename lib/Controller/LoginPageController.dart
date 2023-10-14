import 'package:firebase_auth/firebase_auth.dart';
import '../Model/loginModel.dart';

class LoginPageController {
  final LoginModel userModel = LoginModel();

  Future<void> signIn(String email, String password) async {
    try {
      await userModel.signInWithEmailAndPassword(email, password);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}
