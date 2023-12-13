import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:halal_mobile_app/features/caterings/data/data_sources/catering_data_source.dart';
import 'package:halal_mobile_app/features/caterings/domain/entities/company_branch.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';

import '../../../../logger/logger.dart';

class JsonCateringDataSource implements CateringDataSource {
  @override
  Future<CompanyBranch?> getCateringById(int id) {
    // TODO: implement getCateringById
    throw UnimplementedError();
  }

  bool _hasReachedMax = false;
  final _db = FirebaseFirestore.instance;

  @override
  Future<List<CompanyBranch>?> getCaterings({
    int? offset,
    int? limit,
    String? like,
    OrderBy? orderBy,
  }) async {
    final String response =
        await rootBundle.loadString('assets/jsons/restaurants.json');
    logger.i(response);
    final json = jsonDecode(response);
    if (!_hasReachedMax) {
      _hasReachedMax = true;
      // for (final e in json) {
      //   _db.collection('restaurants').add(e);
      // }
      return List<CompanyBranch>.from(
        json.map(
              (json) => CompanyBranch.fromJson(
            json,
          ),
        ),
      );
    } else {
      return [];
    }
  }
}
