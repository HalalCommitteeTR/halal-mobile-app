import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';


abstract class ItemRepository {
  Future<List<FoodAdditive>> getFoodAdditives({
    int offset = 0,
    int limit = 15,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  });

  Future<List<Ingredient>> getIngredients({
    int offset = 0,
    int limit = 15,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  });

  Future<List<Item>> getItems({
    int offset = 0,
    int limit = 15,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  });
}