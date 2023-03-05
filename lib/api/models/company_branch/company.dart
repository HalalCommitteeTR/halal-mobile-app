import 'package:freezed_annotation/freezed_annotation.dart';
part 'company.freezed.dart';

part 'company.g.dart';

enum LegalType {
  @JsonKey(name: 'not_set')
  notSet,
  @JsonKey(name: 'individual_entrepreneur')
  individualEntrepreneur,
  @JsonKey(name: 'limited_liability_company')
  limitedLiabilityCompany,
  @JsonKey(name: 'joint_stock_company')
  jointStockCompany,
  @JsonKey(name: 'group_of_companies')
  groupOfCompanies,
  @JsonKey(name: 'closed_joint_stock_company')
  closedJointStockCompany,
}

@freezed
class Company with _$Company {
  const factory Company({
    required int id,
    required String name,
    @JsonKey(name: 'legal_type') required LegalType legalType,
  }) = _Company;

  factory Company.fromJson(Map<String, Object?> json) =>
      _$CompanyFromJson(json);
}
