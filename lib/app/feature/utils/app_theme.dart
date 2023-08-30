import 'package:flutter/material.dart';

import 'app_constants.dart';

sealed class AppTheme {
  static const OutlineInputBorder _defaultOutlineInputBorder =
      OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
    borderSide: BorderSide(color: AppConstantColors.grey),
  );
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppConstantColors.white,
      labelStyle: const TextStyle(color: AppConstantColors.grey),
      border: _defaultOutlineInputBorder,
      enabledBorder: _defaultOutlineInputBorder,
      errorBorder: _defaultOutlineInputBorder.copyWith(
        borderSide: const BorderSide(
          color: AppConstantColors.red,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          foregroundColor: AppConstantColors.white,
          backgroundColor: AppConstantColors.brow,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: AppConstantColors.brow,
          width: 1,
        ),
        foregroundColor: AppConstantColors.brow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(color: AppConstantColors.brow),
      backgroundColor: AppConstantColors.white,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: AppConstantColors.black,
      ),
    ),
  );
}
