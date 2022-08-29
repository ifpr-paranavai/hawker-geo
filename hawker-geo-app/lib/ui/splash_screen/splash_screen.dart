import 'package:flutter/material.dart';
import 'package:hawker_geo/core/utils/app_images.dart';
import 'package:hawker_geo/ui/home/screen/home-page.dart';
import 'package:splashscreen/splashscreen.dart';

import '../theme/colors.dart';

class SplashScreenApp extends StatefulWidget {
  const SplashScreenApp({Key? key}) : super(key: key);

  @override
  _SplashScreenApp createState() => _SplashScreenApp();
}

class _SplashScreenApp extends State<SplashScreenApp> {
  @override
  Widget build(BuildContext context) {
    return _introScreen(context);
  }

  Widget _introScreen(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen.timer(
          seconds: 3,
          backgroundColor: Colors.white,
          navigateAfterSeconds: const HomeScreen(),
          loaderColor: Colors.transparent,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryColor,
                secondColor,
              ],
              stops: [
                0, 0.6
              ],
            ),
            image: DecorationImage(
              image: AssetImage(
                AppImages.appIcon,
              ),
              // fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
