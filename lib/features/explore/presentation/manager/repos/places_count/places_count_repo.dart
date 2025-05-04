import 'package:dartz/dartz.dart';
import 'package:journijots/features/explore/data/places_count.dart';

abstract class PlacesCountRepo {
  Future<Either<String, PlacesCount>> getPlacesCount({required String city});
}
