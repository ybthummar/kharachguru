import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blue,
      accentColor: Colors.orange,
      backgroundColor: Colors.white,
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.black, fontSize: 16),
        bodyText2: TextStyle(color: Colors.grey, fontSize: 14),
        headline1: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      appBarTheme: AppBarTheme(
        color: Colors.blue,
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blue,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.red,
      backgroundColor: Colors.grey[850],
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white, fontSize: 16),
        bodyText2: TextStyle(color: Colors.grey[400], fontSize: 14),
        headline1: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      appBarTheme: AppBarTheme(
        color: Colors.black,
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.red,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}