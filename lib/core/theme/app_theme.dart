// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

abstract final class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: Colors.black87,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF424242),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      textTheme: Typography.whiteMountainView
          .apply(fontFamily: AppConstants.fontRobotoCondensed),
      primaryTextTheme: Typography.whiteMountainView
          .apply(fontFamily: AppConstants.fontShareTechMono),
    );
  }
}
