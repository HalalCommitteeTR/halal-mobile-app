import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halal_mobile_app/app_locale.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/items_view_filter.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/bloc/items_overview_bloc.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/widgets/bottom_loader.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/widgets/filter_window.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/widgets/item_tile.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/widgets/logo_bar.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/widgets/halal_search_bar.dart';
import 'package:halal_mobile_app/features/settings/settings.dart';

class ItemsOverviewPage extends StatelessWidget {
  const ItemsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ItemsOverviewView();
  }
}

class ItemsOverviewView extends StatefulWidget {
  const ItemsOverviewView({Key? key}) : super(key: key);

  @override
  State<ItemsOverviewView> createState() => _ItemsOverviewViewState();
}

class _ItemsOverviewViewState extends State<ItemsOverviewView>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  late final TabController _tabController = TabController(
    length: 4,
    vsync: this,
  );

  @override
  void initState() {
    super.initState();
    context.read<ItemsOverviewBloc>().add(ItemsOverviewSubscriptionRequested());
    _scrollController.addListener(_onScroll);
    _tabController.addListener(_onTabChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsOverviewBloc, ItemsOverviewState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (
                BuildContext context,
                bool innerBoxIsScrolled,
              ) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    toolbarHeight: 70,
                    backgroundColor: Theme.of(context).primaryColor,
                    title: LogoBar(
                      onSettingsPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  SliverAppBar(
                    pinned: true,
                    toolbarHeight: 68,
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    backgroundColor: Theme.of(context).primaryColor,
                    title: HalalSearchBar(
                      filterWindow: FilterWindow(),
                      search: (String searchString) {
                        context.read<ItemsOverviewBloc>().add(
                              ItemsSearchCompleted(
                                searchString: searchString,
                              ),
                            );
                        context
                            .read<ItemsOverviewBloc>()
                            .add(ItemsOverviewSubscriptionRequested());
                      },
                    ),
                  ),
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    toolbarHeight: 0,
                    bottom: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: Theme.of(context).textTheme.titleMedium,
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
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [0, 1, 2, 3].map(
                  (e) {
                    return CustomScrollView(
                      slivers: [
                        if (state.status == ItemsOverviewStatus.initial)
                          SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        if (state.status == ItemsOverviewStatus.success ||
                            state.status == ItemsOverviewStatus.loading)
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: state.hasReachedMax
                                  ? state.filteredItems.length
                                  : state.filteredItems.length + 1,
                              (_, index) {
                                return (index < state.filteredItems.length) ||
                                        (state.hasReachedMax)
                                    ? ItemTile(
                                        item: state.filteredItems[index],
                                      )
                                    : const BottomLoader();
                              },
                            ),
                          ),
                        if (state.status == ItemsOverviewStatus.failure)
                          Center(
                            child: Text('Fail to load items'),
                          ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _tabController
      ..removeListener(_onTabChanged)
      ..dispose();
    super.dispose();
  }

  void _onTabChanged() {
    final state = context.read<ItemsOverviewBloc>().state;
    if (true) {
      context.read<ItemsOverviewBloc>().add(ItemsOverviewFilterChanged(
            filter: ItemsViewFilter.values[_tabController.index],
            permissivenessFilter: state.permissivenessFilter,
            orderBy: state.orderBy,
          ));
    }
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
    return currentScroll >= (maxScroll * 0.75);
  }
}
