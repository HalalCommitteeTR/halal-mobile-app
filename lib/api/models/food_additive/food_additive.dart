import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'food_additive.freezed.dart';

part 'food_additive.g.dart';

@HiveType(typeId: 0)
enum Permissiveness {
  @HiveField(0)
  halal,
  @HiveField(1)
  haram,
  @HiveField(2)
  doubtful, }

@HiveType(typeId: 1)
@freezed
class FoodAdditive with _$FoodAdditive {
  const factory FoodAdditive({
    @HiveField(0)
    required int id,
    @HiveField(1)
    required String name,
    @HiveField(2)
    @JsonKey(name: 'e_number')
    String? eNumber,
    @HiveField(3)
    required Permissiveness permissiveness,
    @HiveField(4)
    String? description,
    @HiveField(5)
    String? source,
    @HiveField(6)
    @JsonKey(name: 'img_src')
    String? imageSource
  }) = _FoodAdditive;

  factory FoodAdditive.fromJson(Map<String, Object?> json) =>
      _$FoodAdditiveFromJson(json);
}
