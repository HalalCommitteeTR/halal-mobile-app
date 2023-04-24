import 'package:flutter/material.dart';
import 'package:halal_mobile_app/api/models/food_additive/food_additive.dart';
import 'package:halal_mobile_app/items_overview/widgets/permissiveness_badge.dart';
import 'package:hive/hive.dart';

class FoodAdditiveTile extends StatefulWidget {
  final FoodAdditive foodAdditive;

  const FoodAdditiveTile({
    super.key,
    required this.foodAdditive,
  });

  @override
  State<FoodAdditiveTile> createState() => _FoodAdditiveTileState();
}

class _FoodAdditiveTileState extends State<FoodAdditiveTile> {
  bool _expanded = false;

  Color get _borderColor {
    switch (widget.foodAdditive.permissiveness) {
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(119, 211, 153, 0.05),
            blurRadius: 10,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color.fromRGBO(119, 211, 153, 0.1),
            blurRadius: 50,
            spreadRadius: 0,
          ),
        ],
        gradient: LinearGradient(
          stops: const [1 / 69, 1 / 69],
          colors: [_borderColor, Colors.white],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        leading: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(0, 0),
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          constraints: const BoxConstraints.tightFor(
            height: 50,
            width: 50,
          ),
          child: Image.network(
            widget.foodAdditive.imageSource ?? '',
            errorBuilder: (context, _, __) =>
                const Icon(Icons.emoji_food_beverage_rounded),
          ),
        ),
        title: Text(widget.foodAdditive.name),
        subtitle: Text(widget.foodAdditive.eNumber ?? ''),
        trailing: PermissivenessBadge(
            permissiveness: widget.foodAdditive.permissiveness),
        children: [
          Text(widget.foodAdditive.description ?? ''),
        ],
        onExpansionChanged: (isExpanded) => setState(() {
          _expanded = isExpanded;
        }),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Card(
//     child: Column(
//       children: <Widget>[
//         ListTile(
//           leading: widget.foodAdditive.imageSource != null ? Image.network(widget.foodAdditive.imageSource!) : null,
//           title: Text(widget.foodAdditive.name),
//           onTap: () {
//             setState(() {
//               _expanded = !_expanded;
//             });
//           },
//           subtitle: widget.foodAdditive.eNumber != null ? Text(widget.foodAdditive.eNumber!) : null,
//         ),
//         _expanded && widget.foodAdditive.description != null ? Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Text(widget.foodAdditive.description!),
//         ) : Container(),
//       ],
//     ),
//   );
// }
}
