import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:lab10/splash_screen/splash_screen.dart';
import 'package:lab10/presentation/pages/home_page.dart';
import 'package:lab10/presentation/pages/login_page.dart';
import 'package:lab10/presentation/pages/sign_up_page.dart';
import 'firebase_api.dart';
Future main() async {
  print("a");
  try {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint("a");


    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB9Qh2-ZPeM1bABF4FvP-m0-berecOrESE",
          authDomain: "lab10-f6bc0.firebaseapp.com",
          projectId: "lab10-f6bc0",
          storageBucket: "lab10-f6bc0.appspot.com",
          messagingSenderId: "866518178278",
          appId: "1:866518178278:web:4c8950321e617f56691e27",
          measurementId: "G-G022P2M0KB"
      ),
    );
    await FirebaseApi().initNotifications();
    debugPrint("a");


  runApp(MyApp());
  debugPrint("deowjf");} catch (e) {
debugPrint('Error initializing Firebase: $e');
}
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("a");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => SplashScreen(
          child: LoginPage(),
        ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
