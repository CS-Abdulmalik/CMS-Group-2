import 'package:cms_group2/Widgets/Check_User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Controller/LoginPageController.dart';
import '../Widgets/text_input.dart';
import '../Model/loginModel.dart';
import '../Controller/LoginPageController.dart';
import 'registerPage.dart';
import 'forgetPasswordPage.dart';
import '../Widgets/text_input.dart';
import '/View/homePage.dart';
import '/Widgets/Check_User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginPageController controller = LoginPageController();

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

  // Future<void> signIn() async {
  //   showDialog(
  //     context: context,
  //     builder: (context) => Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  //   try {
  //     await controller.signIn(emailController.text, passwordController.text);
  //     Navigator.pop(context);
  //     Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (context) => homePage()));
  //   } on FirebaseAuthException catch (e) {
  //     Navigator.pop(context);
  //
  //     if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
  //       showErrorMessage("User not found or Wrong password");
  //     } else {
  //       showErrorMessage("An error occurred: ${e.code}");
  //     }
  //   }
  // }

  Future<void> signIn() async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = FirebaseAuth.instance.currentUser;

      var firebaseData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      // .then((DocumentSnapshot documentSnapshot) {

      if (firebaseData.exists) {
        String role =
            firebaseData.get('role');

        Navigator.pop(context);

        if (role == "admin") {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AdminPage(),
          //   ),
          // );
          showErrorMessage("Welcome, Admin!");

        } else if (role == "student") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => homePage()));
          showErrorMessage("Welcome, Student!");

        } else if (role == "teacher") {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => TeacherPage(),
          //   ),
          // );
          showErrorMessage("Welcome, Teacher!");
        } else {
          showErrorMessage("Unknown user role");
        }

        // Check if user data inside Firestore

        // } else {
        //   Navigator.pop(context); // Close loading dialog
        //   showErrorMessage("User not in Firestore");
        // }

        // Massage Error for the User
      }
    } catch (e) {
      Navigator.pop(context);
      if (e is FirebaseAuthException) {
        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          showErrorMessage("User not found or Wrong password");
        } else {
          showErrorMessage("An error occurred: ${e.code}");
        }
      }
    }
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
            "Welcome back",
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
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgetPasswordPage()));
                  },
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
              onPressed: signIn,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  minimumSize: MaterialStateProperty.all(Size(341, 50))),
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 24, color: Colors.white70),
              )),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Not a member?',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Text(
                  'Register now',
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
