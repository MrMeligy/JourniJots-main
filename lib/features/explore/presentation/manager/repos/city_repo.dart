import 'package:dartz/dartz.dart';
import 'package:journijots/features/explore/data/activities_model/activity_model.dart';

abstract class CityRepo {
  Future<Either<String, List<ActivityModel>>> getCityActivity(
      {required String city});
}
