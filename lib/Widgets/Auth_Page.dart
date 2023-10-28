import 'package:cms_group2/View/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../View/forgetPasswordPage.dart';
import '../View/homePage.dart';
import '../View/registerPage.dart';
import '/Widgets/Login_Or_Register_Page.dart';


class authPage extends StatelessWidget {
  const authPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user has been Sign In
          if (snapshot.hasData) {
            return homePage();
          }
          // User hasn't been Sing In
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
