import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halal_mobile_app/api/api.dart';
import 'package:halal_mobile_app/features/items_overview/models/permissiveness_filter.dart';
import 'package:halal_mobile_app/repositories/item_repository.dart';

import 'package:halal_mobile_app/api/models/item/Item.dart';
import 'package:halal_mobile_app/features/items_overview/models/items_filter_view.dart';

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
      // emit(state.copyWith(status: () => ItemsOverviewStatus.loading));

      if (state.status == ItemsOverviewStatus.initial) {
        // emit(state.copyWith(status: () => ItemsOverviewStatus.loading));
        final items = await itemRepository.getItems();
        return emit(
          state.copyWith(
            status: () => ItemsOverviewStatus.success,
            items: () => items,
            hasReachedMax: () => false,
          ),
        );
      }
      emit(state.copyWith(status: () => ItemsOverviewStatus.loading));
      final items = await itemRepository.getItems(offset: state.items.length);
      items.isEmpty
          ? emit(state.copyWith(
              hasReachedMax: () => true,
              status: () => ItemsOverviewStatus.success,
            ))
          : emit(
              state.copyWith(
                status: () => ItemsOverviewStatus.success,
                items: () => List.of(state.items)..addAll(items),
                hasReachedMax: () => false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: () => ItemsOverviewStatus.failure));
    }
  }

  void _onItemsOverviewFilterChanged(
    ItemsOverviewFilterChanged event,
    Emitter<ItemsOverviewState> emit,
  ) {
    emit(state.copyWith(filter: () => event.filter));
  }
}
