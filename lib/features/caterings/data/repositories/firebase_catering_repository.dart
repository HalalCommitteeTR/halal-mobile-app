import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halal_mobile_app/features/caterings/domain/entities/company_branch.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';

import '../../../../logger/logger.dart';
import '../../domain/repositories/catering_repository.dart';

class FirebaseCateringRepository implements CateringRepository {
  final _db = FirebaseFirestore.instance;

  bool _hasReachedMax = false;
  String? _prevLike;

  @override
  Future<List<CompanyBranch>> getCaterings({
    int? offset,
    int? limit,
    String? like,
    OrderBy? orderBy,
  }) async {
    if (_hasReachedMax) {
      if (like != _prevLike) {
        _prevLike = like;
        _hasReachedMax = false;
      } else {
        return [];
      }
    }
    _hasReachedMax = true;
    final querySnapshots = await _db.collection('restaurants').get();
    final result =
        querySnapshots.docs.map((e) => CompanyBranch.fromJson(e.data()));
    logger.i(result);
    if (like == null) return result.toList();
    return result
        .where((element) =>
            element.name.toLowerCase().contains(like!.toLowerCase()))
        .toList();
  }
}
