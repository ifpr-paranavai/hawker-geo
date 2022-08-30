import 'package:flutter/material.dart';

import 'color.dart';

const customTextTheme = TextTheme(
  subtitle1: TextStyle(
    fontSize: 17,
    color: kSecondaryTextColor,
    fontWeight: FontWeight.w300,
    letterSpacing: -1,
  ),
  subtitle2: TextStyle(
    color: kSecondaryTextColor,
    fontWeight: FontWeight.normal,
  ),
  headline3: TextStyle(
    fontSize: 35,
    color: kTextColor,
    fontWeight: FontWeight.w500,
    letterSpacing: -1.5,
  ),
  headline4: TextStyle(
    fontSize: 30,
    color: kTextColor,
    fontWeight: FontWeight.w500,
    letterSpacing: -1.5,
  ),
  button: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
  caption: TextStyle(height: 1.5),
  headline5: TextStyle(fontWeight: FontWeight.bold),
  headline6: TextStyle(fontWeight: FontWeight.w400),
);

const openStreetMapCopyright =
    TextStyle(color: Colors.grey, fontSize: 12, decoration: TextDecoration.none);

const boldTitle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 22,
);

const boldButtonText = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
