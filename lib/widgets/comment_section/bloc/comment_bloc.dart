import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vigaet/db/local/demo_data.dart';

import '../../../models/video_model.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<CommentInitialEvent>(commentInitialEvent);
  }

  FutureOr<void> commentInitialEvent(
      CommentInitialEvent event, Emitter<CommentState> emit) {
    VideoModel videoModel = VideoModel.fromJson(videoDetails);
    List<Comments> comments = [];
    comments.addAll(videoModel.details?.comments ?? []);
    comments.sort((a, b) {
      return (a.videoTimestamp?.compareTo(b.videoTimestamp ?? 0)) ?? 0;
    });
    emit(CommentsLoadedSuccessState(comment: comments));
  }
}
