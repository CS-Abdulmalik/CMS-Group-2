import 'package:flutter/material.dart';
import '/View/NavBar.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Center(child: Text("Profile"),),
      ),

    );
  }
}
