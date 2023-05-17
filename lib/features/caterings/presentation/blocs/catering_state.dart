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
    this.searchString = '',
  });

  final CateringOverviewStatus status;
  final List<CompanyBranch> caterings;
  final Set<FoodPointType> foodPointTypeFilter;
  final Set<CuisineType> cuisineTypeFilter;
  final bool prayerRoomFilter;
  final OrderBy orderBy;
  final bool hasReachedMax;
  final String searchString;

  List<CompanyBranch> get filteredCaterings {
    // var filtered = <CompanyBranch>[];
    // for (int i = 0; i < caterings.length; ++i) {
    //   if (foodPointTypeFilter.contains(caterings[i].foodPointType)
    //   && cuisineTypeFilter.contains(caterings[i].cuisineType)) {
    //     filtered.add(caterings[i]);
    //   }
    // }
    // if (orderBy != OrderBy.none)
    //   filtered.sort(orderBy.cateringsCompareTo);
    // return filtered;
    var filtered = caterings.where((element) {
      return foodPointTypeFilter.contains(element.foodPointType) &&
          cuisineTypeFilter.contains(element.cuisineType) &&
          (prayerRoomFilter == element.isPrayerRoomExist || !prayerRoomFilter);
    }).toList();
    if (orderBy != OrderBy.none)
       filtered.sort(orderBy.cateringsCompareTo);
    return filtered;
  }

  CateringState copyWith({
    CateringOverviewStatus? status,
    List<CompanyBranch>? caterings,
    Set<FoodPointType>? foodPointTypeFilter,
    Set<CuisineType>? cuisineTypeFilter,
    bool? prayerRoomFilter,
    OrderBy? orderBy,
    bool? hasReachedMax,
    String? searchString,
  }) {
    return CateringState(
      status: status ?? this.status,
      caterings: caterings ?? this.caterings,
      foodPointTypeFilter: foodPointTypeFilter ?? this.foodPointTypeFilter,
      cuisineTypeFilter: cuisineTypeFilter ?? this.cuisineTypeFilter,
      prayerRoomFilter: prayerRoomFilter ?? this.prayerRoomFilter,
      orderBy: orderBy ?? this.orderBy,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchString: searchString ?? this.searchString,
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
        searchString,
      ];
}

enum CateringOverviewStatus {
  initial,
  loading,
  success,
  failure,
}
