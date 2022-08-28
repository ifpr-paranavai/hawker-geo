// ignore_for_file: constant_identifier_names
import 'package:latlong2/latlong.dart';
import 'package:hawker_geo/core/model/role_enum.dart';
import 'package:hawker_geo/core/model/status_enum.dart';

import 'gender_enum.dart';

class LoginDTO {
  static const String EMAIL = "email";
  static const String PASSWORD = "password";

  String? email;
  String? password;

  LoginDTO({
    this.email,
    this.password,
  });

  static LoginDTO fromJson(Map<String, dynamic> json) =>
      LoginDTO(email: json[EMAIL] as String?, password: json[PASSWORD] as String?);

  Map<String, dynamic> toJson() {
    return {EMAIL: email, PASSWORD: password};
  }
}
