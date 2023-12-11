import 'package:flutter_bloc/flutter_bloc.dart';
import 'secondPageEvent.dart';
import 'secondPageState.dart';

class SecondPageBloc extends Bloc<SecondPageEvent, SecondPageState> {
  SecondPageBloc() : super(SecondPageInitialState());

  @override
  Stream<SecondPageState> mapEventToState(SecondPageEvent event) async{
    if (event is BackButtonPressedEvent) {
      return SecondPageLoadedState();
    }
    return state;
  }
}