import 'package:flutter/material.dart';
import 'package:hawker_geo/core/model/user.dart';
import 'package:hawker_geo/core/services/register_service.dart';
import 'package:hawker_geo/ui/register/screen/second_step/second_step_page.dart';
import 'package:hawker_geo/ui/styles/custom_router.dart';

class RegisterController {
  var user = User();
  final _service = RegisterService();

  registerUser(BuildContext context) async {
    try {
      Navigator.of(context).pop(); // fechar loading
      CustomRouter.pushReplacement(context, RegisterSecondStepPage(user: user));
      // await _service.registerUser(user).then((_) {
      //   Navigator.of(context).pop(); // fechar loading
      //   CustomRouter.pushReplacement(context, RegisterSecondStepPage(user: user));
      // });
    } catch (e) {
      // TODO - Tratar e exibir erro
      Navigator.of(context).pop();
    }
  }
}
