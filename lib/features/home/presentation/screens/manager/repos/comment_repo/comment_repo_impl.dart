import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/features/home/data/comment_model/get_comments_model/get_comments_model.dart';
import 'package:journijots/features/home/data/comment_model/post_comment_model.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/comment_repo/comment_repo.dart';

class CommentRepoImpl extends CommentRepo {
  final ApiConsumer api;

  CommentRepoImpl({required this.api});
  @override
  Future<Either<String, List<GetCommentsModel>>> getComments(
      {required int postId}) async {
    try {
      var response = await api.get(EndPoint.getComment + postId.toString());
      final List<GetCommentsModel> comments = (response as List)
          .map((item) => GetCommentsModel.fromJson(item))
          .toList();
      return (right(comments));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }

  @override
  Future<Either<String, PostCommentModel>> postComment(
      {required int postId}) async {
    try {
      var response = await api.post(EndPoint.postComment + postId.toString());
      final comment = PostCommentModel.fromJson(response);
      return (right(comment));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }
}
