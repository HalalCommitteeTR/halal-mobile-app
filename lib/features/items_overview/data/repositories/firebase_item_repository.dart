import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';
import 'package:halal_mobile_app/features/items_overview/domain/repositories/item_repository.dart';
import 'package:halal_mobile_app/logger/logger.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseItemRepository implements ItemRepository {
  final _db = FirebaseFirestore.instance;

  bool _hasReachedMax = false;
  String? _prevLike;

  Stream<List<FoodAdditive>> getFoodAdditiveStream() {
    return _db.collection('/food_additives').snapshots().map(
          (event) => event.docs
              .map(
                (e) => FoodAdditive.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<Ingredient>> getIngredientsStream() {
    return _db.collection('/ingredients').snapshots().map(
          (event) => event.docs
              .map(
                (e) => Ingredient.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<Item>> getItemsStream() {
    final stream1 = getFoodAdditiveStream();
    final stream2 = getIngredientsStream();
    return ZipStream(
      [stream1, stream2],
      (values) => [...values.first, ...values[1]],
    );
  }

  @override
  Future<List<FoodAdditive>> getFoodAdditives({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  }) async {
    final querySnapshots = await _db.collection('food_additives').get();
    try {
      final result =
          querySnapshots.docs.map((e) => FoodAdditive.fromJson(e.data()));
      logger.i(result);
      if (like == null) return result.toList();
      return result
          .where((element) =>
              element.name.toLowerCase().contains(like!.toLowerCase()) ||
              element.eNumber.toLowerCase().contains(like!.toLowerCase()))
          .toList();
    } catch (e, stackTrace) {
      logger.e(e, e, stackTrace);
      return [];
    }
  }

  @override
  Future<List<Ingredient>> getIngredients({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  }) async {
    final querySnapshots = await _db.collection('ingredients').get();
    final result =
        querySnapshots.docs.map((e) => Ingredient.fromJson(e.data()));
    logger.i(result);
    if (like == null) return result.toList();
    return result
        .where((element) =>
            element.name.toLowerCase().contains(like!.toLowerCase()))
        .toList();
  }

  @override
  Future<List<Item>> getItems({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
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
    return [
      ...await getFoodAdditives(
        like: like,
      ),
      ...await getIngredients(
        like: like,
      ),
    ];
  }
}
