part of 'role_bloc.dart';

@immutable
sealed class RoleEvent {}

class RoleSelectedBtnClickedEvent extends RoleEvent {
  final String userRole;

  RoleSelectedBtnClickedEvent({required this.userRole});
}
