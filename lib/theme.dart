import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      fontFamily: 'SFProDisplay',
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
    ),
    actionsIconTheme: IconThemeData(color: Colors.black),
  ),
  textTheme: const TextTheme(
    // Text 4/R18
    displayLarge: TextStyle(
      fontFamily: 'SFProDisplay',
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
      color: Colors.black,
    ),
    // Text with font size 28px
    displayMedium: TextStyle(
      fontFamily: 'SFProDisplay',
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.02,
      color: Colors.white,
    ),
    // Text 2/M16
    bodyLarge: TextStyle(
      fontFamily: 'SFProDisplay',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.02,
    ),
    // Text 3/R12
    bodyMedium: TextStyle(
      fontFamily: 'SFProDisplay',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.02,
    ),
    // Text 2/M16 duplicate
    titleMedium: TextStyle(
        fontFamily: 'SFProDisplay',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.02,
        color: Colors.grey),
  ),
);
