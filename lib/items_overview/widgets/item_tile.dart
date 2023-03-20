import 'package:flutter/material.dart';
import 'package:halal_mobile_app/api/models/food_additive/food_additive.dart';


class FoodAdditiveTile extends StatefulWidget {
  final FoodAdditive foodAdditive;

  const FoodAdditiveTile({super.key, 
    required this.foodAdditive,
  });

  @override
  _FoodAdditiveTileState createState() => _FoodAdditiveTileState();
}

class _FoodAdditiveTileState extends State<FoodAdditiveTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: widget.foodAdditive.imageSource != null ? Image.network(widget.foodAdditive.imageSource!) : null,
            title: Text(widget.foodAdditive.name),
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            subtitle: widget.foodAdditive.eNumber != null ? Text(widget.foodAdditive.eNumber!) : null,
          ),
          _expanded && widget.foodAdditive.description != null ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.foodAdditive.description!),
          ) : Container(),
        ],
      ),
    );
  }
}
