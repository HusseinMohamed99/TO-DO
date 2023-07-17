import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/shared/enum/enum.dart';
import 'package:todo/styles/colors.dart';

final getThemeData = {
  AppTheme.lightTheme: ThemeData(
    scaffoldBackgroundColor: AppColorsLight.scaffoldBackgroundColor,
    primarySwatch: Colors.teal,
    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColorsLight.bottomNavColor,
      backgroundColor: Colors.white,
      elevation: 25.0,
      unselectedIconTheme: IconThemeData(
        color: Colors.black54,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: AppColorsLight.textColor),
      titleMedium: GoogleFonts.roboto(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColorsLight.textColor,
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColorsLight.greyColor,
      ),
      bodyLarge: GoogleFonts.roboto(
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
          color: AppColorsLight.textColor),
      bodyMedium: GoogleFonts.roboto(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColorsLight.textColor),
      bodySmall: GoogleFonts.roboto(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: AppColorsLight.greyColor),
    ),
  ),
  AppTheme.darkTheme: ThemeData(
    scaffoldBackgroundColor: AppColorsDark.primaryDarkColor,
    primarySwatch: Colors.blue,
    cardColor: AppColorsDark.primaryDarkColor,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColorsDark.primaryDarkColor,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: AppColorsDark.primaryDarkColor,
      elevation: 0.0,
      titleTextStyle: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColorsDark.bottomNavColor,
      unselectedItemColor: Colors.white,
      backgroundColor: AppColorsDark.primaryDarkColor,
      elevation: 25.0,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: AppColorsDark.textColor,
      ),
      titleMedium: GoogleFonts.roboto(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColorsDark.textColor,
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColorsDark.greyColor,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
        color: AppColorsDark.textColor,
      ),
      bodyMedium: GoogleFonts.roboto(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColorsDark.textColor),
      bodySmall: GoogleFonts.roboto(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: AppColorsDark.greyColor),
    ),
  ),
};
