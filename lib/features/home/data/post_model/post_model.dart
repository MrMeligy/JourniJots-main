import 'package:equatable/equatable.dart';

import 'post_image.dart';

class PostModel extends Equatable {
  final String? userName;
  final String? profilePicture;
  final DateTime? createdAt;
  final int? postId;
  final String? post;
  final int? likeCount;
  final int? commentCount;
  final bool? isLikedByCurrentUser;
  final List<PostImage>? postImages;

  const PostModel({
    this.userName,
    this.profilePicture,
    this.createdAt,
    this.postId,
    this.post,
    this.likeCount,
    this.commentCount,
    this.isLikedByCurrentUser,
    this.postImages,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userName: json['userName'] as String?,
        profilePicture: json['profilePicture'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        postId: json['postId'] as int?,
        post: json['post'] as String?,
        likeCount: json['likeCount'] as int?,
        commentCount: json['commentCount'] as int?,
        isLikedByCurrentUser: json['isLikedByCurrentUser'] as bool?,
        postImages: (json['postImages'] as List<dynamic>?)
            ?.map((e) => PostImage.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'profilePicture': profilePicture,
        'createdAt': createdAt?.toIso8601String(),
        'postId': postId,
        'post': post,
        'likeCount': likeCount,
        'commentCount': commentCount,
        'isLikedByCurrentUser': isLikedByCurrentUser,
        'postImages': postImages?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
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
