import 'package:flutter/material.dart';
import 'calculadora_homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        brightness: Brightness.dark, scaffoldBackgroundColor: const Color(0xFF0B0B12)
      ),
      home: const CalculadoraHomepage(),
   
   

    );
  }
}

