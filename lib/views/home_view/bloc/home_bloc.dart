import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';
import 'package:vigaet/db/local/demo_data.dart';
import 'package:vigaet/db/shared_prefs/shared_prefs.dart';

import '../../../models/video_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  VideoPlayerController controller = VideoPlayerController.contentUri(
    Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"),
  );

  HomeBloc() : super(HomeInitial()) {
    on<HomeLogoutBtnPressedEvent>(homeLogoutBtnPressedEvent);
    on<HomeVideoClickedEvent>(homeVideoClickedEvent);
    on<HomeVideoPlayPauseBtnClickedEvent>(homeVideoPlayPauseBtnClickedEvent);
    on<HomeInitialEvent>(onHomeInitialEvent);
    on<HomeVideoSeekPressEvent>(homeVideoSeekPressEvent);
    on<HomeVideoSeekbarUpdatedEvent>(homeVideoSeekbarUpdatedEvent);
    on<HomeVideoEndedEvent>(homeVideoEndedEvent);
    on<HomeNewCommentAddedEvent>(homeNewCommentAddedEvent);
  }

  FutureOr<void> homeLogoutBtnPressedEvent(
      HomeLogoutBtnPressedEvent event, Emitter<HomeState> emit) async {
    final prefs = SharedPrefs();
    await prefs.removeUser();
    emit(HomeNavigateToRoleActionState());
  }

  FutureOr<void> homeVideoClickedEvent(
      HomeVideoClickedEvent event, Emitter<HomeState> emit) async {
    emit((state as HomeVideoControlUpdatedState)
        .copyWith(isControlsVisible: true));

    await Future.delayed(const Duration(seconds: 5), () {
      emit((state as HomeVideoControlUpdatedState)
          .copyWith(isControlsVisible: false));
    });
  }

  FutureOr<void> homeVideoPlayPauseBtnClickedEvent(
      HomeVideoPlayPauseBtnClickedEvent event, Emitter<HomeState> emit) {
    if (controller.value.isPlaying) {
      controller.pause();
      emit((state as HomeVideoControlUpdatedState).copyWith(isPlaying: false));
    } else {
      controller.play();
      emit((state as HomeVideoControlUpdatedState).copyWith(isPlaying: true));
    }
  }

  FutureOr<void> onHomeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitial());
    List<Comments> comments = [];
    List<double> markers = [];
    videoDetails['details']['comments'].forEach((comment) {
      comments.add(Comments.fromJson(comment));
    });
    for (var comm in comments) {
      markers.add(comm.videoTimestamp!);
    }
    await controller.initialize().then((val) {
      controller.play();
      emit(HomeVideoControlUpdatedState(
          isControlsVisible: false,
          isPlaying: true,
          currentPosition: 0,
          duration: controller.value.duration,
          controller: controller,
          markers: markers));
      add(HomeVideoClickedEvent());
    });
  }

  FutureOr<void> homeVideoSeekPressEvent(
      HomeVideoSeekPressEvent event, Emitter<HomeState> emit) {
    controller.seekTo(Duration(seconds: event.position.toInt()));

    emit((state as HomeVideoControlUpdatedState).copyWith(
      currentPosition: event.position.toInt().toDouble(),
    ));
  }

  FutureOr<void> homeVideoSeekbarUpdatedEvent(
      HomeVideoSeekbarUpdatedEvent event, Emitter<HomeState> emit) {
    emit((state as HomeVideoControlUpdatedState).copyWith(
        currentPosition: controller.value.position.inSeconds.toDouble()));
  }

  FutureOr<void> homeVideoEndedEvent(
      HomeVideoEndedEvent event, Emitter<HomeState> emit) {
    emit((state as HomeVideoControlUpdatedState)
        .copyWith(isPlaying: false, currentPosition: 0.0));
  }

  FutureOr<void> homeNewCommentAddedEvent(
      HomeNewCommentAddedEvent event, Emitter<HomeState> emit) {
    List<double> markers = (state as HomeVideoControlUpdatedState).markers;
    markers.add(event.videoTimestamp);
    emit((state as HomeVideoControlUpdatedState).copyWith(markers: markers));
  }

  @override
  Future<void> close() {
    controller.removeListener(() {});
    return super.close();
  }
}
