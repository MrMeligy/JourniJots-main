import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';
import 'package:journijots/features/explore/presentation/manager/repos/city/city_repo.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit(this.cityRepo) : super(CityInitial());
  final CityRepo cityRepo;
  getActivities({required String city}) async {
    emit(CityLoading());
    final response = await cityRepo.getCityActivity(city: city);
    response.fold(
      (err) => emit(CityFailure(err: err)),
      (activities) => emit(CitySuccess(places: activities)),
    );
  }

  getRestaurants({required String city}) async {
    emit(CityLoading());
    final response = await cityRepo.getCityRestaurants(city: city);
    response.fold(
      (err) => emit(CityFailure(err: err)),
      (restaurants) => emit(CitySuccess(places: restaurants)),
    );
  }

  getHotels({required String city}) async {
    emit(CityLoading());
    final response = await cityRepo.getCityHotels(city: city);
    response.fold(
      (err) => emit(CityFailure(err: err)),
      (hotels) => emit(CitySuccess(places: hotels)),
    );
  }
}
