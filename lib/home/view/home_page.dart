import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halal_mobile_app/home/cubit/home_cubit.dart';
import 'package:halal_mobile_app/home/cubit/home_state.dart';
import 'package:halal_mobile_app/items_overview/view/items_overview_page.dart';
import 'package:halal_mobile_app/app_locale.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          ItemsOverviewPage(),
          Text('map'),
          Text('settings'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: AppLocale.of(context).directory.toUpperCase(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: AppLocale.of(context).caterings.toUpperCase(),
          ),
        ],
        showUnselectedLabels: true,
        selectedItemColor: Colors.green,
        backgroundColor: Colors.white,
        onTap: (index) => context.read<HomeCubit>().setTab(
              HomeTab.values[index],
            ),
      ),
    );
  }
}
