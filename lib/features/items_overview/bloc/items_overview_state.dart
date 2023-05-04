part of 'items_overview_bloc.dart';

enum ItemsOverviewStatus { initial, loading, success, failure, }

class ItemsOverviewState extends Equatable {
  const ItemsOverviewState({
    this.status = ItemsOverviewStatus.initial,
    this.items = const [],
    this.filter = ItemsViewFilter.all,
    // this.permissivenessFilter = PermissivenessFilter.standard(),
    this.hasReachedMax = false,
  });

  final ItemsOverviewStatus status;
  final List<Item> items;
  final ItemsViewFilter filter;
  // final PermissivenessFilter permissivenessFilter;
  final bool hasReachedMax;

  Iterable<Item> get filteredTodos => filter.applyAll(items);

  ItemsOverviewState copyWith({
    ItemsOverviewStatus Function()? status,
    List<Item> Function()? items,
    ItemsViewFilter Function()? filter,
    bool Function()? hasReachedMax,
  }) {
    return ItemsOverviewState(
        status: status != null ? status() : this.status,
        items: items != null ? items() : this.items,
        filter: filter != null ? filter() : this.filter,
        hasReachedMax: hasReachedMax != null ? hasReachedMax() :
          this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props =>
      [
        status,
        items,
        filter,
        hasReachedMax,
      ];
}
