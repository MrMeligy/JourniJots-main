import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';
import 'package:journijots/features/place/presentation/manager/repos/place_repo.dart';

part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit(this.placeRepo) : super(PlaceInitial());
  final PlaceRepo placeRepo;
  getPlace(int placeId) async {
    emit(PlaceLoading());
    final response = await placeRepo.getPlace(placeId);
    response.fold(
      (errMessage) => emit(PlaceFailure(errorMessage: errMessage)),
      (place) => emit(PlaceSuccess(place: place)),
    );
  }
}
