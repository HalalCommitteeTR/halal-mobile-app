import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:halal_mobile_app/features/items_overview/data/data_sources/item_data_source.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';
import 'package:halal_mobile_app/logger/logger.dart';

class JsonItemDataSource implements ItemDataSource {
  @override
  Future<FoodAdditive?> getFoodAdditive(int id) {
    // TODO: implement getFoodAdditive
    throw UnimplementedError();
  }

  bool _hasReachedMaxFoodAdditives = false;
  bool _hasReachedMaxIngredients = false;

  final _db = FirebaseFirestore.instance;

  @override
  Future<List<FoodAdditive>?> getFoodAdditives({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  }) async {
    final String response =
        await rootBundle.loadString('assets/jsons/food_additives.json');
    final json = jsonDecode(response);
    if (!_hasReachedMaxFoodAdditives) {
      _hasReachedMaxFoodAdditives = true;
      final results = List<FoodAdditive>.from(
        json.map(
          (jsonFoodAdditive) => FoodAdditive.fromJson(
            jsonFoodAdditive,
          ),
        ),
      );
      // for (final e in json) {
      //   _db.collection('food_additives').add(e);
      // }
      return results;
    } else {
      return [];
    }
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
  }) async {
    final String response =
        await rootBundle.loadString('assets/jsons/ingredients_info.json');
    logger.i(response);
    final json = jsonDecode(response);
    if (!_hasReachedMaxIngredients) {
      _hasReachedMaxIngredients = true;
      // for (final e in json) {
      //   _db.collection('ingredients').add(e);
      // }
      return List<Ingredient>.from(
        json.map(
          (jsonFoodAdditive) => Ingredient.fromJson(
            jsonFoodAdditive,
          ),
        ),
      );
    } else {
      return [];
    }
  }
}
