part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class LogInLoading extends UserState {}

final class LogInSuccess extends UserState {}

final class LogInFailure extends UserState {
  final String errMessag;

  LogInFailure({required this.errMessag});
}

final class SignUpLoading extends UserState {}

final class SignUpSuccess extends UserState {}

final class SignUpFailure extends UserState {
  final String errMessag;

  SignUpFailure({required this.errMessag});
}
