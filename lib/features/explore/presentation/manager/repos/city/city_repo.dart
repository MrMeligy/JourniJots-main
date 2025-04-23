import 'package:dartz/dartz.dart';
import 'package:journijots/features/explore/data/place_model/paggination_place.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';

abstract class CityRepo {
  Future<Either<String, Tuple2<List<PlaceModel>, PagginationPlace>>>
      getCityActivity({required String city, required String num});
  Future<Either<String, Tuple2<List<PlaceModel>, PagginationPlace>>>
      getCityRestaurants({required String city, required String num});
  Future<Either<String, Tuple2<List<PlaceModel>, PagginationPlace>>>
      getCityHotels({required String city, required String num});
}
