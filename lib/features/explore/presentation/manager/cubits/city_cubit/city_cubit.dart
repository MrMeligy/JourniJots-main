import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/explore/data/place_model/paggination_place.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';
import 'package:journijots/features/explore/presentation/manager/repos/city/city_repo.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit(this.cityRepo) : super(CityInitial());
  final CityRepo cityRepo;
  getActivities({required String city, required String pageNum}) async {
    emit(CityLoading());
    final response = await cityRepo.getCityActivity(city: city, num: pageNum);
    response.fold(
      (err) => emit(CityFailure(err: err)),
      (activities) => emit(
        CitySuccess(places: activities.value1, pagDetails: activities.value2),
      ),
    );
  }

  getRestaurants({required String city, required String pageNum}) async {
    emit(CityLoading());
    final response =
        await cityRepo.getCityRestaurants(city: city, num: pageNum);
    response.fold(
      (err) => emit(CityFailure(err: err)),
      (restaurants) => emit(
        CitySuccess(
          places: restaurants.value1,
          pagDetails: restaurants.value2,
        ),
      ),
    );
  }

  getHotels({required String city, required String pageNum}) async {
    emit(CityLoading());
    final response = await cityRepo.getCityHotels(city: city, num: pageNum);
    response.fold(
      (err) => emit(CityFailure(err: err)),
      (hotels) => emit(
        CitySuccess(
          places: hotels.value1,
          pagDetails: hotels.value2,
        ),
      ),
    );
  }
}
