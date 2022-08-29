import 'package:flutter/material.dart';

class CustomRouter {
  static Future pushPage(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return page;
        },
      ),
    );
  }
  static Future pushReplacement(BuildContext context, Widget page) {
    return Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => page
        ));
  }

  static Future showBottomSheet(BuildContext context, Widget page,
      {bool isScrollControlled = true}) {
    return showModalBottomSheet(
      isScrollControlled: isScrollControlled,
      context: context,
      builder: (context) => page,
    );
  }

  // static Future pushPageTransition(BuildContext context, Widget page, PageTransitionType type, Duration duration, {route = true}) {
  //   return Navigator.push(
  //     context,
  //     PageTransition(
  //       type: type,
  //       duration: duration,
  //       child: page,
  //     ),
  //   );
  // }

  static void popPage(BuildContext context) => Navigator.pop(context);
}
