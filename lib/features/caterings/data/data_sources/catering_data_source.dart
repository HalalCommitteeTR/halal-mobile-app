import 'package:halal_mobile_app/features/caterings/domain/entities/company_branch.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';

import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';

abstract class CateringDataSource {
  const CateringDataSource();

  Future<List<CompanyBranch>?> getCaterings({
    int? offset,
    int? limit,
    String? like,
    OrderBy? orderBy,
  });

  Future<CompanyBranch?> getCateringById(int id);
}
