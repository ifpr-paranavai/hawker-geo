/*
 * Created by Kairo Amorim on 30/08/2022 15:20
 * Copyright (c) 2022. All rights reserved.
 * Last modified 30/08/2022 15:20
 */

import 'package:flutter/material.dart';
import 'package:hawker_geo/core/utils/constants.dart';
import 'package:hawker_geo/ui/shared/loading_widget.dart';

class FunctionWidgets {
  showLoading(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => WILL_POP_SCOPE,
        child: const Center(
          child: LoadingWidget(),
        ),
      ),
    );
  }
}
