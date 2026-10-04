import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const ShopApp());

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoleStore',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      // Clamp system font scaling so huge accessibility fonts never break layouts.
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        minScaleFactor: 1.0,
        maxScaleFactor: 1.3,
        child: child!,
      ),
      home: const HomeScreen(),
    );
  }
}
