
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

enum HomeTab { composition, venues, lectures, prayerTime }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.composition,
  });

  final HomeTab tab;

  @override
  List<Object?> get props => [tab];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void setTab(HomeTab tab) => emit(HomeState(tab: tab));


}
