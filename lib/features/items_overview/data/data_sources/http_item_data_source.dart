import 'dart:convert';
import 'dart:io';

import 'package:halal_mobile_app/features/items_overview/data/data_sources/item_data_source.dart';
import 'package:http/http.dart' as http;

import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';

class HttpItemDataSource extends ItemDataSource {
  HttpItemDataSource({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  // TODO - fill base url
  static const _baseUrl = 'http://84.201.184.214/api/v1';

  @override
  Future<FoodAdditive?> getFoodAdditive(int id) async {
    final uri = Uri.parse('$_baseUrl/food_additives/$id');
    final response = await _client.get(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw ItemByIdFailure();
    }
    final json = jsonDecode(response.body);
    return FoodAdditive.fromJson(json);
  }

  @override
  Future<List<FoodAdditive>?> getFoodAdditives({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  }) async {
    final queryParameters = {
      if (offset != null) 'offset': '$offset',
      if (limit != null) 'limit': '$limit',
      // TODO - permissiveness is a multivalued parameter
      if (permissiveness != null) 'permissiveness': '$permissiveness',
      if (like != null) 'like': '$like',
      if (orderBy != null) 'orderBy': '$orderBy',
    };
    // final uri = Uri.https(_baseUrl, '/food_additives', queryParameters);
    final uri = Uri.parse('$_baseUrl/food_additives')
        .replace(queryParameters: queryParameters);
    print(uri);
    final response = await _client.get(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw ItemsFailure();
    }
    final json = jsonDecode(response.body);
    return List<FoodAdditive>.from(
      json.map(
        (jsonFoodAdditive) => FoodAdditive.fromJson(
          jsonFoodAdditive,
        ),
      ),
    );
  }

  @override
  Future<Ingredient?> getIngredient(int id) async {
    final uri = Uri.parse('$_baseUrl/ingredients_info/$id');
    final response = await _client.get(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw ItemByIdFailure();
    }
    final json = jsonDecode(response.body);
    return Ingredient.fromJson(json);
  }

  @override
  Future<List<Ingredient>?> getIngredients({
    int? offset,
    int? limit,
    Permissiveness? permissiveness,
    String? like,
    OrderBy? orderBy,
  }) async {
    final queryParameters = {
      if (offset != null) 'offset': '$offset',
      if (limit != null) 'limit': '$limit',
      // TODO - permissiveness is a multivalued parameter
      if (permissiveness != null) 'permissiveness': '$permissiveness',
      if (like != null) 'like': '$like',
      if (orderBy != null) 'orderBy': '$orderBy',
    };
    final uri = Uri.parse('$_baseUrl/ingredients_info')
        .replace(queryParameters: queryParameters);
    print(uri);
    final response = await _client.get(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw ItemsFailure();
    }
    final json = jsonDecode(response.body);
    return List<Ingredient>.from(
      json.map(
        (jsonIngredient) => Ingredient.fromJson(
          jsonIngredient,
        ),
      ),
    );
  }
}

class ItemByIdFailure implements Exception {}

class ItemsFailure implements Exception {}
