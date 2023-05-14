
import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';

enum ItemsViewFilter { all, ingredients, foodAdditives,  drugs, }

extension ItemsViewFilterX on ItemsViewFilter {
  bool apply(Item item) {
    switch (this) {
      case ItemsViewFilter.all:
        return true;
      case ItemsViewFilter.foodAdditives:
        return item is FoodAdditive;
      case ItemsViewFilter.ingredients:
        return item is Ingredient;
      case ItemsViewFilter.drugs:
        return false;
    }
  }

  List<Item> applyAll(List<Item> items) {
    return items.where(apply).toList();
  }
}
