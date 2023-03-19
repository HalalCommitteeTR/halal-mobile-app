import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:halal_mobile_app/home/cubit/home_cubit.dart';
import 'package:halal_mobile_app/home/cubit/home_state.dart';

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
          Text('cookie'),
          Text('map'),
          Text('settings'),
        ],
      ),
      bottomNavigationBar: FittedBox(
        child: Container(
          margin: const EdgeInsets.only(bottom: 40, left: 90, right: 90),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 129, 0, 0.1),
                offset: Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Color.fromRGBO(0, 129, 0, 0.1),
                offset: Offset(0, 0),
                blurRadius: 1,
              ),
            ],
          ),
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            iconSize: 40,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            tabBorderRadius: 20,
            //backgroundColor: Colors.green,
            color: Colors.white,
            tabBackgroundColor: Colors.white,
            activeColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            onTabChange: (index) => context.read<HomeCubit>().setTab(
                  HomeTab.values[index],
                ),
            tabs: const [
              GButton(icon: Icons.cookie_outlined),
              GButton(icon: Icons.map_outlined),
              GButton(icon: Icons.settings_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
