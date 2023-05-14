import 'package:halal_mobile_app/features/caterings/domain/entities/company_branch.dart';
import 'package:halal_mobile_app/features/items_overview/data/data_sources/item_data_source.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';

import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';
import 'package:halal_mobile_app/features/items_overview/domain/repositories/item_repository.dart';

import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';

import '../../data/data_sources/catering_data_source.dart';

class CateringRepositoryImpl {
  CateringRepositoryImpl({required CateringDataSource cateringDataSource})
      : _cateringDataSource = cateringDataSource;

  final CateringDataSource _cateringDataSource;


  // @override
  Future<List<CompanyBranch>> getCaterings({
    int? offset,
    int? limit,
    String? like,
    OrderBy? orderBy,
  }) async {
    return await _cateringDataSource.getCaterings(
      offset: offset,
      limit: limit,
      like: like,
      orderBy: orderBy,
    ) ?? [];
  }
}
