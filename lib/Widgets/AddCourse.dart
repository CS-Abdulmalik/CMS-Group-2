import 'package:flutter/material.dart';

class AddCourses extends StatefulWidget {
  final Function(String, String, String) onAddCourse;

  const AddCourses({Key? key, required this.onAddCourse}) : super(key: key);

  @override
  AddCoursesState createState() => AddCoursesState();
}

class AddCoursesState extends State<AddCourses> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController image = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Course'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: title,
            decoration: InputDecoration(labelText: 'Course Title'),
          ),
          TextField(
            controller: description,
            decoration: InputDecoration(labelText: 'Course Description'),
          ),
          TextField(
            controller: image,
            decoration: InputDecoration(labelText: 'Course Image URL'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onAddCourse(title.text, description.text, image.text);
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
