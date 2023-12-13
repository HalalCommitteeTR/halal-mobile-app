import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';

import '../../data/repositories/firebase_item_repository.dart';
import 'items_overview_bloc.dart';

class ItemsOverviewStreamBloc
    extends Bloc<ItemsOverviewEvent, ItemsOverviewState> {
  ItemsOverviewStreamBloc({required this.itemRepository})
      : super(const ItemsOverviewState()) {
    on<ItemsOverviewFilterChanged>(_onItemsOverviewFilterChanged);
    on<ItemsSearchCompleted>(_onItemsSearchCompleted);
    on<ItemsOverviewDataUpdated>(_onItemsOverviewDataUpdated);
    on<ItemsOverviewStartListening>(startListening);
  }

  final FirebaseItemRepository itemRepository;
  StreamSubscription<List<Item>>? itemsSubscription;

  void startListening(
    ItemsOverviewStartListening event,
    Emitter<ItemsOverviewState> emit,
  ) {
    emit(
      state.copyWith(
        status: ItemsOverviewStatus.loading,
      ),
    );
    itemsSubscription?.cancel();
    itemsSubscription = itemRepository.getItemsStream().listen(
      (event) {
        add(
          ItemsOverviewDataUpdated(
            items: event,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    itemsSubscription?.cancel();
    super.close();
  }

  void _onItemsOverviewDataUpdated(
    ItemsOverviewDataUpdated event,
    Emitter<ItemsOverviewState> emit,
  ) {
    emit(
      state.copyWith(
        items: event.items,
        status: ItemsOverviewStatus.success,
      ),
    );
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

  void _onItemsSearchCompleted(
    ItemsSearchCompleted event,
    Emitter<ItemsOverviewState> emit,
  ) {
    emit(
      state.copyWith(
        searchString: event.searchString,
        status: ItemsOverviewStatus.initial,
        hasReachedMax: false,
        items: [],
      ),
    );
  }
}
