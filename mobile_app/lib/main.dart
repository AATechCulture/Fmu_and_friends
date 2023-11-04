import 'package:mobile_app/home.dart';
import 'package:mobile_app/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AASharp',
      theme: appTheme,
      //TODO: change title
      home: const HomePage(title: 'American Airlines Luggage'),
    );
  }
}