import 'package:dartz/dartz.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';

abstract class PlaceRepo {
  Future<Either<String, PlaceModel>> getPlace(int placeId);
}
