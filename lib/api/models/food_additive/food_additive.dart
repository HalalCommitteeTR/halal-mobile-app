import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'food_additive.freezed.dart';

part 'food_additive.g.dart';

enum Permissiveness {
  halal,
  haram,
  doubtful,
}

@HiveType(typeId: 1)
@freezed
class FoodAdditive with _$FoodAdditive {
  const factory FoodAdditive(
      {required int id,
      required String name,
      @JsonKey(name: 'e_number')
      String? eNumber,
      required Permissiveness permissiveness,
      String? description,
      String? source,
      @JsonKey(name: 'img_src')
      String? imageSource}) = _FoodAdditive;

  factory FoodAdditive.fromJson(Map<String, Object?> json) =>
      _$FoodAdditiveFromJson(json);
}
