import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journijots/features/interests/data/models/interests_model/interests_model.dart';
import 'package:journijots/features/interests/data/models/profile_picture_response/profile_picture_response.dart';

abstract class CustomizeUserRepo {
  Future<Either<String, ProfilePictureResponse>> uploadProfilePicture({
    required XFile image,
  });
  Future<Either<String, InterestsModel>> addIntersts(
      {required List<String> interests});
}
