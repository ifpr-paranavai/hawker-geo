// ignore_for_file: constant_identifier_names
enum RoleEnum {
  ROLE_ADMIN,
  ROLE_CUSTOMER,
  ROLE_HAWKER,
}

extension RoleEnumEnumExtension on RoleEnum {

  static const Map<RoleEnum, String> values = {
    RoleEnum.ROLE_ADMIN: 'ROLE_ADMIN',
    RoleEnum.ROLE_CUSTOMER: 'ROLE_CUSTOMER',
    RoleEnum.ROLE_HAWKER: 'ROLE_HAWKER',
  };

  String? get value => values[this];

  static RoleEnum? fromRaw(String raw) =>
      values.entries.firstWhere((e) => e.value == raw).key;
}