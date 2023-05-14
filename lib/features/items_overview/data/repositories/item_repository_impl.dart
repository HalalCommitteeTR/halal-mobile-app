import 'package:halal_mobile_app/features/items_overview/data/data_sources/item_data_source.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';

import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';
import 'package:halal_mobile_app/features/items_overview/domain/repositories/item_repository.dart';

import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';

class ItemRepositoryImpl implements ItemRepository {
  ItemRepositoryImpl({required ItemDataSource itemDataSource})
      : _itemDataSource = itemDataSource;

  final ItemDataSource _itemDataSource;


  @override
  Future<List<FoodAdditive>> getFoodAdditives({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  }) async {
    return await _itemDataSource.getFoodAdditives(
          offset: offset,
          limit: limit,
          permissiveness: permissiveness,
          like: like,
          orderBy: orderBy,
        ) ??
        [];
  }

  @override
  Future<List<Ingredient>> getIngredients({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  }) async {
    return await _itemDataSource.getIngredients(
          offset: offset,
          limit: limit,
          permissiveness: permissiveness,
          like: like,
          orderBy: orderBy,
        ) ??
        [];
  }

  @override
  Future<List<Item>> getItems({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  }) async {
    final foodAdditives = await getFoodAdditives(
      offset: offset,
      limit: limit,
      permissiveness: permissiveness,
      like: like,
      orderBy: orderBy,
    );
    final ingredients = await getIngredients(
      offset: offset,
      limit: limit,
      permissiveness: permissiveness,
      like: like,
      orderBy: orderBy,
    );
    return List<Item>.of([...foodAdditives, ...ingredients]);
  }
}
