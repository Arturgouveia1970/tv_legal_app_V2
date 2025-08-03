import 'package:flutter/material.dart';
import 'tv_legal_flutter/home_page.dart';    // Correct path for HomePage
import 'tv_legal_flutter/splash_screen.dart'; // Correct path for SplashScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TV Legal',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
          titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      // Show SplashScreen first
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomePage(), // Navigate to HomePage after SplashScreen
      },
    );
  }
}
