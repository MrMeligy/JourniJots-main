import 'package:dartz/dartz.dart';
import 'package:journijots/core/api/api_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/errors/exceptions.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';
import 'package:journijots/features/place/presentation/manager/repos/place_repo.dart';

class PlaceRepoImpl extends PlaceRepo {
  final ApiConsumer api;

  PlaceRepoImpl({required this.api});
  @override
  Future<Either<String, PlaceModel>> getPlace(int placeId) async {
    try {
      var response = await api.get(EndPoint.getPlace(placeId: placeId));
      final PlaceModel place = PlaceModel.fromJson(response);
      return right(place);
    } on ServerException catch (e) {
      return (left(e.errModel.errorMessage));
    }
  }
}
