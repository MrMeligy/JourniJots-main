import 'package:equatable/equatable.dart';

import 'post.dart';

class PaginatonPostModel extends Equatable {
  final List<Post>? posts;
  final String lastPostDate;

  const PaginatonPostModel({this.posts, required this.lastPostDate});

  factory PaginatonPostModel.fromJson(Map<String, dynamic> json) {
    return PaginatonPostModel(
        posts: (json['posts'] as List<dynamic>?)
            ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
            .toList(),
        lastPostDate: json['lastPostDate']);
  }

  Map<String, dynamic> toJson() => {
        'posts': posts?.map((e) => e.toJson()).toList(),
        'lastPostDate': lastPostDate,
      };

  @override
  List<Object?> get props => [posts, lastPostDate];
}
