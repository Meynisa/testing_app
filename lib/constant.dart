import 'package:flutter/material.dart';

class SwatchColor {
  SwatchColor._();
  static const kGreyColor = Color(0xFFB3B8C4);
  static const kBlackColor = Color(0xFF05060C);
  static const kPeachColor = Color(0xFFDF6C61);
  static const kDarkGreyColor = Color(0xFF504B5A);
  static const kPurpleGreyColor = Color(0xFF977E86);
  static const kLightPeachColor = Color(0xFFDDABA7);
}

final ThemeData themeData = new ThemeData(
  fontFamily: "Comfortaa",
  brightness: Brightness.light,
  primaryColor: SwatchColor.kDarkGreyColor,
  accentColor: SwatchColor.kLightPeachColor,
  buttonColor: SwatchColor.kPeachColor,
  textTheme: TextTheme(
      headline: TextStyle(fontSize: 36.0,fontWeight: FontWeight.bold, fontFamily: 'Pacifico', color: SwatchColor.kLightPeachColor),
      title: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Comfortaa')),
);

final TextStyle textFieldStyle = new TextStyle(
  fontFamily: "Comfortaa",
  color: SwatchColor.kLightPeachColor,
  fontWeight: FontWeight.normal,
);
