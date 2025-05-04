import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/explore/data/places_count.dart';
import 'package:journijots/features/explore/presentation/manager/repos/places_count/places_count_repo.dart';

part 'places_count_state.dart';

class PlacesCountCubit extends Cubit<PlacesCountState> {
  PlacesCountCubit(this.placesCountRepo) : super(PlacesCountInitial());
  final PlacesCountRepo placesCountRepo;
  getPlacesCount({required city}) async {
    emit(PlacesCountLoading());
    var response = await placesCountRepo.getPlacesCount(city: city);
    response.fold(
      (err) => emit(PlacesCountFailure(err: err)),
      (placesCount) => emit(
        PlacesCountSuccess(placesCount: placesCount),
      ),
    );
  }
}
