import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/features/trip/data/trip_model.dart';
import 'package:journijots/features/trip/presentation/managers/repos/add_trip_repo.dart';

class AddTripRepoImpl extends AddTripRepo {
  final ApiConsumer api;

  AddTripRepoImpl({required this.api});
  @override
  Future<Either<String, TripModel>> addTrip(
      {required String city, required String date}) async {
    try {
      final response = await api.post(EndPoint.addTrip(), data: {
        ApiKey.city: city,
        ApiKey.startDate: date,
      });

      final trip = TripModel.fromJson(response);
      return (right(trip));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }
}
