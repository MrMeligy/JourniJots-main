import 'package:dartz/dartz.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';

abstract class CityRepo {
  Future<Either<String, List<PlaceModel>>> getCityActivity(
      {required String city});
  Future<Either<String, List<PlaceModel>>> getCityRestaurants(
      {required String city});
  Future<Either<String, List<PlaceModel>>> getCityHotels(
      {required String city});
}
