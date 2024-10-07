import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData mainTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
  }
}
