import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/features/actions/data/models/create_post_model.dart';
import 'package:journijots/features/actions/presentation/manager/repos/create_post_repo.dart';

class CreatePostRepoImpl extends CreatePostRepo {
  final ApiConsumer api;

  CreatePostRepoImpl({required this.api});
  @override
  Future<Either<String, CreatePostModel>> addPost(
      {required String post, required String category}) async {
    try {
      var response = await api.post(EndPoint.addPost,
          data: {"content": post, "category": category});
      final postResponse = CreatePostModel.fromJson(response);
      return (right(postResponse));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }

  @override
  Future<String> classifyPost({required String post}) async {
    final url =
        'https://rowa07v--tourist-interest-classifier-fastapi-app.modal.run/classify/';

    final data = {"text": post};
    try {
      var response = await getIt<Dio>().post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      final String category = response.data['category'];
      return category;
    } on ServerException catch (e) {
      return e.errModel.errorMessage;
    }
  }

  @override
  Future<void> updatePost(
      {required int postId, required String category}) async {
    try {
      await api.patch(EndPoint.editPost(postId: postId),
          data: {"category": category});
    } catch (e) {
      // ignore: avoid_print
      print("Failed to add Category");
    }
  }
}
