import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/features/home/data/post_model/paginaton_post_model/post.dart';
// import 'package:journijots/features/home/data/post_model/post_model.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/post_repo/post_repo.dart';

class PostRepoImpl extends PostRepo {
  final ApiConsumer api;

  PostRepoImpl({required this.api});
  @override
  Future<Either<String, List<Post>>> getPosts() async {
    try {
      String? lastPostDate = getIt<CacheHelper>().getData(key: 'lastPostDate');
      var response =
          await api.get(EndPoint.getPostsEndPoint(lastPostDate: lastPostDate));
      final List<Post> posts = (response['posts'] as List)
          .map((item) => Post.fromJson(item))
          .toList();
      getIt<CacheHelper>()
          .saveData(key: 'lastPostDate', value: response['lastPostDate']);
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
