import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_mobile_app/repositories/item_repository.dart';

import '../home/view/home_page.dart';
import '../theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key, required this.itemRepository});

  final ItemRepository itemRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: itemRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halal app',
      theme: HalalAppTheme.light,
      home: const HomePage(),
    );
  }
}
