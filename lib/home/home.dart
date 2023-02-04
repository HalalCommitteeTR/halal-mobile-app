import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_mobile_app/app/lectures/lectures.dart';
import 'package:halal_mobile_app/app/prayer_time/prayer_time.dart';
import 'package:halal_mobile_app/app/venues/venues.dart';
import 'package:halal_mobile_app/composition/composition.dart';

import 'home_cubit.dart';

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
        children: const [Composition(), Venues(), Lectures(), PrayerTime()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Composition',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Venues',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Lectures',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Prayer time',
          ),
        ],
        currentIndex: selectedTab.index,
        onTap: (index) =>
            context.read<HomeCubit>().setTab(HomeTab.values[index]),
        selectedItemColor: Colors.green,
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final HomeTab groupValue;
  final HomeTab value;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      icon: icon,
      iconSize: 17,
      color:
          value != groupValue ? null : Theme.of(context).colorScheme.secondary,
    );
  }
}
