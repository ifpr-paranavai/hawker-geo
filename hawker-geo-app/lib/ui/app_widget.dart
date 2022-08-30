import 'package:flutter/material.dart';
import 'package:hawker_geo/ui/splash_screen/splash_screen.dart';
import 'package:hawker_geo/ui/styles/text.dart';

import 'styles/color.dart';

class AppWidgetPage extends StatefulWidget {
  const AppWidgetPage({Key? key}) : super(key: key);

  @override
  AppWidget createState() => AppWidget();
}

class AppWidget extends State<AppWidgetPage> {
  var theme = ThemeData(
    fontFamily: 'Open Sans',
    textTheme: customTextTheme,
    primarySwatch: Colors.lightBlue,
    brightness: Brightness.light,
  );

  @override
  Widget build(BuildContext context) {
    theme = theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        onSecondary: kFourthColor,
        onPrimary: const Color(0xffffffff),
        primary: Colors.lightGreen,
        secondary: kSecondColor,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const SplashScreenPage(),
    );
  }
}
