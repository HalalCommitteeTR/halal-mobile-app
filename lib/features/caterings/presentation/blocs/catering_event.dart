part of 'catering_bloc.dart';

abstract class CateringEvent extends Equatable {
  const CateringEvent();

  @override
  List<Object?> get props => [];
}

class CateringSubscriptionRequested extends CateringEvent {
  const CateringSubscriptionRequested();
}

class CateringFilterChanged extends CateringEvent {
  CateringFilterChanged({
    required this.foodPointTypeFilter,
    required this.cuisineTypeFilter,
    required this.prayerRoomFilter,
    required this.orderBy,
  });

  final Set<FoodPointType> foodPointTypeFilter;
  final Set<CuisineType> cuisineTypeFilter;
  final bool prayerRoomFilter;
  final OrderBy orderBy;

  @override
  List<Object> get props => [
        foodPointTypeFilter,
        cuisineTypeFilter,
        prayerRoomFilter,
        orderBy,
      ];
}

class CateringsSearchCompleted extends CateringEvent {
  const CateringsSearchCompleted({
    required this.searchString,
  });

  final String searchString;

  @override
  List<Object> get props => [searchString];
}
