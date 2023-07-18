import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/shared/enum/enum.dart';
import 'package:todo/styles/colors.dart';

final getThemeData = {
  AppTheme.lightTheme: ThemeData(
    scaffoldBackgroundColor: AppColorsLight.primaryColor,
    primarySwatch: Colors.teal,
    cardColor: AppMainColors.whiteColor,
    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColorsLight.primaryColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: AppColorsLight.primaryColor,
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColorsLight.tealColor,
      backgroundColor: AppColorsLight.primaryColor,
      elevation: 25.0,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        size: 30.sp,
        color: AppColorsLight.tealColor,
      ),
      unselectedIconTheme: IconThemeData(
        size: 24.sp,
        color: AppMainColors.greyColor,
      ),
      selectedLabelStyle: const TextStyle(
        color: AppColorsLight.tealColor,
      ),
      unselectedLabelStyle: const TextStyle(
        color: AppMainColors.greyColor,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: AppColorsLight.tealColor),
      titleMedium: GoogleFonts.roboto(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColorsLight.tealColor,
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppMainColors.greyColor,
      ),
      bodyLarge: GoogleFonts.roboto(
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
          color: AppColorsLight.tealColor),
      bodyMedium: GoogleFonts.roboto(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColorsLight.tealColor),
      bodySmall: GoogleFonts.roboto(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: AppMainColors.greyColor),
    ),
  ),
  AppTheme.darkTheme: ThemeData(
    scaffoldBackgroundColor: AppColorsDark.primaryDarkColor,
    primarySwatch: Colors.blue,
    cardColor: AppColorsDark.primaryDarkColor,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
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
      actionsIconTheme: const IconThemeData(
        color: AppMainColors.whiteColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppMainColors.blueColor,
      unselectedItemColor: AppMainColors.greyColor,
      backgroundColor: AppColorsDark.primaryDarkColor,
      elevation: 25.0,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        size: 30.sp,
        color: AppMainColors.blueColor,
      ),
      unselectedIconTheme: IconThemeData(
        size: 24.sp,
        color: AppMainColors.greyColor,
      ),
      selectedLabelStyle: const TextStyle(
        color: AppMainColors.blueColor,
      ),
      unselectedLabelStyle: const TextStyle(
        color: AppMainColors.greyColor,
      ),
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
        color: AppMainColors.greyColor,
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
          color: AppMainColors.greyColor),
    ),
  ),
};
