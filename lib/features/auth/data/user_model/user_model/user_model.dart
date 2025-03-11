import 'user.dart';

class UserModel {
  User? user;
  int? followers;

  UserModel({this.user, this.followers});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        followers: json['followers'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'followers': followers,
      };
}
