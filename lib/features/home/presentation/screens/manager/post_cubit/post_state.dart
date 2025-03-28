part of 'post_cubit.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

final class GetPostsLoading extends PostState {}

final class GetPostsSuccessfully extends PostState {
  final List<Post> posts;

  const GetPostsSuccessfully({required this.posts});
}

final class GetPostsFailure extends PostState {
  final String errMessag;

  const GetPostsFailure({required this.errMessag});
}

final class ToggleLikeSuccessfully extends PostState {
  final bool like;

  const ToggleLikeSuccessfully({required this.like});
}

final class ToggleLikeFailure extends PostState {
  final String errMessag;

  const ToggleLikeFailure({required this.errMessag});
}
