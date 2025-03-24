import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/features/auth/data/auth_model/auth_model.dart';
import 'package:journijots/features/auth/presentation/manager/repos/user_repo.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserRepoImpl extends UserRepo {
  final ApiConsumer api;
  UserRepoImpl({required this.api});
  @override
  Future<Either<String, AuthModel>> logIn({
    required String logInEmail,
    required String logInPassword,
  }) async {
    try {
      final response = await api.post(EndPoint.logIn, data: {
        ApiKey.email: logInEmail,
        ApiKey.password: logInPassword,
      });

      final user = AuthModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user.token!);
      getIt<CacheHelper>().saveData(key: ApiKey.token, value: user.token);
      getIt<CacheHelper>()
          .saveData(key: ApiKey.id, value: decodedToken[ApiKey.tokenId]);
      return (right(user));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }

  @override
  Future<Either<String, AuthModel>> signUp({
    required String signUpFirstName,
    required String signUpLastName,
    required String signUpUserName,
    required String signUpEmail,
    required String signUpPassword,
  }) async {
    try {
      final response = await api.post(EndPoint.register, data: {
        ApiKey.firstName: signUpFirstName,
        ApiKey.lastName: signUpLastName,
        ApiKey.userName: signUpUserName,
        ApiKey.email: signUpEmail,
        ApiKey.password: signUpPassword,
      });

      final user = AuthModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user.token!);
      getIt<CacheHelper>().saveData(
        key: ApiKey.token,
        value: user.token,
      );
      getIt<CacheHelper>().saveData(
        key: ApiKey.id,
        value: decodedToken[ApiKey.tokenId],
      );
      return (right(user));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }

  // @override
  // Future<Either<String, ProfilePictureResponse>> uploadProfilePicture({
  //   required XFile image,
  // }) async {
  //   try {
  //     // Create FormData with the image
  //     Uint8List imageBytes = await image.readAsBytes();

  //     // إنشاء MultipartFile من Byte Array
  //     final file = MultipartFile.fromBytes(
  //       imageBytes,
  //       filename: image.name,
  //     );

  //     final formData = FormData.fromMap({
  //       'picture': file,
  //     });

  //     final response = await api.post(
  //       EndPoint.uploadProfilePic,
  //       data: formData,
  //       isFromData: true,
  //     );

  //     // Parse and return the response
  //     final profilePicResponse = ProfilePictureResponse.fromJson(response);
  //     return right(profilePicResponse);
  //   } on ServerException catch (e) {
  //     return left(e.errModel.errorMessage);
  //   } catch (e) {
  //     return left(e.toString());
  //   }
  // }
}
