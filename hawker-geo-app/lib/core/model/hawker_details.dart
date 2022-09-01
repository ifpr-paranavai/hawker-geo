// ignore_for_file: constant_identifier_names
/*
 * Created by Kairo Amorim on 31/08/2022 23:00
 * Copyright© 2022. All rights reserved.
 * Last modified 31/08/2022 23:00
 */

import 'package:hawker_geo/core/model/hawker_category_enum.dart';

class HawkerDetails {
  static const String CATEGORY = "category";
  static const String RATING_VALUE = "ratingValue";
  static const String DESCRIPTION = "description";
  static const String PRODUCT_PHOTOS = "productPhotos";

  HawkerCategoryEnum? category;
  double? ratingValue;
  String? description;
  List<String>? productPhotos;

  HawkerDetails({this.category, this.ratingValue, this.description, this.productPhotos});

  static HawkerDetails fromJson(Map<String, dynamic> json) => HawkerDetails(
        category: json[CATEGORY] != null
            ? HawkerCategoryEnum.values.where((a) => a.value == json[CATEGORY]).first
            : null,
        ratingValue: json[RATING_VALUE] as double?,
        description: json[DESCRIPTION] as String?,
        productPhotos: json[PRODUCT_PHOTOS] as List<String>?,
      );

  Map<String, dynamic> toJson() {
    return {
      CATEGORY: category != null ? category!.value.toString() : category,
      RATING_VALUE: ratingValue,
      DESCRIPTION: description,
      PRODUCT_PHOTOS: productPhotos,
    };
  }
}
