import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        actions: [
          IconButton(
            onPressed: signOut,
            icon: Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: Center(
        child: Text("Signed In"),
      ),
    );
  }
}
