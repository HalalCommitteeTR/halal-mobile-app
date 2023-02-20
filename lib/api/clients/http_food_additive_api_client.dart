import 'dart:convert';
import 'dart:io';

import 'package:halal_mobile_app/api/clients/food_additive_api_client.dart';
import 'package:halal_mobile_app/api/models/food_additive/food_additive.dart';
import 'package:http/http.dart' as http;

class FoodAdditiveByIdFailure implements Exception {}

class FoodAdditivesFailure implements Exception {}

class HttpFoodAdditiveApiClient extends FoodAdditiveApi {
  HttpFoodAdditiveApiClient({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;
  static const _baseUrl = 'https://eedb-45-142-215-13.ngrok.io';

  @override
  Future<FoodAdditive?> getFoodAdditive(int id) async {
    final uri = Uri.parse('$_baseUrl/api/food_additives/$id');
    final response = await _client.get(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw FoodAdditiveByIdFailure();
    }
    final json = jsonDecode(response.body);
    final foodAdditive = FoodAdditive.fromJson(json);
    return foodAdditive;
  }

  @override
  Future<List<FoodAdditive>?> getFoodAdditives() async {
    final uri = Uri.parse('$_baseUrl/api/food_additives');
    final response = await _client.get(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw FoodAdditivesFailure();
    }
    final json = jsonDecode(response.body);
    final foodAdditivesList = List<FoodAdditive>.from(
      json.map(
            (jsonFoodAdditive) => FoodAdditive.fromJson(jsonFoodAdditive),
      ),
    );
    return foodAdditivesList;
  }
}
