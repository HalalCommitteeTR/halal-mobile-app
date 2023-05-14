import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';

import 'package:halal_mobile_app/features/items_overview/domain/entities/items_view_filter.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';

import 'package:halal_mobile_app/features/items_overview/domain/repositories/item_repository.dart';

import '../../domain/entities/order_by.dart';
import '../../domain/entities/permissiveness_filter.dart';

part 'items_overview_event.dart';

part 'items_overview_state.dart';

class ItemsOverviewBloc extends Bloc<ItemsOverviewEvent, ItemsOverviewState> {
  ItemsOverviewBloc({required this.itemRepository})
      : super(const ItemsOverviewState()) {
    on<ItemsOverviewSubscriptionRequested>(
      _onItemsOverviewSubscriptionRequested,
    );
    on<ItemsOverviewFilterChanged>(_onItemsOverviewFilterChanged);
  }

  final ItemRepository itemRepository;

  Future<void> _onItemsOverviewSubscriptionRequested(
    ItemsOverviewSubscriptionRequested event,
    Emitter<ItemsOverviewState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ItemsOverviewStatus.loading) return;
      if (state.status == ItemsOverviewStatus.initial) {
        final items = await itemRepository.getItems();
        return emit(
          state.copyWith(
            status: ItemsOverviewStatus.success,
            items: items,
            hasReachedMax: false,
          ),
        );
      }
      emit(state.copyWith(status: ItemsOverviewStatus.loading));
      final items = await itemRepository.getItems(offset: state.items.length);
      items.isEmpty
          ? emit(state.copyWith(
              hasReachedMax: true,
              status: ItemsOverviewStatus.success,
            ))
          : emit(
              state.copyWith(
                status: ItemsOverviewStatus.success,
                items: List.of(state.items)..addAll(items),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: ItemsOverviewStatus.failure));
    }
  }

  void _onItemsOverviewFilterChanged(
    ItemsOverviewFilterChanged event,
    Emitter<ItemsOverviewState> emit,
  ) {
    emit(state.copyWith(
      filter: event.filter,
      permissivenessFilter: event.permissivenessFilter,
      orderBy: event.orderBy,
    ));
  }
}
