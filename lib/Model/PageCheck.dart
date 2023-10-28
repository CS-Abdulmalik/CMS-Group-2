import 'package:flutter/material.dart';


bool isUserOnPage(BuildContext context, String pageName) {
  final currentRoute = ModalRoute.of(context);
  if (currentRoute != null) {
    return currentRoute.settings.name == pageName;
  }
  return false;
}
