import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halal_mobile_app/api/api.dart';
import 'package:halal_mobile_app/features/items_overview/bloc/items_overview_bloc.dart';
import 'package:halal_mobile_app/features/items_overview/widgets/logo_bar.dart';
import 'package:halal_mobile_app/features/items_overview/widgets/search_bar.dart';
import 'package:halal_mobile_app/repositories/item_repository.dart';
import 'package:halal_mobile_app/features/items_overview/widgets/bottom_loader.dart';
import 'package:halal_mobile_app/features/items_overview/widgets/food_additive_tile.dart';
import 'package:halal_mobile_app/app_locale.dart';

class ItemsOverviewPage extends StatelessWidget {
  const ItemsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemsOverviewBloc(
        itemRepository: context.read<ItemRepository>(),
      )..add(const ItemsOverviewSubscriptionRequested()),
      child: const ItemsOverviewView(),
    );
  }
}

class ItemsOverviewView extends StatefulWidget {
  const ItemsOverviewView({Key? key}) : super(key: key);

  @override
  State<ItemsOverviewView> createState() => _ItemsOverviewViewState();
}

class _ItemsOverviewViewState extends State<ItemsOverviewView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsOverviewBloc, ItemsOverviewState>(
      builder: (context, state) {
        switch (state.status) {
          case ItemsOverviewStatus.failure:
            return const Text('Fail to load items');
          case ItemsOverviewStatus.initial:
            return const CircularProgressIndicator();
          case ItemsOverviewStatus.loading:
            // TODO: No need in this state
            return const CircularProgressIndicator();
          case ItemsOverviewStatus.success:
            if (state.items.isEmpty) {
              return const Text('no items');
            }
            return SafeArea(
              child: Scaffold(
                body: DefaultTabController(
                  length: 4,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        titleSpacing: 0,
                        toolbarHeight: 70,
                        backgroundColor: Theme.of(context).primaryColor,
                        title: LogoBar(onSettingsPressed: () {}),
                      ),
                      SliverAppBar(
                        pinned: true,
                        toolbarHeight: 68,
                        automaticallyImplyLeading: false,
                        titleSpacing: 0,
                        backgroundColor: Theme.of(context).primaryColor,
                        title: SearchBar(),
                      ),
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.white,
                        toolbarHeight: 0,
                        bottom: TabBar(
                          indicatorColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelStyle: TextStyle(fontSize: 18),
                          labelPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          padding: EdgeInsets.only(
                            right: 10,
                          ),
                          unselectedLabelColor: Colors.black38,
                          tabs: [
                            Text(AppLocale.of(context).all),
                            Text(AppLocale.of(context).products),
                            Text(AppLocale.of(context).additives),
                            Text(AppLocale.of(context).drugs),
                          ],
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.hasReachedMax
                              ? state.items.length
                              : state.items.length + 1,
                          (_, index) {
                            return index >= state.items.length
                                ? const BottomLoader()
                                : FoodAdditiveTile(
                                    foodAdditive:
                                        state.items[index] as FoodAdditive,
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context
          .read<ItemsOverviewBloc>()
          .add(const ItemsOverviewSubscriptionRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
