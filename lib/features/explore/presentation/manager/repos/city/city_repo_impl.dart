import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';
import 'package:journijots/features/explore/presentation/manager/repos/city/city_repo.dart';

class CityRepoImpl extends CityRepo {
  final ApiConsumer api;

  CityRepoImpl({required this.api});
  @override
  Future<Either<String, List<PlaceModel>>> getCityActivity(
      {required String city}) async {
    try {
      var response = await api.get(
        EndPoint.getCityActivities(city: city),
      );
      final List<PlaceModel> activites =
          (response as List).map((item) => PlaceModel.fromJson(item)).toList();
      return (right(activites));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }

  @override
  Future<Either<String, List<PlaceModel>>> getCityRestaurants(
      {required String city}) async {
    try {
      var response = await api.get(
        EndPoint.getCityRestaurants(city: city),
      );
      final List<PlaceModel> restaurants =
          (response as List).map((item) => PlaceModel.fromJson(item)).toList();
      return (right(restaurants));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }

  @override
  Future<Either<String, List<PlaceModel>>> getCityHotels(
      {required String city}) async {
    try {
      var response = await api.get(
        EndPoint.getCityHotels(city: city),
      );
      final List<PlaceModel> hotels =
          (response as List).map((item) => PlaceModel.fromJson(item)).toList();
      return (right(hotels));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }
}
