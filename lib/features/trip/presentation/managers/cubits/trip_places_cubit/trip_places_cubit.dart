import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/trip/data/trip_places_model/trip_places_model.dart';
import 'package:journijots/features/trip/presentation/managers/repos/trip_places_repo/trip_places_repo.dart';

part 'trip_places_state.dart';

class TripPlacesCubit extends Cubit<TripPlacesState> {
  TripPlacesCubit(this.tripPlacesRepo) : super(TripPlacesInitial());
  final TripPlacesRepo tripPlacesRepo;
  getTripPlaces({required int tripId}) async {
    emit(TripPlacesLoading());
    final result = await tripPlacesRepo.getTripPlaces(tripId);
    result.fold(
      (errorMessage) => emit(TripPlacesFailure(errorMessage: errorMessage)),
      (tripPlaces) => emit(TripPlacesSuccess(tripPlaces: tripPlaces)),
    );
  }
}
