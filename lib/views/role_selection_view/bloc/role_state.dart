part of 'role_bloc.dart';

@immutable
sealed class RoleState {}

final class RoleInitial extends RoleState {}

class RoleNavigateToHomePageState extends RoleState {
  final String userRole;

  RoleNavigateToHomePageState({required this.userRole});
}
