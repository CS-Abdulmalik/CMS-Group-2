import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordController {
  final TextEditingController emailController;
  final BuildContext context;

  ForgetPasswordController(this.context) : emailController = TextEditingController();

  Future passwordReset() async {
    // Get the user's email address from the view
    String email = emailController.text;

    // Send a password reset email to the user
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    // Show a success message to the user
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Password reset link sent! check your Email if you don\'t receive the link, please \"sign up\"'),
        );
      },
    );
  }

}