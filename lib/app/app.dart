import 'package:flutter/material.dart';

import '../home/view/home_page.dart';
import '../theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppView();
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
