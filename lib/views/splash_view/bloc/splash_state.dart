part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

class SplashNavigateToHomePageActionState extends SplashState {
  final String userRole;

  SplashNavigateToHomePageActionState({required this.userRole});
}

class SplashNavigateToRolePageActionState extends SplashState {}
