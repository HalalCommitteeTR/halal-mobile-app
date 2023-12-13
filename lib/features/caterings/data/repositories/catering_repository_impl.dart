import 'package:halal_mobile_app/features/caterings/data/data_sources/catering_data_source.dart';
import 'package:halal_mobile_app/features/caterings/domain/entities/company_branch.dart';
import 'package:halal_mobile_app/features/caterings/domain/repositories/catering_repository.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';

class CateringRepositoryImpl implements CateringRepository {
  CateringRepositoryImpl({required CateringDataSource cateringDataSource})
      : _cateringDataSource = cateringDataSource;

  final CateringDataSource _cateringDataSource;

  @override
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
        ) ??
        [];
  }
}
