import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_mobile_app/features/caterings/presentation/blocs/catering_bloc.dart';
import 'package:halal_mobile_app/features/caterings/presentation/widgets/catering_tile.dart';
import 'package:halal_mobile_app/features/caterings/presentation/widgets/caterings_filter_window.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/widgets/bottom_loader.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/widgets/halal_search_bar.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/widgets/logo_bar.dart';

import '../../../settings/settings.dart';

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
                    title: LogoBar(onSettingsPressed: () {Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );}),
                  ),
                  SliverAppBar(
                    pinned: true,
                    toolbarHeight: 68,
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    backgroundColor: Theme.of(context).primaryColor,
                    title: HalalSearchBar(
                      filterWindow: CateringsFilterWindow(),
                      search: (String searchString) {
                        context.read<CateringBloc>().add(
                              CateringsSearchCompleted(
                                searchString: searchString,
                              ),
                            );
                        context
                            .read<CateringBloc>()
                            .add(CateringSubscriptionRequested());
                      },
                    ),
                  ),
                ];
              },
              body: CustomScrollView(
                slivers: [
                  if (state.status == CateringOverviewStatus.initial)
                    SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  if (state.status == CateringOverviewStatus.loading ||
                      state.status == CateringOverviewStatus.success)
                    SliverList.builder(
                      itemBuilder: (context, index) {
                        return index >= state.filteredCaterings.length
                            ? const BottomLoader()
                            : CateringTile(
                                companyBranch: state.filteredCaterings[index],
                              );
                      },
                      itemCount: state.hasReachedMax
                          ? state.filteredCaterings.length
                          : state.filteredCaterings.length + 1,
                      // delegate: SliverChildBuilderDelegate(
                      //   childCount: state.hasReachedMax
                      //       ? state.filteredCaterings.length
                      //       : state.filteredCaterings.length + 1,
                      //   (_, index) {
                      //     return index >= state.filteredCaterings.length
                      //         ? const BottomLoader()
                      //         : CateringTile(
                      //             companyBranch: state.filteredCaterings[index],
                      //           );
                      //   },
                      // ),
                    ),
                  if (state.status == CateringOverviewStatus.failure)
                    Center(
                      child: Text('Fail to load items'),
                    ),
                ],
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
