import 'package:flutter/material.dart';

final yellowTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black.withOpacity(0.9),
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    bodySmall: TextStyle(
      color: Colors.black.withOpacity(0.6),
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
  ),
);