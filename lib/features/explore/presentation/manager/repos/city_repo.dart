import 'package:dartz/dartz.dart';
import 'package:journijots/features/explore/data/activities_model/activity_model.dart';
import 'package:journijots/features/explore/data/hotel_model/hotel_model.dart';
import 'package:journijots/features/explore/data/restaurant_model/restaurant_model.dart';

abstract class CityRepo {
  Future<Either<String, List<ActivityModel>>> getCityActivity(
      {required String city});
  Future<Either<String, List<RestaurantModel>>> getCityRestaurants(
      {required String city});
  Future<Either<String, List<HotelModel>>> getCityHotels(
      {required String city});
}
