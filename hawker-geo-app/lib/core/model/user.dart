// ignore_for_file: constant_identifier_names
import 'package:hawker_geo/core/model/hawker_category_enum.dart';
import 'package:latlong2/latlong.dart';
import 'package:hawker_geo/core/model/role_enum.dart';
import 'package:hawker_geo/core/model/status_enum.dart';

import 'gender_enum.dart';

class User {
  static const String ID = 'id';
  static const String ACTIVE = 'active';
  static const String NAME = 'name';
  static const String USERNAME = 'username';
  static const String GENDER = 'gender';
  static const String PASSWORD = "password";
  static const String URL_PHOTO = "urlPhoto";
  static const String EMAIL = "email";
  static const String PHONE_NUMBER = "phoneNumber";
  static const String STATUS = "status";
  static const String HAWKER_CATEGORY = "hawkerCategory";
  static const String ROLE = "role";
  static const String POSITION = "position";

  String? id;
  bool? active;
  String? name;
  String? username;
  GenderEnum? gender;
  String? password;
  String? urlPhoto;
  String? email;
  String? phoneNumber;
  StatusEnum? status;
  RoleEnum? role;
  HawkerCategoryEnum? hawkerCategory;
  LatLng? position;

  User({
    this.id,
    this.active,
    this.name,
    this.username,
    this.gender,
    this.password,
    this.urlPhoto,
    this.email,
    this.phoneNumber,
    this.status,
    this.role,
    this.hawkerCategory,
    this.position,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        id: json[ID] as String?,
        active: json[ACTIVE] as bool?,
        name: json[NAME] as String?,
        username: json[USERNAME] as String?,
        gender: json[GENDER] != null
            ? GenderEnum.values.where((a) => a.value == json[GENDER]).first
            : null,
        password: json[PASSWORD] as String?,
        urlPhoto: json[URL_PHOTO] as String?,
        email: json[EMAIL] as String?,
        phoneNumber: json[PHONE_NUMBER] as String?,
        status: json[STATUS] != null
            ? StatusEnum.values.where((a) => a.value == json[STATUS]).first
            : null,
        role: json[ROLE] != null
            ? RoleEnum.values.where((a) => a.value == json[ROLE]).first
            : null,
        hawkerCategory: json[HAWKER_CATEGORY] != null
            ? HawkerCategoryEnum.values
                .where((a) => a.value == json[HAWKER_CATEGORY])
                .first
            : null,
        position:
            json[POSITION] != null ? LatLng.fromJson(json[POSITION]) : null,
      );

  Map<String, dynamic> toJson() {
    return {
      ID: id,
      ACTIVE: active,
      NAME: name,
      USERNAME: username,
      GENDER: gender != null ? gender!.value.toString() : gender,
      PASSWORD: password,
      URL_PHOTO: urlPhoto,
      EMAIL: email,
      PHONE_NUMBER: phoneNumber,
      STATUS: status != null ? status!.value.toString() : status,
      ROLE: role != null ? role!.value.toString() : role,
      HAWKER_CATEGORY: hawkerCategory != null
          ? hawkerCategory!.value.toString()
          : hawkerCategory,
      POSITION: position != null ? position!.toJson() : position,
    };
  }
}
