import 'package:firebase_auth/firebase_auth.dart';
import '/View/NavBar.dart';
import 'package:flutter/material.dart';
import '/Widgets/AddCourse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/Widgets/Check_User.dart';
import '/View/loginPage.dart';

class Course {
  String id;
  String title;
  String description;
  String image;

  Course(
      {required this.id,
      required this.title,
      required this.description,
      required this.image});
}

class MyCoursesPage extends StatefulWidget {
// final String roles;
//   CoursesPage({required this.roles});
  MyCoursesPage({
    Key? key,
  }) : super(key: key);
  @override
  MyCoursesPageState createState() => MyCoursesPageState();
}

// class CoursesPage extends StatefulWidget {
//   final String userRole;
//
//   CoursesPage({required this.userRole});
//
//   @override
//   CoursesPageState createState() => CoursesPageState();
// }

class MyCoursesPageState extends State<MyCoursesPage> {
  final CollectionReference coursesCollection =
      FirebaseFirestore.instance.collection('courses');

  void addCourse(
      String courseTitle, String courseDescription, String courseImage) {
    var newCourse = Course(
      id: UniqueKey()
          .toString(), // You can use any method to generate a unique ID
      title: courseTitle,
      description: courseDescription,
      image: courseImage,
    );

    coursesCollection.doc(newCourse.id).set({
      'title': newCourse.title,
      'description': newCourse.description,
      'image': newCourse.image,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Center(child: Text('My Courses')),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: coursesCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No courses available.'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var courseDocument = snapshot.data!.docs[index];
                var courseId = courseDocument.id; // Get the document ID

                return buildCourseCard(
                  Course(
                    id: courseId, // Include the document ID in the Course instance
                    title: courseDocument['title'],
                    description: courseDocument['description'],
                    image: courseDocument['image'],
                  ),
                );
              },
            );
          },
        ),

        // The add ActionButton is to add course Only for teacher and admin

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _promptUserForCourse();
          },
          child: Icon(Icons.add),
        ));
  }

  Widget buildCourseCard(Course course) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              course.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250.0,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
                color: Colors.white,
              ),
              // padding: EdgeInsets.all(2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                          future: coursesCollection.doc(course.id).get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (!snapshot.hasData) {
                              return Text('Loading...');
                            }

                            var document = snapshot.data as DocumentSnapshot;
                            var title = document.get('title') as String?;
                            var description =
                                document.get('description') as String?;

                            if (title != null) {
                              return Text(
                                title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              );
                            } else {
                              return Text('Title not available');
                            }
                          },
                        ),
                        SizedBox(height: 8.0),
                        FutureBuilder(
                          future: coursesCollection.doc(course.id).get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (!snapshot.hasData) {
                              return Text('Loading...');
                            }

                            var document = snapshot.data as DocumentSnapshot;
                            var description =
                                document.get('description') as String?;

                            if (description != null) {
                              return Text(
                                description,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              );
                            } else {
                              return Text('Description not available');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                          primary: Colors.black12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'View',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                          primary: Colors.black12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                            'Edit',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  )
                  // ... rest of the code
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _promptUserForCourse() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddCourses(
          onAddCourse: addCourse,
        );
      },
    );
  }
}
