part of 'items_overview_bloc.dart';

class ItemsOverviewState extends Equatable {
  const ItemsOverviewState({
    this.status = ItemsOverviewStatus.initial,
    this.items = const [],
    this.itemsViewFilter = ItemsViewFilter.all,
    this.permissivenessFilter = const {
      Permissiveness.halal,
      Permissiveness.haram,
      Permissiveness.doubtful,
    },
    this.orderBy = OrderBy.none,
    this.hasReachedMax = false,
    this.searchString = '',
  });

  final ItemsOverviewStatus status;
  final List<Item> items;
  final ItemsViewFilter itemsViewFilter;

  final Set<Permissiveness> permissivenessFilter;
  final OrderBy orderBy;
  final bool hasReachedMax;
  final String searchString;

  List<Item> get filteredItems {
    return items.where((element) {
      return permissivenessFilter.contains(element.permissiveness) &&
          itemsViewFilter.apply(element);
    }).toList()
      ..sort(orderBy.compareTo);
  }

  ItemsOverviewState copyWith({
    ItemsOverviewStatus? status,
    List<Item>? items,
    ItemsViewFilter? filter,
    Set<Permissiveness>? permissivenessFilter,
    OrderBy? orderBy,
    bool? hasReachedMax,
    String? searchString,
  }) {
    return ItemsOverviewState(
      status: status != null ? status : this.status,
      items: items != null ? items : this.items,
      itemsViewFilter: filter != null ? filter : this.itemsViewFilter,
      permissivenessFilter: permissivenessFilter != null
          ? permissivenessFilter
          : this.permissivenessFilter,
      orderBy: orderBy != null ? orderBy : this.orderBy,
      hasReachedMax: hasReachedMax != null ? hasReachedMax : this.hasReachedMax,
      searchString: searchString ?? this.searchString,
    );
  }

  @override
  List<Object?> get props => [
        status,
        items,
        itemsViewFilter,
        hasReachedMax,
        permissivenessFilter,
        orderBy,
        searchString,
      ];
}

enum ItemsOverviewStatus {
  initial,
  loading,
  success,
  failure,
}
