import 'package:equatable/equatable.dart';

class GetCommentsModel extends Equatable {
  final int id;
  final String? profilePicture;
  final int userId;
  final String content;
  final String userName;

  const GetCommentsModel({
    required this.id,
    this.profilePicture,
    required this.userId,
    required this.content,
    required this.userName,
  });

  factory GetCommentsModel.fromJson(Map<String, dynamic> json) {
    return GetCommentsModel(
      id: json['id'] as int,
      profilePicture: json['profilePicture'] as String?,
      userId: json['userId'] as int,
      content: json['content'] as String,
      userName: json['userName'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'profilePicture': profilePicture,
        'userId': userId,
        'content': content,
        'userName': userName,
      };

  @override
  List<Object?> get props {
    return [
      id,
      profilePicture,
      userId,
      content,
      userName,
    ];
  }
}
