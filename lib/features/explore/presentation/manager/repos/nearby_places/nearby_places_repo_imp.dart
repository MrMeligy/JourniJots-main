import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/features/explore/data/near_by_place_model/near_by_place_model.dart';
import 'package:journijots/features/explore/presentation/manager/repos/nearby_places/nearby_places_repo.dart';

class NearbyPlacesRepoImp extends NearbyPlacesRepo {
  final ApiConsumer api;

  NearbyPlacesRepoImp({required this.api});

  @override
  Future<Either<String, List<NearByPlaceModel>>> nearbyPlaces(
      {required String city}) async {
    try {
      var response = await api.get(
        EndPoint.getNearByPlaces(city: city),
      );
      final List<NearByPlaceModel> places = (response as List)
          .map((item) => NearByPlaceModel.fromJson(item))
          .toList();
      return (right(places));
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }
}
