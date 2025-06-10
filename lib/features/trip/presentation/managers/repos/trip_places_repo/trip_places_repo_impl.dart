import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/features/trip/data/trip_places_model/trip_places_model.dart';
import 'package:journijots/features/trip/presentation/managers/repos/trip_places_repo/trip_places_repo.dart';

class TripPlacesRepoImpl extends TripPlacesRepo {
  final ApiConsumer api;

  TripPlacesRepoImpl({required this.api});
  @override
  Future<Either<String, TripPlacesModel>> getTripPlaces(int tripId) async {
    try {
      var response = await api.get(EndPoint.getTripPlaces(tripId: tripId));
      final TripPlacesModel tripPlaces = TripPlacesModel.fromJson(response);
      return right(tripPlaces);
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }
}
