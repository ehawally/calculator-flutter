import 'package:flutter/material.dart';
import 'calculadora_homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor:
            isDark ? const Color(0xFF0B0B12) : Colors.white,
      ),
      home: CalculadoraHomepage(
        onThemeChanged: () {
          setState(() {
            isDark = !isDark;
          });
        },
      ),
    );
  }
}