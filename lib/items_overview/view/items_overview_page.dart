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
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                delegate: ItemSliverAppBar(expandedHeight: 112),
                pinned: true,
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: state.hasReachedMax
                          ? state.items.length
                          : state.items.length + 1, (_, index) {
                return index >= state.items.length
                    ? const BottomLoader()
                    : FoodAdditiveTile(
                        foodAdditive: state.items[index] as FoodAdditive);
              }))
            ],
          );
        // return ListView.builder(
        //   itemBuilder: (context, index) {
        //     return index >= state.items.length
        //         ? const BottomLoader()
        //         : FoodAdditiveTile(
        //             foodAdditive: state.items[index] as FoodAdditive);
        //   },
        //   itemCount: state.hasReachedMax
        //       ? state.items.length
        //       : state.items.length + 1,
        //   controller: _scrollController,
        // );
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

class ItemSliverAppBar extends SliverPersistentHeaderDelegate {
  ItemSliverAppBar({required this.expandedHeight});

  final double expandedHeight;

  bool isExpanded(double shrinkOffset) =>
      shrinkOffset <= maxExtent - minExtent - 16;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      // alignment: Alignment.center,
      children: [
        OverflowBox(
          alignment: Alignment.center,
          maxWidth: double.infinity,
          // left: -55,
          // top: 47,
          child: Container(
            width: 500,
            height: 90,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff1CB555),
                  Color(0xff17A64C),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.6302, 1.0],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            // margin: const EdgeInsets.only(left: 55, top: 47),
          ),
        ),
        // Center(child: Text('ProHalal'),),
        Center(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: 150,
            margin: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 82,
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

const double kToolbarHeight = 92;
