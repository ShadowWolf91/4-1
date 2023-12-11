import 'package:flutter/material.dart';
import 'home_page.dart';
import 'food.dart';
import 'settings_page.dart';
import 'shared_preferences_page.dart';


Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueAccent),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/food': (context) => const FoodPage(),
        '/settings': (context) => const SettingsPage(),
        '/sharedPreferences': (context) => const SharedPreferencesPage(),
      },
    );
  }
}

