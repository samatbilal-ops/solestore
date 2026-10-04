import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color seed = Color(0xFFFF5A1F);
  static const Color background = Color(0xFFF7F7F9);

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seed,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),
    );
  }
}
