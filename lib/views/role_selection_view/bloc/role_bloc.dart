import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vigaet/db/shared_prefs/shared_prefs.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final prefs = SharedPrefs();
  RoleBloc() : super(RoleInitial()) {
    on<RoleSelectedBtnClickedEvent>(roleSelectedBtnClickedEvent);
  }

  FutureOr<void> roleSelectedBtnClickedEvent(
      RoleSelectedBtnClickedEvent event, Emitter<RoleState> emit) async {
    await prefs.setUserRole(event.userRole);
    emit(RoleNavigateToHomePageState(userRole: event.userRole));
  }
}
