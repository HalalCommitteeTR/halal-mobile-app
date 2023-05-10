import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halal_mobile_app/features/caterings/view/caterings_page.dart';
import 'package:halal_mobile_app/features/home/cubit/home_cubit.dart';
import 'package:halal_mobile_app/features/home/cubit/home_state.dart';
import 'package:halal_mobile_app/app_locale.dart';
import 'package:halal_mobile_app/halal_icons.dart';

import 'package:halal_mobile_app/features/items_overview/presentation/screens/items_overview_page.dart';

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
      backgroundColor: Theme.of(context).primaryColor,
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          ItemsOverviewPage(),
          CateringsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: [
          BottomNavigationBarItem(
            icon: Icon(HalalIcons.directory),
            label: AppLocale.of(context).directory.toUpperCase(),
          ),
          BottomNavigationBarItem(
            icon: Icon(HalalIcons.caterings),
            label: AppLocale.of(context).caterings.toUpperCase(),
          ),
        ],
        showUnselectedLabels: true,
        currentIndex: selectedTab.index,
        selectedItemColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        onTap: (index) => context.read<HomeCubit>().setTab(
              HomeTab.values[index],
            ),
      ),
    );
  }
}
