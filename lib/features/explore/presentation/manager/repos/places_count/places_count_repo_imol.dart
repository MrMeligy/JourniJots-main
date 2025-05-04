import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/features/explore/data/places_count.dart';
import 'package:journijots/features/explore/presentation/manager/repos/places_count/places_count_repo.dart';

class PlacesCountRepoImol extends PlacesCountRepo {
  final ApiConsumer api;

  PlacesCountRepoImol({required this.api});
  @override
  Future<Either<String, PlacesCount>> getPlacesCount(
      {required String city}) async {
    try {
      var response = await api.get(
        EndPoint.getPlacesCount(city: city),
      );
      PlacesCount placesCount = PlacesCount.fromJson(response);

      return (right(placesCount));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }
}
