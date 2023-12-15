import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Controller/LoginPageController.dart';
import '../Widgets/text_input.dart';
import 'CoursesPage.dart';
import 'registerPage.dart';
import 'forgetPasswordPage.dart';
import '/View/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/View/CoursesPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key,}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginPageController controller = LoginPageController();

  // static String? userEmail;
  // static String? userPassword;
  static String? userRole;
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

  Future<String?> signIn() async {
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
      // setState(() {
      //   userEmail = emailController.text;
      //   userPassword = passwordController.text;
      // });

      User? user = FirebaseAuth.instance.currentUser;

      var firebaseData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      // .then((DocumentSnapshot documentSnapshot) {

      if (firebaseData.exists) {
         String role = firebaseData.get('role');

         setState(() {
           userRole = role; // Set the userRole variable
         });

        Navigator.pop(context);

        // For testing if the What User login

        if (role == "admin") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => homePage()));
          showErrorMessage("Welcome, Admin!");
        } else if (role == "student") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => homePage()));
          showErrorMessage("Welcome, Student!");
        } else if (role == "teacher") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => homePage()));
          showErrorMessage("Welcome, Teacher!");
        } else {
          showErrorMessage("Unknown user role");
        }
      }

      // Massage Error for the User
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
    return null;
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
