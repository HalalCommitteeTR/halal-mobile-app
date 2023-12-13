import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halal_mobile_app/features/caterings/domain/entities/company_branch.dart';
import 'package:halal_mobile_app/features/caterings/domain/repositories/catering_repository.dart';

import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';
import 'package:halal_mobile_app/features/caterings/domain/entities/cuisine_type.dart';
import 'package:halal_mobile_app/features/caterings/domain/entities/food_point_type.dart';

import 'package:halal_mobile_app/logger/logger.dart';

part 'catering_event.dart';

part 'catering_state.dart';

class CateringBloc extends Bloc<CateringEvent, CateringState> {
  CateringBloc({required this.cateringRepository})
      : super(const CateringState()) {
    on<CateringSubscriptionRequested>(_onCateringSubscriptionRequested);
    on<CateringFilterChanged>(_onCateringFilterChanged);
    on<CateringsSearchCompleted>(_onCateringsSearchCompleted);
  }

  final CateringRepository cateringRepository;

  Future<void> _onCateringSubscriptionRequested(
    CateringSubscriptionRequested event,
    Emitter<CateringState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CateringOverviewStatus.loading) return;
      if (state.status == CateringOverviewStatus.initial) {
        final caterings = await cateringRepository.getCaterings(
          like: state.searchString,
        );
        logger.i('Caterings:\n$caterings');
        return emit(
          state.copyWith(
            status: CateringOverviewStatus.success,
            caterings: caterings,
            hasReachedMax: false,
          ),
        );
      }
      emit(state.copyWith(status: CateringOverviewStatus.loading));
      final caterings = await cateringRepository.getCaterings(
        offset: state.caterings.length,
        like: state.searchString,
      );
      caterings.isEmpty
          ? emit(state.copyWith(
              hasReachedMax: true,
              status: CateringOverviewStatus.success,
            ))
          : emit(
              state.copyWith(
                status: CateringOverviewStatus.success,
                caterings: List.of(state.caterings)..addAll(caterings),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: CateringOverviewStatus.failure));
    }
  }

  void _onCateringFilterChanged(
    CateringFilterChanged event,
    Emitter<CateringState> emit,
  ) {
    emit(state.copyWith(
      foodPointTypeFilter: event.foodPointTypeFilter,
      cuisineTypeFilter: event.cuisineTypeFilter,
      prayerRoomFilter: event.prayerRoomFilter,
      orderBy: event.orderBy,
    ));
  }

  void _onCateringsSearchCompleted(
    CateringsSearchCompleted event,
    Emitter<CateringState> emit,
  ) {
    emit(
      state.copyWith(
        searchString: event.searchString,
        status: CateringOverviewStatus.initial,
        hasReachedMax: false,
        caterings: [],
      ),
    );
  }
}
