import 'package:dartz/dartz.dart';
import 'package:journijots/features/home/data/post_model/post_model.dart';

abstract class PostRepo {
  Future<Either<String, List<PostModel>>> getPosts();
  Future<Either<String, bool>> toggleLike({required int postId});
}
