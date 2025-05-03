import 'package:dartz/dartz.dart';
import 'package:journijots/features/explore/data/near_by_place_model/near_by_place_model.dart';

abstract class NearbyPlacesRepo {
  Future<Either<String, List<NearByPlaceModel>>> nearbyPlaces(
      {required String city});
}
