import 'package:flutter/material.dart';
import '/Widgets/text_input.dart';
import '/View/registerPage.dart';
import '/View/forgetPasswordPage.dart';

class loginPage extends StatelessWidget {
  loginPage({super.key});

  // text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
            "Welcome back",
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
            height: 5,
          ),

          // Forget Password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => forgetPasswordPage()));
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
            height: 20,
          ),

          // Sign In Button
          ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  minimumSize: MaterialStateProperty.all(Size(360, 50))),
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 24, color: Colors.white70),
              )),
          SizedBox(
            height: 5,
          ),

          // Register
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
                      MaterialPageRoute(builder: (context) => registerPage()));
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
