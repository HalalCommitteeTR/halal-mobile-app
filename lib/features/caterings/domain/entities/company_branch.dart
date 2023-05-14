import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:halal_mobile_app/features/caterings/domain/entities/food_point_type.dart';

import 'cuisine_type.dart';

part 'company_branch.freezed.dart';

part 'company_branch.g.dart';

@freezed
class CompanyBranch with _$CompanyBranch {
  const factory CompanyBranch({
    @JsonKey(name: 'branch_id') required int id,
    @JsonKey(name: 'branch_name') required String name,
    @JsonKey(name: 'is_prayer_room_exist') bool? isPrayerRoomExist,
    @JsonKey(name: 'food_point_type') required FoodPointType foodPointType,
    @JsonKey(name: 'cuisine_type') required CuisineType cuisineType,
    String? street,
    String? building,
    @JsonKey(name: 'federation_name') String? federationName,
    @JsonKey(name: 'district_name') String? districtName,
    @JsonKey(name: 'district_settlement_name') String? districtSettlementName,
    @JsonKey(name: 'halal_certificate_expiration_time')
        DateTime? halalCertificateExpirationTime,
    @JsonKey(name: 'img_src') String? imageSource,
  }) = _CompanyBranch;

  factory CompanyBranch.fromJson(Map<String, Object?> json) =>
      _$CompanyBranchFromJson(json);
}
