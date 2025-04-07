import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/features/explore/data/activities_model/activity_model.dart';
import 'package:journijots/features/explore/presentation/manager/repos/city_repo.dart';

class CityRepoImpl extends CityRepo {
  final ApiConsumer api;

  CityRepoImpl({required this.api});
  @override
  Future<Either<String, List<ActivityModel>>> getCityActivity(
      {required String city}) async {
    try {
      var response = await api.get(
        EndPoint.getCityActivities(city: city),
      );
      final List<ActivityModel> activites = (response as List)
          .map((item) => ActivityModel.fromJson(item))
          .toList();
      return (right(activites));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }
}
