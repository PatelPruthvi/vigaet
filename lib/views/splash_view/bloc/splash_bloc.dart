import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vigaet/db/shared_prefs/shared_prefs.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashInitialEvent>(splashInitialEvent);
  }

  FutureOr<void> splashInitialEvent(
      SplashInitialEvent event, Emitter<SplashState> emit) async {
    final prefs = SharedPrefs();
    String? user = await prefs.getUserRole();
    if (user != null) {
      emit(SplashNavigateToHomePageActionState(userRole: user));
    } else {
      emit(SplashNavigateToRolePageActionState());
    }
  }
}
