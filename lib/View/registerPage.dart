import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/Controller/RegisterPageController.dart';
import '../Widgets/text_input.dart';
import '/View/homePage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RegisterController controller = RegisterController();

// singUp method
  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    // check if the passwords are the same
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // Stop loading and navigate to Home Page
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => homePage()));
      } else {
        // Error Passwords are different
        Navigator.pop(context);
        showErrorMessage("Passwords are different");
      }
    } on FirebaseAuthException catch (e) {

        // Show Error like already in use
      Navigator.pop(context);
      showErrorMessage("An error occurred: ${e.code}");
    }
  }
// Show Error Messages method
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
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
          Icon(
            Icons.account_circle_rounded,
            size: 100,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Register",
            style: TextStyle(
                fontSize: 24,
                color: Colors.black45,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          textInput(
            controller: emailController,
            labelText: 'Email',
            hintText: 'example@email.com',
            obscureText: false,
          ),
          SizedBox(
            height: 15,
          ),
          textInput(
            controller: passwordController,
            labelText: 'Password',
            hintText: 'Enter your password',
            obscureText: true,
          ),
          SizedBox(
            height: 10,
          ),
          textInput(
            controller: confirmPasswordController,
            labelText: 'Confirm Password',
            hintText: 'Enter your password',
            obscureText: true,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: signUp,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  minimumSize: MaterialStateProperty.all(Size(341, 50))),
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 24, color: Colors.white70),
              )),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Are you a member?',
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
