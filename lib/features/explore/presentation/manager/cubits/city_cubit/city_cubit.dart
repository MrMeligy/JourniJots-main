import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journijots/features/explore/data/activities_model/activity_model.dart';
import 'package:journijots/features/explore/data/hotel_model/hotel_model.dart';
import 'package:journijots/features/explore/data/restaurant_model/restaurant_model.dart';
import 'package:journijots/features/explore/presentation/manager/repos/city_repo.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit(this.cityRepo) : super(CityInitial());
  final CityRepo cityRepo;
  getActivities({required String city}) async {
    emit(CityLoading());
    final response = await cityRepo.getCityActivity(city: city);
    response.fold(
      (err) => emit(CityFailure(err: err)),
      (activities) => emit(CityActivitiesSuccess(activities: activities)),
    );
  }

  getRestaurants({required String city}) async {
    emit(CityLoading());
    final response = await cityRepo.getCityRestaurants(city: city);
    response.fold(
      (err) => emit(CityFailure(err: err)),
      (restaurants) => emit(CityRestaurantsSuccess(restaurants: restaurants)),
    );
  }

  getHotels({required String city}) async {
    emit(CityLoading());
    final response = await cityRepo.getCityHotels(city: city);
    response.fold(
      (err) => emit(CityFailure(err: err)),
      (hotels) => emit(CityHotelsSuccess(hotels: hotels)),
    );
  }
}
