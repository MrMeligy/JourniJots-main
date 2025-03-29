part of 'profile_posts_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final ProfileModel profileModel;

  const ProfileSuccess({required this.profileModel});
}

final class ProfileFailure extends ProfileState {
  final String errMessage;

  const ProfileFailure({required this.errMessage});
}
