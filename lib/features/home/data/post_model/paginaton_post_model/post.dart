import 'package:equatable/equatable.dart';
import 'package:journijots/features/home/data/post_model/post_image.dart';

class Post extends Equatable {
  final String userId;
  final String userName;
  final String? profilePicture;
  final DateTime createdAt;
  final int postId;
  final String post;
  final int likeCount;
  final int commentCount;
  final bool isLikedByCurrentUser;
  final List<PostImage>? postImages;

  const Post({
    required this.userId,
    required this.userName,
    this.profilePicture,
    required this.createdAt,
    required this.postId,
    required this.post,
    required this.likeCount,
    required this.commentCount,
    required this.isLikedByCurrentUser,
    this.postImages,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json['userId'] as String,
        userName: json['userName'] as String,
        profilePicture: json['profilePicture'] as String?,
        createdAt: json['createdAt'] =
            DateTime.parse(json['createdAt'] as String),
        postId: json['postId'] as int,
        post: json['content'] as String,
        likeCount: json['likeCount'] as int,
        commentCount: json['commentCount'] as int,
        isLikedByCurrentUser: json['isLikedByCurrentUser'] as bool,
        postImages: (json['postImages'] as List<dynamic>?)
            ?.map((e) => PostImage.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userName': userName,
        'profilePicture': profilePicture,
        'createdAt': createdAt.toIso8601String(),
        'postId': postId,
        'content': post,
        'likeCount': likeCount,
        'commentCount': commentCount,
        'isLikedByCurrentUser': isLikedByCurrentUser,
        'postImages': postImages?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      userId,
      userName,
      profilePicture,
      createdAt,
      postId,
      post,
      likeCount,
      commentCount,
      isLikedByCurrentUser,
      postImages,
    ];
  }
}
