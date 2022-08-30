import 'package:flutter/material.dart';

enum GenderEnum {
  M,
  F,
  O,
}

extension GenderEnumExtension on GenderEnum {
  static const Map<GenderEnum, String> values = {
    GenderEnum.M: 'M',
    GenderEnum.F: 'F',
    GenderEnum.O: 'O',
  };

  static const Map<GenderEnum, String> descriptions = {
    GenderEnum.M: 'Male',
    GenderEnum.F: 'Female',
    GenderEnum.O: 'Other',
  };

  String? get value => values[this];

  String? get description => descriptions[this];

  static GenderEnum? fromRaw(String raw) => values.entries.firstWhere((e) => e.value == raw).key;

  static genderIcon(GenderEnum gender) {
    switch (gender) {
      case GenderEnum.M:
        return Icons.male;
      case GenderEnum.F:
        return Icons.female;
      case GenderEnum.O:
        return Icons.trip_origin;
    }
  }

  static String getEnumName(GenderEnum genderEnum) {
    if (genderEnum.value == GenderEnum.M.value) {
      return "Masculino";
    } else if (genderEnum.value == GenderEnum.F.value) {
      return "Feminino";
    } else {
      return "Outro";
    }
  }
}
