import 'package:dartz/dartz.dart';
import 'package:journijots/features/profile/data/profile_model/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<String, ProfileModel>> getPosts({required String id});
}
