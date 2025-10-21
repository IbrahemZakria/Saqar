import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_bottom_navigation_event.dart';
part 'main_bottom_navigation_state.dart';

class MainBottomNavigationBloc extends Bloc<MainBottomNavigationEvent, MainBottomNavigationState> {
  MainBottomNavigationBloc() : super(MainBottomNavigationInitial()) {
    on<MainBottomNavigationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
