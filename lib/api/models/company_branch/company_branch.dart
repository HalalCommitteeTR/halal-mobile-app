import 'package:freezed_annotation/freezed_annotation.dart';
part 'company_branch.freezed.dart';

part 'company_branch.g.dart';

enum FoodPointType {
  cafe,
  canteen,
  restaurant,
  @JsonKey(name: 'street_food')
  streetFood,
  bakery,
  @JsonKey(name: 'sushi_bar')
  sushiBar,
  @JsonKey(name: 'burger_joint')
  burgerJoint,
  @JsonKey(name: 'quick_service_restaurant')
  quickServiceRestaurant,
  @JsonKey(name: 'gas_station')
  gasStation,
  @JsonKey(name: 'halal_store')
  halalStore,
}

enum CuisineType {
  asian,
  tatar,
  european,
  turkish,
  eastern,
  @JsonKey(name: 'homemade_meals')
  homemadeMeals,
  @JsonKey(name: 'baked_products')
  bakedProducts,
  @JsonKey(name: 'fast_food')
  fastFood,
  mixed,
}

@freezed
class CompanyBranch with _$CompanyBranch {
  const factory CompanyBranch(
      {required int id,
      required String name,
      @JsonKey(name: 'is_prayer_room_exist') bool? isPrayerRoomExist,
      @JsonKey(name: 'food_point_type') required FoodPointType foodPointType,
        @JsonKey(name: 'cuisine_type') required CuisineType cuisineType,
      String? street,
      String? building,
        // company
        // district settlement
        // contacts
        // certificate
      @JsonKey(name: 'img_src') String? imageSource}) = _CompanyBranch;

  factory CompanyBranch.fromJson(Map<String, Object?> json) =>
      _$CompanyBranchFromJson(json);
}
