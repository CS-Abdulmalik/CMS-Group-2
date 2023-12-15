import 'package:flutter/material.dart';
import 'NavBar.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => AdminPageState();
}

class AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Center(child: Text('Admin Dashboard'),),
      ),
    );
  }
}
