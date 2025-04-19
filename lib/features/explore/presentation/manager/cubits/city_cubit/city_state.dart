part of 'city_cubit.dart';

sealed class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

final class CityInitial extends CityState {}

final class CityLoading extends CityState {}

final class CityActivitiesSuccess extends CityState {
  final List<ActivityModel> activities;

  const CityActivitiesSuccess({required this.activities});
}

final class CityFailure extends CityState {
  final String err;

  const CityFailure({required this.err});
}

final class CityRestaurantsSuccess extends CityState {
  final List<RestaurantModel> restaurants;

  const CityRestaurantsSuccess({required this.restaurants});
}

final class CityHotelsSuccess extends CityState {
  final List<HotelModel> hotels;

  const CityHotelsSuccess({required this.hotels});
}
