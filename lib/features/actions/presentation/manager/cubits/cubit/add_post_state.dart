part of 'add_post_cubit.dart';

sealed class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object> get props => [];
}

final class AddPostInitial extends AddPostState {}

final class AddPostLoading extends AddPostState {}

final class AddPostSuccess extends AddPostState {}

final class AddPostFailure extends AddPostState {
  final String err;

  const AddPostFailure({required this.err});
}
