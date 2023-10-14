import 'package:flutter/material.dart';

// Email and Password Widget

class textInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;

  const textInput({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black38)),
          fillColor: Colors.white38,
          filled: true,
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
