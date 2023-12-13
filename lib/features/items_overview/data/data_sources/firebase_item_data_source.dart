import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halal_mobile_app/features/items_overview/data/data_sources/item_data_source.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';

class FirebaseItemDataSource implements ItemDataSource {
  final _db = FirebaseFirestore.instance;

  Stream<List<FoodAdditive>> foodAdditiveStream() {
    return _db.collection('/food_additives').snapshots().map(
          (event) => event.docs
              .map(
                (e) => FoodAdditive.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );

  }

  @override
  Future<FoodAdditive?> getFoodAdditive(int id) {
    // TODO: implement getFoodAdditive
    throw UnimplementedError();
  }

  @override
  Future<List<FoodAdditive>?> getFoodAdditives({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  }) {
    // TODO: implement getFoodAdditives
    throw UnimplementedError();
  }

  @override
  Future<Ingredient?> getIngredient(int id) {
    // TODO: implement getIngredient
    throw UnimplementedError();
  }

  @override
  Future<List<Ingredient>?> getIngredients({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  }) {
    // TODO: implement getIngredients
    throw UnimplementedError();
  }
}
