part of 'customize_user_cubit.dart';

sealed class CustomizeUserState extends Equatable {
  const CustomizeUserState();

  @override
  List<Object> get props => [];
}

final class CustomizeUserInitial extends CustomizeUserState {}

class ProfilePicLocallySet extends CustomizeUserState {}

class ProfilePicUploadLoading extends CustomizeUserState {}

class ProfilePicUploadSuccess extends CustomizeUserState {
  final ProfilePictureResponse response;
  const ProfilePicUploadSuccess({required this.response});
}

class ProfilePicUploadFailure extends CustomizeUserState {
  final String errMessage;
  const ProfilePicUploadFailure({required this.errMessage});
}

final class AddInterestsLoading extends CustomizeUserState {}

final class AddInterestsSuccess extends CustomizeUserState {}

final class AddInterestsFailure extends CustomizeUserState {
  final String errMessage;

  const AddInterestsFailure({required this.errMessage});
}
