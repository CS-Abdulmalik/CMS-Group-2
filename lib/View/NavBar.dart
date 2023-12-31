import 'package:cms_group2/View/ProfilePage.dart';
import 'package:cms_group2/View/AdminPage.dart';
import 'package:cms_group2/View/forgetPasswordPage.dart';
import 'package:cms_group2/View/homePage.dart';
import 'package:cms_group2/View/loginPage.dart';
import 'package:cms_group2/View/registerPage.dart';
import 'package:cms_group2/Widgets/Check_User.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/Model/PageCheck.dart';
import '/View/CoursesPage.dart';
import 'MyCoursesPage.dart';

class NavBar extends StatelessWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(''),
            accountEmail: Text(user != null ? user.email ?? '' : ''),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://th.bing.com/th/id/OIP.kEo4qVcBiF-zUSz1nnBDuAHaHa?pid=ImgDet&w=197&h=197&c=7',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(color: Colors.black87
                // image: DecorationImage(
                //   image: Image.network(src)

                // )
                ),
          ),

          // Home Page

          TextButton(
              onPressed: () {
                if (!isUserOnPage(context, '/homePage')) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => homePage()));
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Home Page",
                style: TextStyle(fontSize: 16, color: Colors.black),
              )),

          // Courses Page

          TextButton(
              onPressed: () {
                if (!isUserOnPage(context, '/CoursesPage')) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CoursesPage()));
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text("Courses",
                  style: TextStyle(fontSize: 16, color: Colors.black))),

          // This Teachers courses only can see the buttom if the user is Teacher

          Visibility(
            visible: LoginPageState.userRole != null &&
                (LoginPageState.userRole!.contains('teacher')),
            child: TextButton(
              onPressed: () {
                if (!isUserOnPage(context, '/MyCoursesPage')) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyCoursesPage()));
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text(
                "My Courses",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),

          // Profile Page

          TextButton(
              onPressed: () {
                if (!isUserOnPage(context, '/ProfilePage')) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text("Profile ",
                  style: TextStyle(fontSize: 16, color: Colors.black))),

          // Admin Dashbord visible only for Admins

          Visibility(
            visible: LoginPageState.userRole != null &&
                LoginPageState.userRole!.contains('admin'),
            child: TextButton(
                onPressed: () {
                  if (!isUserOnPage(context, '/AdminPage')) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AdminPage()));
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text("Admin Dashboard",
                    style: TextStyle(fontSize: 16, color: Colors.black))),
          ),

          // Logout

          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text("Log out",
                style: TextStyle(fontSize: 16, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
