import 'package:flutter/material.dart';
import '/Widgets/text_input.dart';

class forgetPasswordPage extends StatefulWidget {
  const forgetPasswordPage({super.key});

  @override
  State<forgetPasswordPage> createState() => _forgetPasswordPageState();
}

class _forgetPasswordPageState extends State<forgetPasswordPage> {
  // text editing controller
  final emailController = TextEditingController();

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
            controller: emailController,
            labelText: 'Email',
            hintText: 'example@email.com',
            obscureText: false,
          ),

          SizedBox(
            height: 5,
          ),
          // Send Button for forget password
          ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  minimumSize: MaterialStateProperty.all(Size(360, 50))),
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
