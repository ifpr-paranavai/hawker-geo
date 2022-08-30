/*
 * Created by Kairo Amorim on 30/08/2022 17:32
 * Copyright (c) 2022. All rights reserved.
 * Last modified 30/08/2022 17:32
 */

class Validators {
  phoneValidator(String? value, {String? emptyMessage, String? notMatchedMessage}) {
    RegExp regExp = RegExp(r'(^\([0-9]{2}\) [0-9]?[0-9]{4}-[0-9]{4}$)');
    if (value == null || value.isEmpty) {
      return emptyMessage ?? 'Este campo não pode estar vazio';
    } else if (!regExp.hasMatch(value)) {
      return notMatchedMessage ?? 'Por favor, insira um número válido';
    }
    return null;
  }
}
