import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';

import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';
import 'package:halal_mobile_app/features/items_overview/domain/repositories/item_repository.dart';

import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';

class ItemRepositoryMock implements ItemRepository {
  @override
  Future<List<FoodAdditive>> getFoodAdditives({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  }) async {
    return Future.value(<FoodAdditive>[
      FoodAdditive(
          id: 1,
          name: 'Name1',
          permissiveness: Permissiveness.halal,
          description: 'Description1',
          eNumber: 'E123',
          imageSource:
          'https://mpmart.ru/upload/medialibrary/ebc/ebc5295f6b848a6456006d15a41523ac.jpg'),
      FoodAdditive(
          id: 2,
          name: 'Name2',
          permissiveness: Permissiveness.haram,
          description: 'Description1',
          eNumber: 'E123'),
      FoodAdditive(
          id: 3,
          name: 'Name3',
          permissiveness: Permissiveness.doubtful,
          description: 'Description1',
          eNumber: 'E123'),
      FoodAdditive(
          id: 4,
          name: 'Name4',
          permissiveness: Permissiveness.halal,
          description: 'Description1',
          eNumber: 'E123'),
      FoodAdditive(
          id: 5,
          name: 'Name5',
          permissiveness: Permissiveness.halal,
          description: 'Description1',
          eNumber: 'E123'),
      FoodAdditive(
          id: 6,
          name: 'Name6',
          permissiveness: Permissiveness.halal,
          description: 'Description1',
          eNumber: 'E123'),
      FoodAdditive(
          id: 7,
          name: 'Name7',
          permissiveness: Permissiveness.halal,
          description: 'Description1',
          eNumber: 'E123'),
      FoodAdditive(
          id: 8,
          name: 'Name8',
          permissiveness: Permissiveness.halal,
          description: 'Description1',
          eNumber: 'E123'),
      FoodAdditive(
          id: 9,
          name: 'Name9',
          permissiveness: Permissiveness.halal,
          description: 'Description1',
          eNumber: 'E123'),
      FoodAdditive(
          id: 10,
          name: 'Name10',
          permissiveness: Permissiveness.halal,
          description: 'Description1',
          eNumber: 'E123'),
      FoodAdditive(
          id: 11,
          name: 'Name11',
          permissiveness: Permissiveness.halal,
          description: 'Description1',
          eNumber: 'E123'),
    ]);
  }

  @override
  Future<List<Ingredient>> getIngredients({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  }) async {
    return Future.value([Ingredient(id: 100, name: 'Ingredient1', permissiveness: Permissiveness.halal),
      Ingredient(id: 101, name: 'Ingredient2', permissiveness: Permissiveness.haram),
      Ingredient(id: 102, name: 'Ingredient3', permissiveness: Permissiveness.doubtful),
      Ingredient(id: 103, name: 'Ingredient4', permissiveness: Permissiveness.halal),
      Ingredient(id: 104, name: 'Ingredient5', permissiveness: Permissiveness.haram),
      Ingredient(id: 105, name: 'Ingredient6', permissiveness: Permissiveness.doubtful),
      Ingredient(id: 106, name: 'Ingredient7', permissiveness: Permissiveness.halal),
      Ingredient(id: 107, name: 'Ingredient8', permissiveness: Permissiveness.halal),]);
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