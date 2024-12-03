part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class HomeActionState extends HomeState {}

class HomeNavigateToRoleActionState extends HomeActionState {}

class HomeInitial extends HomeState {}

class HomeVideoControlUpdatedState extends HomeState {
  final bool isControlsVisible;
  final bool isPlaying;
  final double currentPosition;
  final Duration duration;
  final VideoPlayerController controller;
  final List<double> markers;

  HomeVideoControlUpdatedState(
      {required this.isControlsVisible,
      required this.isPlaying,
      required this.currentPosition,
      required this.duration,
      required this.controller,
      required this.markers});
  HomeVideoControlUpdatedState copyWith(
      {bool? isControlsVisible,
      bool? isPlaying,
      double? currentPosition,
      Duration? duration,
      VideoPlayerController? controller,
      List<double>? markers}) {
    return HomeVideoControlUpdatedState(
        isControlsVisible: isControlsVisible ?? this.isControlsVisible,
        isPlaying: isPlaying ?? this.isPlaying,
        currentPosition: currentPosition ?? this.currentPosition,
        duration: duration ?? this.duration,
        controller: controller ?? this.controller,
        markers: markers ?? this.markers);
  }

  @override
  List<Object?> get props =>
      [isControlsVisible, isPlaying, currentPosition, duration, markers];
}
