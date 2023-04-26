import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halal_mobile_app/api/api.dart';
import 'package:halal_mobile_app/features/app/app.dart';
import 'package:halal_mobile_app/features/caterings/view/caterings_page.dart';
import 'package:halal_mobile_app/features/items_overview/bloc/items_overview_bloc.dart';
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
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPersistentHeader(
                    delegate: ItemSliverAppBar(),
                    pinned: true,
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

class ItemSliverAppBar extends SliverPersistentHeaderDelegate {
  ItemSliverAppBar();

  // final double expandedHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: !overlapsContent
            ? [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ]
            : null,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      AppLocale.of(context).title,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .titleLarge
                          ?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 53,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: AppLocale.of(context).search,
                            iconColor: Theme.of(context).unselectedWidgetColor,
                            icon: Icon(
                              Icons.search,
                              size: 26,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 13,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Icon(
                          Icons.read_more,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

const double kToolbarHeight = 148;
