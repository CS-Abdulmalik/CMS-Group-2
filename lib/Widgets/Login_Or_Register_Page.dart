import 'package:cms_group2/View/registerPage.dart';
import 'package:flutter/material.dart';
import '../View/loginPage.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
   if (showLoginPage){
     return LoginPage();
   } else {
     return RegisterPage();
   }
  }
}
