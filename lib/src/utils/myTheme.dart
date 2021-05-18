import 'package:flutter/material.dart';
import 'package:opalus/src/utils/constants.dart';

class MyTheme {
  static String getCurrentPrimaryColor() {
    return 'green';
  }

  static Map<String, ThemeColor> ThemeColors = {
    'green': ThemeColor(
      primaryColor: Colors.green,
      primaryColorDark: Colors.green[800]!,
      primaryColorLight: Colors.green[200]!,
      secondaryColor: Colors.white,
      secondaryColorDark: Colors.grey[200]!,
      secondaryColorLight: Colors.white,
      accentColor: Colors.blue,
    )
  };

  static Color getCurrencyColor(String type) {
    switch (type) {
      case TRANSACTION_TYPE.INCOME:
        return Colors.green;
      case TRANSACTION_TYPE.OUTCOME:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  static TextStyle regularCurrency(BuildContext context, [String type = '']) {
    return Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: MyTheme.getCurrencyColor(type));
  }

  static TextStyle bigCurrency(BuildContext context, [String type = '']) {
    return Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: MyTheme.getCurrencyColor(type), fontSize: 16);
  }

  static TextStyle smallCurrency(BuildContext context, [String type = '']) {
    return Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: MyTheme.getCurrencyColor(type), fontSize: 10);
  }

  static Color primaryColor() {
    return ThemeColors[getCurrentPrimaryColor()]!.primaryColor;
  }

  static Color primaryColorDark() {
    return ThemeColors[getCurrentPrimaryColor()]!.primaryColorDark;
  }

  static Color primaryColorLight() {
    return ThemeColors[getCurrentPrimaryColor()]!.primaryColorLight;
  }

  static Color secondaryColor() {
    return ThemeColors[getCurrentPrimaryColor()]!.secondaryColor;
  }

  static Color secondaryColorDark() {
    return ThemeColors[getCurrentPrimaryColor()]!.secondaryColorDark;
  }

  static Color secondaryColorLight() {
    return ThemeColors[getCurrentPrimaryColor()]!.secondaryColorLight;
  }

  static Color accentColor() {
    return ThemeColors[getCurrentPrimaryColor()]!.accentColor;
  }
}

class ThemeColor {
  final Color primaryColor;
  final Color primaryColorDark;
  final Color primaryColorLight;
  final Color secondaryColor;
  final Color secondaryColorDark;
  final Color secondaryColorLight;
  final Color accentColor;

  ThemeColor({
    required this.primaryColor,
    required this.primaryColorDark,
    required this.primaryColorLight,
    required this.secondaryColor,
    required this.secondaryColorDark,
    required this.secondaryColorLight,
    required this.accentColor,
  });
}
