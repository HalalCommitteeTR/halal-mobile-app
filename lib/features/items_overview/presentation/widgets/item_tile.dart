import 'package:flutter/material.dart';

import 'package:halal_mobile_app/features/common/widgets/app_tile.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/widgets/permissiveness_badge.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Item item;

  Color get _borderColor {
    switch (item.permissiveness) {
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
    return AppTile(
      title: Text(item.name),
      subtitle:
      item is FoodAdditive ? Text((item as FoodAdditive).eNumber) : null,
      // leading: Image.network(
      //   foodAdditive.imageSource ?? '',
      //   errorBuilder: (context, _, __) =>
      //   const Icon(Icons.emoji_food_beverage_rounded),
      // ),
      leading: const Icon(Icons.emoji_food_beverage_rounded),
      trailing: PermissivenessBadge(
        permissiveness: item.permissiveness,
      ),
      description: item.description != null
          ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(item.description!),
          )
          : null,
      borderColor: _borderColor,
    );
  }
}