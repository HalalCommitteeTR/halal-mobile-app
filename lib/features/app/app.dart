import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_mobile_app/app_locale.dart';
import 'package:halal_mobile_app/features/caterings/domain/repositories/catering_repository_impl.dart';
import 'package:halal_mobile_app/features/caterings/presentation/blocs/catering_bloc.dart';
import 'package:halal_mobile_app/features/home/home.dart';
import 'package:halal_mobile_app/features/items_overview/data/repositories/firebase_item_repository.dart';
import 'package:halal_mobile_app/features/items_overview/domain/repositories/item_repository.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/bloc/items_overview_stream_bloc.dart';
import 'package:halal_mobile_app/theme/halal_app_theme.dart';

import '../items_overview/presentation/bloc/items_overview_bloc.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.itemRepository,
    required this.cateringRepository,
  });

  final ItemRepository itemRepository;
  final CateringRepositoryImpl cateringRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: itemRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ItemsOverviewStreamBloc(
              itemRepository: FirebaseItemRepository(),
            ),
          ),
          BlocProvider(
            create: (_) => ItemsOverviewBloc(
              itemRepository: itemRepository,
            ),
          ),
          BlocProvider(
            create: (_) => CateringBloc(
              cateringRepository: cateringRepository,
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halal app',
      localizationsDelegates: AppLocale.localizationDelegates,
      supportedLocales: AppLocale.supportedLocales,
      theme: HalalAppTheme.light,
      home: const HomePage(),
    );
  }
}
