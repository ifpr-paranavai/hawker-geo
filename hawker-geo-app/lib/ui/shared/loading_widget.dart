/*
 * Created by Kairo Amorim on 30/08/2022 12:54
 * Copyright (c) 2022. All rights reserved.
 * Last modified 30/08/2022 12:54
 */

import 'package:flutter/widgets.dart';
import 'package:hawker_geo/core/utils/app_images.dart';

import 'spin_kit/double_bounce.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      itemBuilder: (BuildContext context, int index) {
        return index.isEven ? Image.asset(AppImages.foodTruck) : Image.asset(AppImages.hawkerKart);
      },
    );
  }
}
