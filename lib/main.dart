import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:halal_mobile_app/features/app/app.dart';
import 'package:halal_mobile_app/features/caterings/data/data_sources/http_catering_data_source.dart';
import 'package:halal_mobile_app/features/caterings/data/data_sources/json_catering_data_source.dart';
import 'package:halal_mobile_app/features/caterings/domain/repositories/catering_repository_impl.dart';
import 'package:halal_mobile_app/features/items_overview/data/data_sources/http_item_data_source.dart';
import 'package:halal_mobile_app/features/items_overview/data/data_sources/json_item_data_source.dart';
import 'package:halal_mobile_app/features/items_overview/data/repositories/firebase_item_repository.dart';
import 'package:halal_mobile_app/firebase_options.dart';
import 'package:halal_mobile_app/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  Bloc.observer = SimpleBlocObserver();
  final httpItemDataSource = HttpItemDataSource();
  final httpCateringDataSource = HttpCateringDataSource();
  final jsonItemDataSource = JsonItemDataSource();
  final jsonCateringDataSource = JsonCateringDataSource();
  final firebaseItemRepository = FirebaseItemRepository();
  runApp(
    App(
      itemRepository: //ItemRepositoryMock(),
          //ItemRepositoryImpl(itemDataSource: jsonItemDataSource),
          firebaseItemRepository,
      cateringRepository: CateringRepositoryImpl(
        cateringDataSource: jsonCateringDataSource,
      ),
    ),
  );
}
