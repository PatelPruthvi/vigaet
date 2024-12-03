// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

// @immutable
// sealed class HomeEvent {}

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialEvent extends HomeEvent {}

class HomeLogoutBtnPressedEvent extends HomeEvent {}

class HomeVideoClickedEvent extends HomeEvent {}

class HomeVideoPlayPauseBtnClickedEvent extends HomeEvent {}

class HomeVideoLongPressEvent extends HomeEvent {}

class HomeNewCommentAddedEvent extends HomeEvent {
  final double videoTimestamp;
  HomeNewCommentAddedEvent({required this.videoTimestamp});
}

class HomeVideoSeekPressEvent extends HomeEvent {
  final double position;

  HomeVideoSeekPressEvent({required this.position});

  @override
  List<Object?> get props => [position];
}

class HomeVideoSeekbarUpdatedEvent extends HomeEvent {}

class HomeVideoEndedEvent extends HomeEvent {}
