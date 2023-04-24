import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halal_mobile_app/repositories/item_repository.dart';

import 'package:halal_mobile_app/api/models/item/Item.dart';
import 'package:halal_mobile_app/features/items_overview/models/items_filter_view.dart';

part 'items_overview_event.dart';

part 'items_overview_state.dart';

class ItemsOverviewBloc extends Bloc<ItemsOverviewEvent, ItemsOverviewState> {
  ItemsOverviewBloc({required this.itemRepository})
      : super(const ItemsOverviewState()) {
    on<ItemsOverviewSubscriptionRequested>(
        _onItemsOverviewSubscriptionRequested);
    on<ItemsOverviewFilterChanged>(_onItemsOverviewFilterChanged);
  }

  final ItemRepository itemRepository;

  Future<void> _onItemsOverviewSubscriptionRequested(
    ItemsOverviewSubscriptionRequested event,
    Emitter<ItemsOverviewState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      // emit(state.copyWith(status: () => ItemsOverviewStatus.loading));

      if (state.status == ItemsOverviewStatus.initial) {
        final items = await itemRepository.getItems();
        return emit(
          state.copyWith(
            status: () => ItemsOverviewStatus.success,
            items: () => items,
            hasReachedMax: () => false,
          ),
        );
      }
      final items = await itemRepository.getItems(offset: state.items.length);
      items.isEmpty
          ? emit(state.copyWith(hasReachedMax: () => true))
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

  Future<void> _onItemsOverviewFilterChanged(
    ItemsOverviewFilterChanged event,
    Emitter<ItemsOverviewState> emit,
  ) async {}
}
