import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/core/services/cloudinary_service.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/features/interests/data/models/interests_model/interests_model.dart';
import 'package:journijots/features/interests/data/models/profile_picture_response/profile_picture_response.dart';
import 'package:journijots/features/interests/presentation/manager/repos/customize_user_repo.dart';

class CustomizeUserRepoImpl extends CustomizeUserRepo {
  final ApiConsumer api;

  CustomizeUserRepoImpl({required this.api});
  @override
  Future<Either<String, ProfilePictureResponse>> uploadProfilePicture({
    required String imagePath,
  }) async {
    try {
      // Create FormData with the image
      var profilePicUrl =
          await CloudinaryService(dio: getIt<Dio>(), profilePic: imagePath)
              .uploadProfilePic();
      if (profilePicUrl == null) {
        return left("Please choose Picture");
      }
      final response =
          await api.post(EndPoint.uploadProfilePic(profilePic: profilePicUrl));
      // Parse and return the response
      final profilePicResponse = ProfilePictureResponse.fromJson(response);
      return right(profilePicResponse);
    } on ServerException catch (e) {
      return left(e.errModel.errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, InterestsModel>> addIntersts(
      {required List<String> interests}) async {
    try {
      final response =
          await api.post(EndPoint.addInterests, data: {"intersts": interests});
      final InterestsModel interestsModel = InterestsModel.fromJson(response);
      return right(interestsModel);
    } on ServerException catch (e) {
      return left(e.errModel.errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }
}
