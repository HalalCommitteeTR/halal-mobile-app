import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:halal_mobile_app/api/api.dart';

import 'package:halal_mobile_app/app/app.dart';
import 'package:halal_mobile_app/repositories/item_repository.dart';
import 'package:halal_mobile_app/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final httpFoodAdditiveApiClient = HttpFoodAdditiveApiClient();
  runApp(
    App(
      itemRepository:
          ItemRepository(foodAdditiveApi: httpFoodAdditiveApiClient),
    ),
  );
}
