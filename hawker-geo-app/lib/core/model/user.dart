// ignore_for_file: constant_identifier_names
import 'package:hawker_geo/core/model/hawker_details.dart';
import 'package:hawker_geo/core/model/role_enum.dart';
import 'package:hawker_geo/core/model/status_enum.dart';
import 'package:latlong2/latlong.dart';

import 'gender_enum.dart';

class User {
  static const String ID = 'id';
  static const String ACTIVE = 'active';
  static const String NAME = 'name';
  static const String USERNAME = 'username';
  static const String GENDER = 'gender';
  static const String PASSWORD = "password";
  static const String URL_PHOTO = "urlPhoto";
  static const String BAS64_PHOTO = "base64Photo";
  static const String EMAIL = "email";
  static const String PHONE_NUMBER = "phoneNumber";
  static const String STATUS = "status";
  static const String ROLE = "role";
  static const String POSITION = "position";
  static const String HAWKER_DETAILS = "hawkerDetails";

  String? id;
  bool? active;
  String? name;
  String? username;
  GenderEnum? gender;
  String? password;
  String? urlPhoto;
  String? base64Photo;
  String? email;
  String? phoneNumber;
  StatusEnum? status;
  RoleEnum? role;
  LatLng? position;
  HawkerDetails? hawkerDetails;

  User({
    this.id,
    this.active,
    this.name,
    this.username,
    this.gender,
    this.password,
    this.urlPhoto,
    this.base64Photo,
    this.email,
    this.phoneNumber,
    this.status,
    this.role,
    this.position,
    this.hawkerDetails,
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
      base64Photo: json[BAS64_PHOTO] as String?,
      email: json[EMAIL] as String?,
      phoneNumber: json[PHONE_NUMBER] as String?,
      status: json[STATUS] != null
          ? StatusEnum.values.where((a) => a.value == json[STATUS]).first
          : null,
      role: json[ROLE] != null ? RoleEnum.values.where((a) => a.value == json[ROLE]).first : null,
      position: json[POSITION] != null ? LatLng.fromJson(json[POSITION]) : null,
      hawkerDetails:
          json[HAWKER_DETAILS] != null ? HawkerDetails.fromJson(json[HAWKER_DETAILS]) : null);

  Map<String, dynamic> toJson() {
    return {
      ID: id,
      ACTIVE: active,
      NAME: name,
      USERNAME: username,
      GENDER: gender != null ? gender!.value.toString() : gender,
      PASSWORD: password,
      URL_PHOTO: urlPhoto,
      BAS64_PHOTO: base64Photo,
      EMAIL: email,
      PHONE_NUMBER: phoneNumber,
      STATUS: status != null ? status!.value.toString() : status,
      ROLE: role != null ? role!.value.toString() : role,
      POSITION: position != null ? position!.toJson() : position,
      HAWKER_DETAILS: hawkerDetails != null ? hawkerDetails!.toJson() : hawkerDetails,
    };
  }
}
