// Importing important packages require to connect
// Flutter and Dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'secondPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World Demo Application',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const SecondPage(title: 'Home page'),
    );
  }
}