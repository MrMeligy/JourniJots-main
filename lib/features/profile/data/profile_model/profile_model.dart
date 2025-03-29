import 'package:equatable/equatable.dart';

import 'post.dart';
import 'trip.dart';

class ProfileModel extends Equatable {
  final int userId;
  final String? userName;
  final String? profilePicture;
  final List<Post>? posts;
  final List<dynamic>? interests;
  final List<Trip>? trips;

  const ProfileModel({
    required this.userId,
    this.userName,
    this.profilePicture,
    this.posts,
    this.interests,
    this.trips,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        userId: json['userId'] as int,
        userName: json['userName'] as String?,
        profilePicture: json['profilePicture'] as String?,
        posts: (json['posts'] as List<dynamic>?)
            ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
            .toList(),
        interests: json['interests'] as List<dynamic>?,
        trips: (json['trips'] as List<dynamic>?)
            ?.map((e) => Trip.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userName': userName,
        'profilePicture': profilePicture,
        'posts': posts?.map((e) => e.toJson()).toList(),
        'interests': interests,
        'trips': trips?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      userId,
      userName,
      profilePicture,
      posts,
      interests,
      trips,
    ];
  }
}
