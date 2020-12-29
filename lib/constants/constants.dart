import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color appBarColor = Colors.white;
const Color iconColor = Colors.black;
const Color bgColor = Colors.white;
const Color borderColor = Colors.grey;
final Color themeMainColor = Colors.amber[300];
final Color textFieldColor = Colors.grey[200];
final Color themeSecondaryColor = Colors.white;

List<dynamic> colorList = [
  Color(0xffA6F2A6),
  Color(0xffEEAADC),
  Color(0xffF8E08C),
  Color(0xff79DBF6),
  Color(0xff8EB8B2),
  Color(0xffB7C6CC),
];

TextStyle hintTextStyle() {
  return GoogleFonts.sniglet(fontSize: 20);
}

TextStyle appBarTextStyle() {
  return GoogleFonts.sniglet(fontSize: 25, fontWeight: FontWeight.w500);
}

TextStyle titleTextStyle() {
  return GoogleFonts.sniglet(fontSize: 20);
}

TextStyle descriptionTextStyle() {
  return GoogleFonts.sniglet(fontSize: 16);
}

TextStyle timeTextStyle() {
  return GoogleFonts.sniglet(fontSize: 15);
}

TextStyle buttonTextStyle() {
  return GoogleFonts.sniglet(fontSize: 17);
}

TextStyle inputTextStyle() {
  return GoogleFonts.sniglet(fontSize: 20);
}
