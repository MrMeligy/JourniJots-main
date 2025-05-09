import 'package:dartz/dartz.dart';
import 'package:journijots/features/actions/data/models/create_post_model.dart';

abstract class CreatePostRepo {
  Future<Either<String, CreatePostModel>> addPost(
      {required String post, required String category});
  Future<String> classifyPost({required String post});
  Future<void> updatePost({required int postId, required String category});
}
