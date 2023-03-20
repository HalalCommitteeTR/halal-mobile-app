import 'package:halal_mobile_app/api/clients/food_additive_api_client/food_additive_api_client.dart';
import 'package:halal_mobile_app/api/models/item/Item.dart';

import '../api/models/food_additive/food_additive.dart';

class ItemRepository {
  ItemRepository({required FoodAdditiveApi foodAdditiveApi})
      : _foodAdditiveApi = foodAdditiveApi;

  final FoodAdditiveApi _foodAdditiveApi;

  Future<List<Item>> getItems({int offset= 0, int limit = 100}) async {
    // final foodAdditives =
    //     await _foodAdditiveApi.getFoodAdditives(offset: offset, limit: limit);
    // return List<Item>.from(foodAdditives ?? []);
    final foodAdditives = [FoodAdditive(id: 1, name: 'Name1', permissiveness: Permissiveness.halal, description: 'Description1', eNumber: 'E123'),
      FoodAdditive(id: 2, name: 'Name1', permissiveness: Permissiveness.halal, description: 'Description1', eNumber: 'E123'),
      FoodAdditive(id: 3, name: 'Name1', permissiveness: Permissiveness.halal, description: 'Description1', eNumber: 'E123'),
      FoodAdditive(id: 4, name: 'Name1', permissiveness: Permissiveness.halal, description: 'Description1', eNumber: 'E123'),
      FoodAdditive(id: 5, name: 'Name1', permissiveness: Permissiveness.halal, description: 'Description1', eNumber: 'E123'),
      FoodAdditive(id: 6, name: 'Name1', permissiveness: Permissiveness.halal, description: 'Description1', eNumber: 'E123'),
      FoodAdditive(id: 7, name: 'Name1', permissiveness: Permissiveness.halal, description: 'Description1', eNumber: 'E123'),
      FoodAdditive(id: 8, name: 'Name1', permissiveness: Permissiveness.halal, description: 'Description1', eNumber: 'E123'),
      FoodAdditive(id: 9, name: 'Name1', permissiveness: Permissiveness.halal, description: 'Description1', eNumber: 'E123'),
      FoodAdditive(id: 10, name: 'Name1', permissiveness: Permissiveness.halal, description: 'Description1', eNumber: 'E123'),
      FoodAdditive(id: 11, name: 'Name1', permissiveness: Permissiveness.halal, description: 'Description1', eNumber: 'E123'),
    ];
    return foodAdditives;
  }
}
