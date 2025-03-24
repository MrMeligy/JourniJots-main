import 'package:equatable/equatable.dart';

class ProfilePictureResponse extends Equatable {
  final String? profilePic;
  final String? message;

  const ProfilePictureResponse({this.profilePic, this.message});

  factory ProfilePictureResponse.fromJson(Map<String, dynamic> json) {
    return ProfilePictureResponse(
      profilePic: json['profilePic'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'profilePic': profilePic,
        'message': message,
      };

  @override
  List<Object?> get props => [profilePic, message];
}
