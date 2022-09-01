/*
 * Created by Kairo Amorim on 01/09/2022 01:01
 * Copyright© 2022. All rights reserved.
 * Last modified 01/09/2022 01:01
 */

import 'package:flutter/material.dart';
import 'package:hawker_geo/ui/styles/color.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                kFourthColor,
                kThirdColor,
              ],
              stops: [0, 0.55],
            )),
            child: Column(children: const []),
          ),
        ],
      ),
    );
  }
}
