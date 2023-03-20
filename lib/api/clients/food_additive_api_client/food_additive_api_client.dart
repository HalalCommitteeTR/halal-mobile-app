import '../../models/food_additive/food_additive.dart';

abstract class FoodAdditiveApi {
  const FoodAdditiveApi();

  Future<List<FoodAdditive>?> getFoodAdditives({int offset=0, int limit=100});

  Future<FoodAdditive?> getFoodAdditive(int id);
}
