import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeApp {
  static const Color primaryDarkColor = Color(0xff333739);
  static const Color primaryLightColor = Color(0xffffffff);
  static const Color defaultColor = Colors.blueAccent;
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: primaryDarkColor,
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: primaryDarkColor,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: primaryDarkColor,
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
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.white,
      backgroundColor: primaryDarkColor,
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
  );
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: primaryLightColor,
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
      selectedItemColor: defaultColor,
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
  );
}
