

import 'package:freezed_annotation/freezed_annotation.dart';
part 'food_additive.freezed.dart';
part 'food_additive.g.dart';

enum Permissiveness {halal, haram, doubtful}

@freezed
class FoodAdditive with _$FoodAdditive {
  const factory FoodAdditive({
    required String name,
    required String? eNumber,
    required Permissiveness permissiveness,
    required String? description,
    required String? source,
}) = _FoodAdditive;

  factory FoodAdditive.fromJson(Map<String, Object?> json)
=> _$FoodAdditiveFromJson(json);
}