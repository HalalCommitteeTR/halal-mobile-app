part of 'catering_bloc.dart';

class CateringState extends Equatable {
  const CateringState({
    this.status = CateringOverviewStatus.initial,
    this.caterings = const [],
    this.foodPointTypeFilter = FoodPointType.setOfAll,
    this.cuisineTypeFilter = CuisineType.setOfAll,
    this.prayerRoomFilter = false,
    this.orderBy = OrderBy.none,
    this.hasReachedMax = false,
  });

  final CateringOverviewStatus status;
  final List<CompanyBranch> caterings;
  final Set<FoodPointType> foodPointTypeFilter;
  final Set<CuisineType> cuisineTypeFilter;
  final bool prayerRoomFilter;
  final OrderBy orderBy;
  final bool hasReachedMax;

  List<CompanyBranch> get filteredCaterings {
    return caterings.where((element) {
      return foodPointTypeFilter.contains(element.foodPointType) &&
          cuisineTypeFilter.contains(element.cuisineType) &&
          (prayerRoomFilter == element.isPrayerRoomExist || !prayerRoomFilter);
    }).toList()
      ..sort(orderBy.cateringsCompareTo);
  }

  CateringState copyWith({
    CateringOverviewStatus? status,
    List<CompanyBranch>? caterings,
    Set<FoodPointType>? foodPointTypeFilter,
    Set<CuisineType>? cuisineTypeFilter,
    bool? prayerRoomFilter,
    OrderBy? orderBy,
    bool? hasReachedMax,
  }) {
    return CateringState(
      status: status ?? this.status,
      caterings: caterings ?? this.caterings,
      foodPointTypeFilter: foodPointTypeFilter ?? this.foodPointTypeFilter,
      cuisineTypeFilter: cuisineTypeFilter ?? this.cuisineTypeFilter,
      prayerRoomFilter: prayerRoomFilter ?? this.prayerRoomFilter,
      orderBy: orderBy ?? this.orderBy,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
        status,
        caterings,
        orderBy,
        hasReachedMax,
        foodPointTypeFilter,
        cuisineTypeFilter,
        prayerRoomFilter,
      ];
}

enum CateringOverviewStatus {
  initial,
  loading,
  success,
  failure,
}
