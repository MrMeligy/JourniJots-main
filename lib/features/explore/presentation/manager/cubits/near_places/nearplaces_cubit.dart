import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/explore/data/near_by_place_model/near_by_place_model.dart';
import 'package:journijots/features/explore/presentation/manager/repos/nearby_places/nearby_places_repo.dart';

part 'nearplaces_state.dart';

class NearplacesCubit extends Cubit<NearplacesState> {
  NearplacesCubit(this.nearbyPlacesRepo) : super(NearplacesInitial());
  final NearbyPlacesRepo nearbyPlacesRepo;
  getNearPlaces({required final city}) async {
    emit(NearplacesLoading());
    final response = await nearbyPlacesRepo.nearbyPlaces(
      city: city,
    );
    response.fold(
      (err) => emit(NearplacesFailure(errMessage: err)),
      (places) => emit(
        NearplacesSuccess(places: places),
      ),
    );
  }
}
