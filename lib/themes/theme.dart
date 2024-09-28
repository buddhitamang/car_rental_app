import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.grey.shade100, // Define a primary color
  colorScheme: ColorScheme.light(
    surface:Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade100,
    onPrimary: Colors.white, // Text color on primary background
    onSecondary: Colors.black, // Text color on secondary background
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black54),
    displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
    displayMedium: TextStyle(color: Colors.grey.shade600),
    displaySmall: TextStyle(color: Colors.grey.shade500),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue, // Button color
    textTheme: ButtonTextTheme.primary,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black, // Define a primary color
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    onPrimary: Colors.black, // Text color on primary background
    onSecondary: Colors.white, // Text color on secondary background
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
    displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.grey.shade200),
    displayMedium: TextStyle(color: Colors.grey.shade100),
    displaySmall: TextStyle(color: Colors.grey.shade100),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue, // Button color
    textTheme: ButtonTextTheme.primary,
  ),
);
