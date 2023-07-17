import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/shared/enum/enum.dart';
import 'package:todo/styles/colors.dart';

final getThemeData = {
  AppTheme.lightTheme: ThemeData(
    scaffoldBackgroundColor: AppColorsLight.primaryLightColor,
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
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
      fontSize: 18.0,
      color: Colors.black,
    )),
    fontFamily: 'Jannah',
  ),
  AppTheme.darkTheme: ThemeData(
    scaffoldBackgroundColor: AppColorsDark.primaryDarkColor,
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColorsDark.primaryDarkColor,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: AppColorsDark.primaryDarkColor,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
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
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
      fontSize: 18.0,
      color: Colors.white,
    )),
    iconTheme: const IconThemeData(
      color: Colors.black54,
    ),
    fontFamily: 'Jannah',
  ),
};
