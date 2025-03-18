class PostModel {
  String? userName;
  int? postId;
  String? post;
  int? likeCount;
  int? commentCount;
  List<dynamic>? postImages;

  PostModel({
    this.userName,
    this.postId,
    this.post,
    this.likeCount,
    this.commentCount,
    this.postImages,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userName: json['userName'] as String?,
        postId: json['postId'] as int?,
        post: json['post'] as String?,
        likeCount: json['likeCount'] as int?,
        commentCount: json['commentCount'] as int?,
        postImages: json['postImages'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'postId': postId,
        'post': post,
        'likeCount': likeCount,
        'commentCount': commentCount,
        'postImages': postImages,
      };
}
