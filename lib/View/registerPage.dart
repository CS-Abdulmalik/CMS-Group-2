import 'package:flutter/material.dart';
import '/Widgets/text_input.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {

  // text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


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

          // welcome message
          Text(
            "Registor",
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
            controller: emailController,
            labelText: 'Email',
            hintText: 'example@email.com',
            obscureText: false,
          ),

          SizedBox(
            height: 15,
          ),

          // Password Input
          textInput(
            controller: passwordController,
            labelText: 'Password',
            hintText: 'Enter your password',
            obscureText: true,
          ),

          SizedBox(
            height: 10,
          ),
          // Confirm Password Input
          textInput(
            controller: confirmPasswordController,
            labelText: 'Confirm Password',
            hintText: 'Enter your password',
            obscureText: true,
          ),

          SizedBox(
            height: 20,
          ),

          // Sign up Button for registor
          ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  minimumSize: MaterialStateProperty.all(Size(365, 50))),
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 24, color: Colors.white70),
              )),
          SizedBox(
            height: 5,
          ),

          // Back to the login page
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Are you member?',
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