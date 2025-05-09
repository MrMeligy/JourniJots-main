import 'package:equatable/equatable.dart';

class CreatePostModel extends Equatable {
  final String? userName;
  final int? postId;
  final DateTime? createdAt;
  final String? content;
  final List<dynamic>? images;

  const CreatePostModel({
    this.userName,
    this.postId,
    this.createdAt,
    this.content,
    this.images,
  });

  factory CreatePostModel.fromJson(Map<String, dynamic> json) {
    return CreatePostModel(
      userName: json['userName'] as String?,
      postId: json['postId'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      content: json['content'] as String?,
      images: json['images'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'postId': postId,
        'createdAt': createdAt?.toIso8601String(),
        'content': content,
        'images': images,
      };

  @override
  List<Object?> get props {
    return [
      userName,
      postId,
      createdAt,
      content,
      images,
    ];
  }
}
