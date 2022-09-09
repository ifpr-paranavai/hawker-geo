// ignore_for_file: constant_identifier_names
/*
 * Created by Kairo Amorim on 31/08/2022 23:00
 * Copyright© 2022. All rights reserved.
 * Last modified 31/08/2022 23:00
 */

import 'package:hawker_geo/core/model/hawker_category_enum.dart';

class HawkerDetails {
  static const String CATEGORIES = "categories";
  static const String AVERAGE_RATING = "averageRating";
  static const String CPF = "cpf";
  static const String COMPANY_NAME = "companyName";
  static const String DESCRIPTION = "description";
  static const String PRODUCT_PHOTOS = "productPhotos";

  List<HawkerCategoryEnum>? categories;
  double? averageRating;
  String? cpf;
  String? companyName;
  String? description;
  List<String>? additionalPhotos;

  HawkerDetails(
      {this.categories,
      this.averageRating,
      this.description,
      this.additionalPhotos,
      this.cpf,
      this.companyName});

  static HawkerDetails fromJson(Map<String, dynamic> json) => HawkerDetails(
        categories: json[CATEGORIES] != null
            ? (json[CATEGORIES]
                .map((e) => HawkerCategoryEnum.values.where((a) => a.value == e).first)).toList()
            : null,
        averageRating: json[AVERAGE_RATING] as double?,
        cpf: json[CPF] as String?,
        companyName: json[COMPANY_NAME] as String?,
        description: json[DESCRIPTION] as String?,
        additionalPhotos: json[PRODUCT_PHOTOS] as List<String>?,
      );

  Map<String, dynamic> toJson() {
    return {
      CATEGORIES:
          categories != null ? categories!.map((i) => i.value.toString()).toList() : categories,
      AVERAGE_RATING: averageRating,
      CPF: cpf,
      DESCRIPTION: companyName,
      COMPANY_NAME: description,
      PRODUCT_PHOTOS: additionalPhotos,
    };
  }
}
