import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String? message;
  final String? city;
  final String? token;

  const AuthModel({this.message, this.token, this.city});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        message: json['message'] as String?,
        token: json['token'] as String?,
        city: json['city'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'token': token,
        'city': city,
      };

  @override
  List<Object?> get props => [message, token, city];
}
