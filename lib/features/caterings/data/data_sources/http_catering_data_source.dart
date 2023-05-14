import 'dart:convert';
import 'dart:io';

import 'package:halal_mobile_app/logger/logger.dart';
import 'package:http/http.dart' as http;

import 'package:halal_mobile_app/features/caterings/data/data_sources/catering_data_source.dart';
import 'package:halal_mobile_app/features/caterings/domain/entities/company_branch.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';

class HttpCateringDataSource extends CateringDataSource {
  HttpCateringDataSource({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  // TODO - fill base url
  static const _baseUrl = 'http://84.201.184.214/api/v1';

  @override
  Future<CompanyBranch?> getCateringById(int id) async {
    final uri = Uri.parse('$_baseUrl/food_points/$id');
    final response = await _client.get(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw CateringByIdFailure();
    }
    final json = jsonDecode(response.body);
    logger.i(json);
    return CompanyBranch.fromJson(json);
  }

  @override
  Future<List<CompanyBranch>?> getCaterings({
    int? offset,
    int? limit,
    String? like,
    OrderBy? orderBy,
  }) async {
    final queryParameters = {
      if (offset != null) 'offset': '$offset',
      if (limit != null) 'limit': '$limit',
      if (like != null) 'like': '$like',
      if (orderBy != null) 'orderBy': '$orderBy',
    };
    final uri = Uri.parse('$_baseUrl/food_points')
        .replace(queryParameters: queryParameters);
    logger.i(uri);
    final response = await _client.get(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw CateringFailure();
    }
    final json = jsonDecode(response.body);
    return List<CompanyBranch>.from(
      json.map(
        (jsonCompanyBranch) => CompanyBranch.fromJson(
          jsonCompanyBranch,
        ),
      ),
    );
  }
}

class CateringByIdFailure implements Exception {}

class CateringFailure implements Exception {}
