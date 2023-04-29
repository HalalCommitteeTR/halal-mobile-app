import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:halal_mobile_app/api/api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:halal_mobile_app/features/app/app.dart';
import 'package:halal_mobile_app/repositories/item_repository.dart';
import 'package:halal_mobile_app/simple_bloc_observer.dart';
import 'package:halal_mobile_app/firebase_options.dart';

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
  final httpFoodAdditiveApiClient = HttpFoodAdditiveApiClient();
  runApp(
    App(
      itemRepository:
          ItemRepository(foodAdditiveApi: httpFoodAdditiveApiClient),
    ),
  );
}
