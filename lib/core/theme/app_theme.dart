import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final appThemeDark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _outlineBorder(),
      focusedBorder: _outlineBorder(AppPallete.gradient2),
    ),
  );

  static OutlineInputBorder _outlineBorder(
      [Color color = AppPallete.borderColor]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 3,
        color: color,
      ),
    );
  }
}
