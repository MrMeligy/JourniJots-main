import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String? message;
  final String? token;

  const AuthModel({this.message, this.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        message: json['message'] as String?,
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'token': token,
      };

  @override
  List<Object?> get props => [message, token];
}
