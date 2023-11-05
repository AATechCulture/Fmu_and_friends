import 'package:flutter/material.dart';

// Define the app theme & set brightness
final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF0078D2),
    brightness: Brightness.light,
  ).copyWith(
    
    primary: const Color(0xFF0078D2), // aa-blue
    onPrimary: Colors.white,
    secondary: const Color(0xFF36495A), // aa-darkblue
    onSecondary: Colors.white, 
    background: const Color(0xFF131313), // aa-black
    onBackground: Colors.white, 
    surface: Colors.white, 
    onSurface: const Color(0xFF131313), 
    error: const Color(0xFFC30019), // aa-red
    onError: Colors.white, 
    brightness: Brightness.light,
  ),

//Defining font and style
  fontFamily: 'Helvetica',

  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Arial'),
  ),

//Defining theme &color
  appBarTheme: const AppBarTheme(
    color: Color(0xFF36495A), // aa-darkblue
  ),
);
