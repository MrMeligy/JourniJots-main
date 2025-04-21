import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/features/explore/data/activities_model/activity_model.dart';
import 'package:journijots/features/explore/data/hotel_model/hotel_model.dart';
import 'package:journijots/features/explore/data/restaurant_model/restaurant_model.dart';
import 'package:journijots/features/explore/presentation/manager/repos/city/city_repo.dart';

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

  @override
  Future<Either<String, List<RestaurantModel>>> getCityRestaurants(
      {required String city}) async {
    try {
      var response = await api.get(
        EndPoint.getCityRestaurants(city: city),
      );
      final List<RestaurantModel> restaurants = (response as List)
          .map((item) => RestaurantModel.fromJson(item))
          .toList();
      return (right(restaurants));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }

  @override
  Future<Either<String, List<HotelModel>>> getCityHotels(
      {required String city}) async {
    try {
      var response = await api.get(
        EndPoint.getCityHotels(city: city),
      );
      final List<HotelModel> hotels =
          (response as List).map((item) => HotelModel.fromJson(item)).toList();
      return (right(hotels));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }
}
