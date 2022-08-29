// ignore_for_file: constant_identifier_names
import 'package:hawker_geo/core/utils/app_images.dart';

enum HawkerCategoryEnum {
  FRUIT,
  BREAD,
  PASTA,
  CANDY,
  POPSICLE,
}

extension HawkerCategoryEnumExtension on HawkerCategoryEnum {

  static const Map<HawkerCategoryEnum, String> values = {
    HawkerCategoryEnum.FRUIT: 'FRUIT',
    HawkerCategoryEnum.BREAD: 'BREAD',
    HawkerCategoryEnum.PASTA: 'PASTA',
    HawkerCategoryEnum.CANDY: 'CANDY',
    HawkerCategoryEnum.POPSICLE: 'POPSICLE',
  };

  String? get value => values[this];

  static HawkerCategoryEnum? fromRaw(String raw) =>
      values.entries.firstWhere((e) => e.value == raw).key;

  static categoryIcon(HawkerCategoryEnum category) {
    switch (category) {
      case HawkerCategoryEnum.BREAD:
        return AppImages.categoryBread;
      case HawkerCategoryEnum.FRUIT:
        return AppImages.categoryFruits;
      case HawkerCategoryEnum.PASTA:
        return AppImages.categoryPasta;
      case HawkerCategoryEnum.CANDY:
        return AppImages.categoryCandy;
      case HawkerCategoryEnum.POPSICLE:
        return AppImages.categoryPopsicle;
    }
  }
}