import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/features/explore/data/place_model/paggination_place.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';
import 'package:journijots/features/explore/presentation/manager/repos/city/city_repo.dart';

class CityRepoImpl extends CityRepo {
  final ApiConsumer api;

  CityRepoImpl({required this.api});
  @override
  Future<Either<String, Tuple2<List<PlaceModel>, PagginationPlace>>>
      getCityActivity({required String city, required String num}) async {
    try {
      var response = await api.get(
        EndPoint.getCityActivities(city: city, pageNum: num),
      );
      final pagginationResponse = PagginationPlace.fromJson(response);
      final List<PlaceModel> activities = (response['data'] as List)
          .map((item) => PlaceModel.fromJson(item))
          .toList();

      return right(
        Tuple2(activities, pagginationResponse),
      );
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }

  @override
  Future<Either<String, Tuple2<List<PlaceModel>, PagginationPlace>>>
      getCityRestaurants({required String city, required String num}) async {
    try {
      var response = await api.get(
        EndPoint.getCityRestaurants(city: city, pageNum: num),
      );
      final pagginationResponse = PagginationPlace.fromJson(response);
      final List<PlaceModel> restaurants = (response['data'] as List)
          .map((item) => PlaceModel.fromJson(item))
          .toList();

      return right(
        Tuple2(restaurants, pagginationResponse),
      );
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }

  @override
  Future<Either<String, Tuple2<List<PlaceModel>, PagginationPlace>>>
      getCityHotels({required String city, required String num}) async {
    try {
      var response = await api.get(
        EndPoint.getCityHotels(city: city, pageNum: num),
      );
      final pagginationResponse = PagginationPlace.fromJson(response);
      final List<PlaceModel> hotels = (response['data'] as List)
          .map((item) => PlaceModel.fromJson(item))
          .toList();

      return right(
        Tuple2(hotels, pagginationResponse),
      );
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }
}
