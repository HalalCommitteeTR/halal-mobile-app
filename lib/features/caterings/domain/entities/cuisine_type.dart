import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:halal_mobile_app/app_locale.dart';

enum CuisineType {
  asian,
  tatar,
  european,
  turkish,
  eastern,
  @JsonValue('homemade_meals')
  homemadeMeals,
  @JsonValue('baked_products')
  bakedProducts,
  @JsonValue('fast_food')
  fastFood,
  mixed;

  String getString(BuildContext context) {
    switch (this) {
      case CuisineType.asian:
        return AppLocale.of(context).asian;
      case CuisineType.tatar:
        return AppLocale.of(context).tatar;
      case CuisineType.european:
        return AppLocale.of(context).european;
      case CuisineType.turkish:
        return AppLocale.of(context).turkish;
      case CuisineType.eastern:
        return AppLocale.of(context).eastern;
      case CuisineType.homemadeMeals:
        return AppLocale.of(context).homemadeMeals;
      case CuisineType.bakedProducts:
        return AppLocale.of(context).bakedProducts;
      case CuisineType.fastFood:
        return AppLocale.of(context).fastFood;
      case CuisineType.mixed:
        return AppLocale.of(context).mixed;
    }
  }

  static const Set<CuisineType> setOfAll = const {
    asian,
    tatar,
    european,
    turkish,
    eastern,
    homemadeMeals,
    bakedProducts,
    fastFood,
    mixed,
  };
}
