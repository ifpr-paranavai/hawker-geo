import 'package:flutter/material.dart';
import 'package:hawker_geo/core/model/user.dart';
import 'package:hawker_geo/core/services/register_service.dart';
import 'package:hawker_geo/ui/home/screen/home_page.dart';
import 'package:hawker_geo/ui/styles/custom_router.dart';

class RegisterController {
  final user = User();
  final _service = RegisterService();

  registerUser(BuildContext context) async {
    try {
      await _service.registerUser(user).then((_) => {
            CustomRouter.pushAndEmpityPile(context, const HomePage())
          }); // TODO - Ir para outra tela e continuar o cadastro;
    } catch (e) {
      // TODO - Tratar e exibir erro
      Navigator.of(context).pop();
    }
  }
}
