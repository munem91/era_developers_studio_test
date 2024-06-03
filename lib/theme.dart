import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: GoogleFonts.roboto(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.02,
    ),
    actionsIconTheme: const IconThemeData(color: Colors.black),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.roboto(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.02,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.02,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.02,
    ),
  ),
);
