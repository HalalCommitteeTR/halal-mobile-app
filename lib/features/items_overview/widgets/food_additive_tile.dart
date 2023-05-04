import 'package:flutter/material.dart';

import 'package:halal_mobile_app/features/items_overview/widgets/permissiveness_badge.dart';
import 'package:halal_mobile_app/api/models/food_additive/food_additive.dart';
import 'package:halal_mobile_app/features/common/widgets/item_tile.dart';

class FoodAdditiveTile extends StatelessWidget {
  const FoodAdditiveTile({
    Key? key,
    required this.foodAdditive,
  }) : super(key: key);
  final FoodAdditive foodAdditive;

  Color get _borderColor {
    switch (foodAdditive.permissiveness) {
      case Permissiveness.halal:
        return const Color(0xFF1CB555);
      case Permissiveness.haram:
        return const Color(0xFFB5221B);
      case Permissiveness.doubtful:
        return const Color(0xFF1C4C89);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ItemTile(
      title: Text(foodAdditive.name),
      subtitle:
      foodAdditive.eNumber != null ? Text(foodAdditive.eNumber!) : null,
      // leading: Image.network(
      //   foodAdditive.imageSource ?? '',
      //   errorBuilder: (context, _, __) =>
      //   const Icon(Icons.emoji_food_beverage_rounded),
      // ),
      leading: const Icon(Icons.emoji_food_beverage_rounded),
      trailing: PermissivenessBadge(
        permissiveness: foodAdditive.permissiveness,
      ),
      description: foodAdditive.description != null
          ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(foodAdditive.description!),
          )
          : null,
      borderColor: _borderColor,
    );
  }
}