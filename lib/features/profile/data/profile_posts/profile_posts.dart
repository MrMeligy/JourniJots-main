import 'package:equatable/equatable.dart';
import 'package:journijots/features/home/data/post_model/post_image.dart';

class ProfilePostModel extends Equatable {
  final String userName;
  final String? profilePicture;
  final int postId;
  final String post;
  final int likeCount;
  final int commentCount;
  final DateTime createdAt;
  final bool isLikedByCurrentUser;
  final List<PostImage>? postImages;

  const ProfilePostModel({
    required this.userName,
    this.profilePicture,
    required this.postId,
    required this.post,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    required this.isLikedByCurrentUser,
    this.postImages,
  });

  factory ProfilePostModel.fromJson(Map<String, dynamic> json) =>
      ProfilePostModel(
        userName: json['userName'] as String,
        profilePicture: json['profilePicture'] as String?,
        postId: json['postId'] as int,
        post: json['post'] as String,
        likeCount: json['likeCount'] as int,
        commentCount: json['commentCount'] as int,
        createdAt: json['createdAt'] =
            DateTime.parse(json['createdAt'] as String),
        isLikedByCurrentUser: json['isLikedByCurrentUser'] as bool,
        postImages: (json['postImages'] as List<dynamic>?)
            ?.map((e) => PostImage.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'profilePicture': profilePicture,
        'postId': postId,
        'post': post,
        'likeCount': likeCount,
        'commentCount': commentCount,
        'createdAt': createdAt.toIso8601String(),
        'isLikedByCurrentUser': isLikedByCurrentUser,
        'postImages': postImages,
      };

  @override
  List<Object?> get props {
    return [
      userName,
      profilePicture,
      postId,
      post,
      likeCount,
      commentCount,
      createdAt,
      isLikedByCurrentUser,
      postImages,
    ];
  }
}
