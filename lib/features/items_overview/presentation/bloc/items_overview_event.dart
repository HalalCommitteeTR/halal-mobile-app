part of 'items_overview_bloc.dart';

abstract class ItemsOverviewEvent extends Equatable {
  const ItemsOverviewEvent();

  @override
  List<Object> get props => [];
}

class ItemsOverviewSubscriptionRequested extends ItemsOverviewEvent {
  const ItemsOverviewSubscriptionRequested();
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
