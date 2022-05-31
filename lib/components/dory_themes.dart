import 'package:flutter/material.dart';
import 'package:dory/components/dory_colors.dart';

class DoryThemes {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch: DoryColors.primaryMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.white,
        //brightness 설정이 가장 중요.
        brightness: Brightness.light,
        fontFamily: 'GmarketSansTTF',
        textTheme: _textTheme,
        appBarTheme: _appBarTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static ThemeData get darkTheme => ThemeData(
        primarySwatch: DoryColors.primaryMaterialColor,
        //brightness 설정이 가장 중요.
        brightness: Brightness.dark,
        splashColor: Colors.white,
        fontFamily: 'GmarketSansTTF',
        textTheme: _textTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static const TextTheme _textTheme = TextTheme(
    headline4: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyText1: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
    button: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: DoryColors.primaryColor));
}
