import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/utils/log/logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    Log.i('[AppBlocObserver][onEvent] ${bloc.runtimeType} event: ${event.runtimeType} ');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Log.i(
        '[AppBlocObserver][onTrans] ${bloc.runtimeType} event: ${transition.event.runtimeType} state: ${transition.currentState.runtimeType} -> ${transition.nextState.runtimeType}');
  }
}
