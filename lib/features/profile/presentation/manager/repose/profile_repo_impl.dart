import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/features/profile/data/profile_model/profile_model.dart';
import 'package:journijots/features/profile/presentation/manager/repose/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ApiConsumer api;

  ProfileRepoImpl({required this.api});
  @override
  Future<Either<String, ProfileModel>> getPosts({required String id}) async {
    try {
      var response = await api.get(EndPoint.getProfileEndPoint(id: id));
      final ProfileModel profile = ProfileModel.fromJson(response);
      return (right(profile));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }

  @override
  Future<String> postFollow({required String userId}) async {
    try {
      var response = await api.post(EndPoint.postFollow(userId: userId));
      final String message = response;
      return message;
    } on ServerException catch (e) {
      return (e.errModel.errorMessage);
    }
  }
}
