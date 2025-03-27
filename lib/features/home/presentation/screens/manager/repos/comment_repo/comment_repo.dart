import 'package:dartz/dartz.dart';
import 'package:journijots/features/home/data/comment_model/get_comments_model/get_comments_model.dart';
import 'package:journijots/features/home/data/comment_model/post_comment_model.dart';

abstract class CommentRepo {
  Future<Either<String, PostCommentModel>> postComment({required int postId});
  Future<Either<String, List<GetCommentsModel>>> getComments(
      {required int postId});
}
