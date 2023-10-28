import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Controller/ForgetPasswordPageController.dart';
import '../Widgets/text_input.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key,}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final ForgetPasswordController = TextEditingController();

  Future passwordReset() async {
    // Get the user's email address from the view.
    String email = ForgetPasswordController.text;

    // Send a password reset email to the user.
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    // Show a success message to the user.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Password reset link sent! check your Email if you don\'t receive the link, please \"sign up\"'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logo
          Icon(
            Icons.account_circle_rounded,
            size: 100,
          ),
          SizedBox(
            height: 20,
          ),

          // Forget Password message
          Text(
            "Forget Password",
            style: TextStyle(
                fontSize: 24,
                color: Colors.black45,
                fontWeight: FontWeight.bold),
          ),

          SizedBox(
            height: 20,
          ),

          // Email Input
          textInput(
            controller: ForgetPasswordController,
            labelText: 'Email',
            hintText: 'example@email.com',
            obscureText: false,
          ),

          SizedBox(
            height: 5,
          ),
          // Send Button for forget password
          ElevatedButton(
              onPressed: passwordReset,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  minimumSize: MaterialStateProperty.all(Size(341, 50))),
              child: Text(
                'Send',
                style: TextStyle(fontSize: 24, color: Colors.white70),
              )),

          // Back to the login page
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Do remember your password?',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
