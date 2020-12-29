import 'package:NotesApp/constants/constants.dart';
import 'package:NotesApp/views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: appBarColor,
          primaryIconTheme: IconThemeData(color: iconColor)),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
