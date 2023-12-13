part of 'items_overview_bloc.dart';

abstract class ItemsOverviewEvent extends Equatable {
  const ItemsOverviewEvent();

  @override
  List<Object> get props => [];
}

class ItemsOverviewSubscriptionRequested extends ItemsOverviewEvent {
  const ItemsOverviewSubscriptionRequested();
}

class ItemsOverviewStartListening extends ItemsOverviewEvent {
  const ItemsOverviewStartListening();
}

class ItemsOverviewDataUpdated extends ItemsOverviewEvent {
  const ItemsOverviewDataUpdated({required this.items});

  final List<Item> items;

  @override
  List<Object> get props => [items];
}

class ItemsOverviewFilterChanged extends ItemsOverviewEvent {
  const ItemsOverviewFilterChanged({
    required this.filter,
    required this.permissivenessFilter,
    required this.orderBy,
  });

  final ItemsViewFilter filter;
  final Set<Permissiveness> permissivenessFilter;
  final OrderBy orderBy;

  @override
  List<Object> get props => [
        filter,
        permissivenessFilter,
        orderBy,
      ];
}

class ItemsSearchCompleted extends ItemsOverviewEvent {
  const ItemsSearchCompleted({
    required this.searchString,
  });

  final String searchString;

  @override
  List<Object> get props => [searchString];
}
