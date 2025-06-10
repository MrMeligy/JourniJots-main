import 'package:dartz/dartz.dart';
import 'package:journijots/features/trip/data/trip_places_model/trip_places_model.dart';

abstract class TripPlacesRepo {
  Future<Either<String, TripPlacesModel>> getTripPlaces(int tripId);
}
