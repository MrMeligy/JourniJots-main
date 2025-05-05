import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/trip/data/trip_model.dart';
import 'package:journijots/features/trip/presentation/managers/repos/add_trip_repo.dart';

part 'add_trip_state.dart';

class AddTripCubit extends Cubit<AddTripState> {
  final AddTripRepo addTripRepo;
  AddTripCubit(this.addTripRepo) : super(AddTripInitial());

  addTrip({required String city, required String date}) async {
    emit(AddTripLoading());
    var response = await addTripRepo.addTrip(city: city, date: date);
    response.fold(
      (err) => emit(AddTripFailure(err: err)),
      (tripModel) => emit(
        AddTripSuccess(tripModel: tripModel),
      ),
    );
  }
}
