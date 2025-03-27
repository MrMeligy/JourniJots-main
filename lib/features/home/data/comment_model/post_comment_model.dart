import 'package:equatable/equatable.dart';

class PostCommentModel extends Equatable {
  final int postId;
  final String userName;
  final String? profilePicture;
  final String content;

  const PostCommentModel({
    required this.postId,
    required this.userName,
    this.profilePicture,
    required this.content,
  });

  factory PostCommentModel.fromJson(Map<String, dynamic> json) =>
      PostCommentModel(
        postId: json['postId'] as int,
        userName: json['userName'] as String,
        profilePicture: json['profilePicture'] as String?,
        content: json['content'] as String,
      );

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'userName': userName,
        'profilePicture': profilePicture,
        'content': content,
      };

  @override
  List<Object?> get props => [postId, userName, profilePicture, content];
}
