import '../../models/food_additive/food_additive.dart';

abstract class FoodAdditiveApi {
  const FoodAdditiveApi();

  Future<List<FoodAdditive>?> getFoodAdditives();

  Future<FoodAdditive?> getFoodAdditive(int id);
}
