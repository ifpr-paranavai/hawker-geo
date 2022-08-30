/*
 * Created by Kairo Amorim on 30/08/2022 17:04
 * Copyright (c) 2022. All rights reserved.
 * Last modified 30/08/2022 17:04
 */

import 'package:flutter/material.dart';
import 'package:hawker_geo/core/model/user.dart';

import 'second_step_widget.dart';

class RegisterSecondStepPage extends StatefulWidget {

  final User user;

  const RegisterSecondStepPage({
    Key? key, required this.user,
  }) : super(key: key);

  @override
  State<RegisterSecondStepPage> createState() => RegisterSecondStepWidget();
}
