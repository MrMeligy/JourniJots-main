part of 'follow_cubit.dart';

sealed class FollowState extends Equatable {
  const FollowState();

  @override
  List<Object> get props => [];
}

final class FollowInitial extends FollowState {}

final class FollowLoading extends FollowState {}

final class FollowSuccess extends FollowState {
  final String successMessage;

  const FollowSuccess({required this.successMessage});
}

final class UnFollowSuccess extends FollowState {
  final String successMessage;

  const UnFollowSuccess({required this.successMessage});
}

final class FollowFailure extends FollowState {
  final String errMessage;

  const FollowFailure({required this.errMessage});
}
