import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halal_mobile_app/features/items_overview/presentation/widgets/bottom_loader.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/widgets/logo_bar.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/widgets/halal_search_bar.dart';
import 'package:halal_mobile_app/features/caterings/presentation/blocs/catering_bloc.dart';
import 'package:halal_mobile_app/features/caterings/presentation/widgets/catering_tile.dart';

class CateringsOverviewPage extends StatelessWidget {
  const CateringsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CateringsOverviewView();
  }
}

class CateringsOverviewView extends StatefulWidget {
  const CateringsOverviewView({Key? key}) : super(key: key);

  @override
  State<CateringsOverviewView> createState() => _CateringsOverviewViewState();
}

class _CateringsOverviewViewState extends State<CateringsOverviewView>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CateringBloc>().add(const CateringSubscriptionRequested());
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CateringBloc, CateringState>(
      builder: (context, state) {
        switch (state.status) {
          case CateringOverviewStatus.failure:
            return const Text('Fail to load items');
          case CateringOverviewStatus.initial:
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          case CateringOverviewStatus.loading:
          case CateringOverviewStatus.success:
            if (state.caterings.isEmpty) {
              return Center(child: const Text('No caterings'));
            }
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
                        title: LogoBar(onSettingsPressed: () {}),
                      ),
                      SliverAppBar(
                        pinned: true,
                        toolbarHeight: 68,
                        automaticallyImplyLeading: false,
                        titleSpacing: 0,
                        backgroundColor: Theme.of(context).primaryColor,
                        title: HalalSearchBar(),
                      ),
                    ];
                  },
                  body: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.hasReachedMax
                              ? state.filteredCaterings.length
                              : state.filteredCaterings.length + 1,
                          (_, index) {
                            return index >= state.filteredCaterings.length
                                ? const BottomLoader()
                                : CateringTile(
                                    companyBranch:
                                        state.filteredCaterings[index],
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
      context.read<CateringBloc>().add(const CateringSubscriptionRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.75);
  }
}
