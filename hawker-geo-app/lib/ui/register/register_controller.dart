import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:hawker_geo/core/model/user.dart';
import 'package:hawker_geo/core/services/register_service.dart';
import 'package:hawker_geo/core/utils/util.dart';
import 'package:hawker_geo/ui/home/screen/home_page.dart';
import 'package:hawker_geo/ui/register/screen/second_step/second_step_page.dart';
import 'package:hawker_geo/ui/shared/shared_pop_ups.dart';
import 'package:hawker_geo/ui/styles/custom_router.dart';
import 'package:image_picker/image_picker.dart';

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

  getProfilePick(ImageSource source, Function(XFile image) func) {
    Util().getImageFromCameraOrGallery(source, func);
  }

  registerObjUser(BuildContext context) async {
    try {
      await _service.registerObjUser(user).then((_) {
        Navigator.of(context).pop(); // fechar loading
        CustomRouter.pushAndEmpityPile(context, const HomePage());
      });
    } on fb.FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      SharedPopUps().errorPopUp(context,
          description: "Ocorreu um erro ao finalizar cadastro! Código: ${e.code}", buttonText: "OK");
    } catch (e) {
      Navigator.of(context).pop();
      SharedPopUps().errorPopUp(context,
          description: "Ocorreu um erro ao finalizar cadastro! Erro: $e", buttonText: "OK");
    }
  }
}
