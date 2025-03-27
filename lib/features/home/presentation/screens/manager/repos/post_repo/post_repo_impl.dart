import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/features/home/data/post_model/post_model.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/post_repo/post_repo.dart';

class PostRepoImpl extends PostRepo {
  final ApiConsumer api;

  PostRepoImpl({required this.api});
  @override
  Future<Either<String, List<PostModel>>> getPosts() async {
    try {
      var response = await api.get(EndPoint.getPosts);
      final List<PostModel> posts =
          (response as List).map((item) => PostModel.fromJson(item)).toList();
      return (right(posts));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }

  @override
  Future<Either<String, bool>> toggleLike({required int postId}) async {
    try {
      bool response = await api.post(EndPoint.toggleLike + postId.toString());
      return (right(response));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }
}
