import 'package:firebase_auth/firebase_auth.dart';

import '../Model/RegisterPageModel.dart';

class RegisterController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(RegisterModel user) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      // Registration was successful, you can handle this as needed.
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}
