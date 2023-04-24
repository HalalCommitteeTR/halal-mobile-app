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
  const ItemsOverviewFilterChanged(this.filter);

  final ItemsViewFilter filter;

  @override
  List<Object> get props => [filter];
}


