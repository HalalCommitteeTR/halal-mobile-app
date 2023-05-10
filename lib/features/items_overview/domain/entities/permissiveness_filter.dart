import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';

import 'item.dart';

class PermissivenessFilter {
  final Set<Permissiveness> permissiveness;

  const PermissivenessFilter({
    this.permissiveness = const {
      Permissiveness.halal,
      Permissiveness.haram,
      Permissiveness.doubtful,
    },
  });

  bool apply(FoodAdditive foodAdditive) {
    return permissiveness.contains(foodAdditive.permissiveness);
  }

  Iterable<FoodAdditive> applyAll(Iterable<FoodAdditive> foodAdditives) {
    return foodAdditives.where(apply);
  }
}
