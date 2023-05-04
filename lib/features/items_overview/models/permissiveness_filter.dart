import 'package:halal_mobile_app/api/models/food_additive/food_additive.dart';

class PermissivenessFilter {
  final Set<Permissiveness> permissiveness;

  const PermissivenessFilter({required this.permissiveness});

  // factory PermissivenessFilter.standard() = PermissivenessFilter;


  bool apply(FoodAdditive foodAdditive) {
    return permissiveness.contains(foodAdditive.permissiveness);
  }

  Iterable<FoodAdditive> applyAll(Iterable<FoodAdditive> foodAdditives) {
    return foodAdditives.where(apply);
  }
}
