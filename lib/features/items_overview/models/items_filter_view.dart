import 'package:halal_mobile_app/api/models/food_additive/food_additive.dart';

import 'package:halal_mobile_app/api/models/item/Item.dart';

enum ItemsViewFilter { all, foodAdditives, products }

extension ItemsViewFilterX on ItemsViewFilter {
  bool apply(Item item) {
    switch (this) {
      case ItemsViewFilter.all:
        return true;
      case ItemsViewFilter.foodAdditives:
        return item is FoodAdditive;
      case ItemsViewFilter.products:
        // return item is Product;
        return false;
    }
  }

  Iterable<Item> applyAll(Iterable<Item> items) {
    return items.where(apply);
  }
}
