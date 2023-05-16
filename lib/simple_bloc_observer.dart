import 'package:bloc/bloc.dart';
import 'package:halal_mobile_app/logger/logger.dart';

class SimpleBlocObserver extends BlocObserver {
  SimpleBlocObserver();

  @override
  void onTransition(
      Bloc bloc,
      Transition transition,
      ) {
    super.onTransition(bloc, transition);
    logger.v(transition.event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e(error, error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}