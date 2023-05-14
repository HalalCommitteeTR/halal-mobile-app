import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';

import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';

abstract class ItemDataSource {
  const ItemDataSource();

  Future<List<FoodAdditive>?> getFoodAdditives({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  });

  Future<FoodAdditive?> getFoodAdditive(int id);

  Future<List<Ingredient>?> getIngredients({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  });

  Future<Ingredient?> getIngredient(int id);
}
