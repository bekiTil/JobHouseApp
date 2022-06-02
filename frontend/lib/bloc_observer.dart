import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print('onEvent $event');
    super.onEvent(bloc, event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    print('onTransition $transition');
    super.onTransition(bloc, transition);
  }

  
  @override
  void onClose(Bloc bloc, Close close) {
    super.onClose(bloc);
    print('onClose -- $close');
  }
  @override
  void onChange(Bloc bloc, Change change) {
    super.onChange(bloc, change);
    print('onChnage $change');
  }
 
  
}
