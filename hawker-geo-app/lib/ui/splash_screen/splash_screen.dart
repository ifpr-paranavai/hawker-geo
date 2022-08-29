import 'package:flutter/material.dart';
import 'package:hawker_geo/core/utils/app_images.dart';
import 'package:hawker_geo/ui/home/screen/home_page.dart';
import 'package:splashscreen/splashscreen.dart';

import '../theme/colors.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  SplashScreenWidget createState() => SplashScreenWidget();
}

class SplashScreenWidget extends State<SplashScreenPage> {
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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryColor,
                fourthColor,
                // thirdColor,
              ],
              stops: [0.5, 0.8],
            ),
          ),
          child: Transform.scale(
              scale: 0.6,
              child: Image.asset(
                AppImages.appIcon,
              )),
        ),
      ],
    );
  }
}
