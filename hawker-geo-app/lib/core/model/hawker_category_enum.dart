// ignore_for_file: constant_identifier_names
enum HawkerCategoryEnum {
  FRUIT,
  BREAD,
  PASTA,
  SWEET,
  POPSICLE,
}

extension HawkerCategoryEnumExtension on HawkerCategoryEnum {

  static const Map<HawkerCategoryEnum, String> values = {
    HawkerCategoryEnum.FRUIT: 'FRUIT',
    HawkerCategoryEnum.BREAD: 'BREAD',
    HawkerCategoryEnum.PASTA: 'PASTA',
    HawkerCategoryEnum.SWEET: 'SWEET',
    HawkerCategoryEnum.POPSICLE: 'POPSICLE',
  };

  String? get value => values[this];

  static HawkerCategoryEnum? fromRaw(String raw) =>
      values.entries.firstWhere((e) => e.value == raw).key;
}