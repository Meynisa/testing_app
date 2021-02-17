import 'dart:ui';
import 'constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

dynamicText(String text,
    {Color color,
    double fontSize = 16,
    FontWeight fontWeight,
    FontStyle fontStyle = FontStyle.normal,
    TextOverflow overflow,
    TextAlign textAlign,
    bool price = false,
    bool number = false,
    String fontFamily = "Comfortaa",
    int maxLines,
    TextDecoration textDecoration}) {
  FlutterMoneyFormatter fmf;
  if (number || price) {
    fmf = new FlutterMoneyFormatter(
      amount: (text != null && text != "") ? double.parse(text) : 0.0,
      settings: MoneyFormatterSettings(
        symbol: !number ? 'Rp' : '',
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
        compactFormatType: CompactFormatType.short,
      ),
    );
  }
  return Text(
    text != null ? price || number ? fmf.output.symbolOnLeft : text : "",
    style: TextStyle(
      fontFamily: fontFamily,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: textDecoration,
      fontFeatures: [FontFeature.tabularFigures()],
    ),
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
  );
}

titleText(String text,
    {TextOverflow overflow, TextAlign textAlign, int maxLines}) {
  return Text(
    text,
    style: themeData.textTheme.title,
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
  );
}

headlineText(String text,
    {TextOverflow overflow, TextAlign textAlign, int maxLines}) {
  return Text(
    text,
    style: themeData.textTheme.headline,
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
  );
}

bodyText(String text,
    {TextOverflow overflow, TextAlign textAlign, int maxLines}) {
  return Text(
    text,
    style: themeData.textTheme.body1,
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
  );
}

Widget textFieldPayment(
    String lblTxt,
    TextInputType textInputType, {
      String initialValue = '',
      String prefixText = '',
      List<TextInputFormatter> inputFormatter,
      bool readOnly = false,
      TextInputAction textInputAction,
      TextAlign textAlign = TextAlign.start,
      int maxLines = 1,
    }) {
  return TextFormField(
    initialValue: initialValue,
    keyboardType: textInputType,
    textAlign: textAlign,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: SwatchColor.kDarkGreyColor,
          ),
          borderRadius: BorderRadius.circular(25)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: SwatchColor.kPeachColor,
          ),
          borderRadius: BorderRadius.circular(25)),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(25),
      ),
      labelText: lblTxt,
    ),
  );
}