import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';

part 'item.freezed.dart';

part 'item.g.dart';

@freezed
class Item with _$Item {
  const factory Item.foodAdditive(
      {required int id,
      required String name,
      @JsonKey(name: 'e_number')
      required String eNumber,
      required Permissiveness permissiveness,
      String? description,
      String? source,
      @JsonKey(name: 'img_src')
      String? imageSource,
      }) = FoodAdditive;

  const factory Item.ingredient(
      {required int id,
        required String name,
        required Permissiveness permissiveness,
        String? description,
        @JsonKey(name: 'img_src')
        String? imageSource,
        }) = Ingredient;



  factory Item.fromJson(Map<String, Object?> json) =>
      _$ItemFromJson(json);
}
