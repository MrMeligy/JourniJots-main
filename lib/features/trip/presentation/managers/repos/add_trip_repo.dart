import 'package:dartz/dartz.dart';
import 'package:journijots/features/trip/data/trip_model.dart';

abstract class AddTripRepo {
  Future<Either<String, TripModel>> addTrip(
      {required String city, required String date});
}
