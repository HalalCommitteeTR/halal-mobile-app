import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_mobile_app/api/api.dart';
import 'package:halal_mobile_app/items_overview/bloc/items_overview_bloc.dart';

import 'package:halal_mobile_app/repositories/item_repository.dart';

import '../widgets/bottom_loader.dart';
import '../widgets/item_tile.dart';

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
          return ListView.builder(
            itemBuilder: (context, index) {
              return index >= state.items.length
                  ? const BottomLoader()
                  : FoodAdditiveTile(
                      foodAdditive: state.items[index] as FoodAdditive);
            },
            itemCount: state.hasReachedMax
                ? state.items.length
                : state.items.length + 1,
            controller: _scrollController,
          );
      }
    });
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
