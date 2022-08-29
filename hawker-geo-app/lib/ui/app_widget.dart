import 'package:flutter/material.dart';
import 'package:hawker_geo/ui/splash_screen/splash_screen.dart';
import 'package:hawker_geo/ui/theme/texts.dart';

import 'theme/colors.dart';

class AppWidgetPage extends StatefulWidget {
  const AppWidgetPage({Key? key}) : super(key: key);

  @override
  AppWidget createState() => AppWidget();
}

class AppWidget extends State<AppWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Open Sans',
          textTheme: customTextTheme,
          primaryColor: primaryColor,
          dividerColor: dividerColor,
          accentColor: accentColor),
      home: const SplashScreenPage(),
    );
  }
}
