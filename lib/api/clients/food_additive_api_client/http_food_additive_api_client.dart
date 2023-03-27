import 'dart:convert';
import 'dart:io';

import 'package:halal_mobile_app/api/clients/food_additive_api_client/food_additive_api_client.dart';
import 'package:halal_mobile_app/api/models/food_additive/food_additive.dart';
import 'package:http/http.dart' as http;

class FoodAdditiveByIdFailure implements Exception {}

class FoodAdditivesFailure implements Exception {}

class HttpFoodAdditiveApiClient extends FoodAdditiveApi {
  HttpFoodAdditiveApiClient({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  // TODO - fill base url
  static const _baseUrl = 'https://28e5-188-130-155-160.eu.ngrok.io/api/v1';

  @override
  Future<FoodAdditive?> getFoodAdditive(int id) async {
    final uri = Uri.parse('$_baseUrl/food_additives/$id');
    final response = await _client.get(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw FoodAdditiveByIdFailure();
    }
    final json = jsonDecode(response.body);
    final foodAdditive = FoodAdditive.fromJson(json);
    return foodAdditive;
  }

  @override
  Future<List<FoodAdditive>?> getFoodAdditives(
      {int offset = 0, int limit = 15}) async {
    final queryParameters = {
      'offset': '$offset',
      'limit': '$limit',
    };
    // final uri = Uri.https(_baseUrl, '/food_additives', queryParameters);
    final uri = Uri.parse('$_baseUrl/food_additives')
      ..replace(queryParameters: queryParameters);
    print(uri);
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
