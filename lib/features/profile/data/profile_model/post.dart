import 'package:equatable/equatable.dart';
import 'package:journijots/features/home/data/post_model/post_image.dart';

class Post extends Equatable {
  final int? postId;
  final String? post;
  final int? likeCount;
  final int? commentCount;
  final DateTime? createdAt;
  final bool? isLikedByCurrentUser;
  final List<PostImage>? postImages;

  const Post({
    this.postId,
    this.post,
    this.likeCount,
    this.commentCount,
    this.createdAt,
    this.isLikedByCurrentUser,
    this.postImages,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        postId: json['postId'] as int?,
        post: json['post'] as String?,
        likeCount: json['likeCount'] as int?,
        commentCount: json['commentCount'] as int?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        isLikedByCurrentUser: json['isLikedByCurrentUser'] as bool?,
        postImages: (json['postImages'] as List<dynamic>?)
            ?.map((e) => PostImage.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'post': post,
        'likeCount': likeCount,
        'commentCount': commentCount,
        'createdAt': createdAt?.toIso8601String(),
        'isLikedByCurrentUser': isLikedByCurrentUser,
        'postImages': postImages?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
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
