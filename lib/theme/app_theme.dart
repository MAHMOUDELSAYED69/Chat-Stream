import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/constant/color.dart';

abstract class AppTheme {
  //? LIGHT THEME
  static ThemeData get lightTheme {
    return ThemeData(
      switchTheme: const SwitchThemeData(
        trackOutlineColor: WidgetStatePropertyAll(ColorManager.black),
        thumbColor: WidgetStatePropertyAll(ColorManager.black),
        trackColor: WidgetStatePropertyAll(ColorManager.white),
        thumbIcon: WidgetStatePropertyAll(
          Icon(
            Icons.light_mode,
            color: ColorManager.white,
          ),
        ),
      ),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorManager.purple,
        selectionColor: ColorManager.purple.withOpacity(0.3),
        selectionHandleColor: ColorManager.purple,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: ColorManager.white,
          textStyle: TextStyle(
              fontSize: 16.spMin,
              color: ColorManager.white,
              fontWeight: FontWeight.w500),
          overlayColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          backgroundColor: ColorManager.purple,
          fixedSize: const Size(double.maxFinite, 54),
        ),
      ),
      iconTheme: const IconThemeData(color: ColorManager.black),
      fontFamily: 'Rubik',
      useMaterial3: true,
      brightness: Brightness.light,
      // primarySwatch: ColorManager.green ,
      scaffoldBackgroundColor: ColorManager.darkGrey,
      appBarTheme: AppBarTheme(
        elevation: BorderSide.strokeAlignOutside,
        backgroundColor: ColorManager.purple,
        shadowColor: ColorManager.darkGrey,
        centerTitle: false,
        iconTheme: const IconThemeData(color: ColorManager.black),
        titleTextStyle: TextStyle(
            color: ColorManager.black,
            fontSize: 20.spMin,
            fontWeight: FontWeight.w600),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 24.spMin,
            color: ColorManager.white,
            fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(
            fontSize: 16.spMin,
            color: ColorManager.lightGrey,
            fontWeight: FontWeight.w500),
        bodySmall: TextStyle(
          fontSize: 14.spMin,
          fontWeight: FontWeight.w500,
          color: ColorManager.lightGrey,
        ),
        displayMedium: TextStyle(
            fontSize: 16.spMin,
            color: ColorManager.lightGrey,
            fontWeight: FontWeight.w500),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        isCollapsed: true,
        isDense: true,
        errorStyle: TextStyle(fontSize: 16, color: ColorManager.red),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.red,
                width: 2,
                strokeAlign: BorderSide.strokeAlignCenter)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.red,
                width: 2,
                strokeAlign: BorderSide.strokeAlignCenter)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        filled: true,
        fillColor: ColorManager.darkGrey2,
      ),
    );
  }
}
