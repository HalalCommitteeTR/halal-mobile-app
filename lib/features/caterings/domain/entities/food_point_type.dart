import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:halal_mobile_app/app_locale.dart';

enum FoodPointType {
  cafe,
  canteen,
  restaurant,
  @JsonValue('street_food')
  streetFood,
  bakery,
  @JsonValue('sushi_bar')
  sushiBar,
  @JsonValue('burger_joint')
  burgerJoint,
  @JsonValue('quick_service_restaurant')
  quickServiceRestaurant,
  @JsonValue('gas_station')
  gasStation,
  @JsonValue('halal_store')
  halalStore;

  String getString(BuildContext context) {
    switch (this) {
      case FoodPointType.cafe:
        return AppLocale.of(context).cafe;
      case FoodPointType.canteen:
        return AppLocale.of(context).canteen;
      case FoodPointType.restaurant:
        return AppLocale.of(context).restaurant;
      case FoodPointType.streetFood:
        return AppLocale.of(context).streetFood;
      case FoodPointType.bakery:
        return AppLocale.of(context).bakery;
      case FoodPointType.sushiBar:
        return AppLocale.of(context).sushiBar;
      case FoodPointType.burgerJoint:
        return AppLocale.of(context).burgerJoint;
      case FoodPointType.quickServiceRestaurant:
        return AppLocale.of(context).quickServiceRestaurant;
      case FoodPointType.gasStation:
        return AppLocale.of(context).gasStation;
      case FoodPointType.halalStore:
        return AppLocale.of(context).halalStore;
    }
  }

  static const Set<FoodPointType> setOfAll = const {
    cafe,
    canteen,
    restaurant,
    streetFood,
    bakery,
    sushiBar,
    burgerJoint,
    quickServiceRestaurant,
    gasStation,
    halalStore,
  };
}
