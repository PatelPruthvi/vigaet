part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

class CommentsLoadedSuccessState extends CommentState {
  final List<Comments> comment;

  const CommentsLoadedSuccessState({required this.comment});
  @override
  List<Object> get props => [comment];
}
