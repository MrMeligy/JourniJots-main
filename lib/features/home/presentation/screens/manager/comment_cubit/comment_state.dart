part of 'comment_cubit.dart';

sealed class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

final class GetCommentsLoading extends CommentState {}

final class GetCommentsSuccess extends CommentState {
  final List<GetCommentsModel> comments;

  const GetCommentsSuccess({required this.comments});
}

final class GetCommentsFailure extends CommentState {
  final String errMessag;

  const GetCommentsFailure({required this.errMessag});
}

final class PostCommentsLoading extends CommentState {}

final class PostCommentsSuccess extends CommentState {
  final PostCommentModel comment;

  const PostCommentsSuccess({required this.comment});
}

final class PostCommentsFailure extends CommentState {
  final String errMessag;

  const PostCommentsFailure({required this.errMessag});
}
