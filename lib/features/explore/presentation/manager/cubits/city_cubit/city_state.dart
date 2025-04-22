part of 'city_cubit.dart';

sealed class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

final class CityInitial extends CityState {}

final class CityLoading extends CityState {}

final class CitySuccess extends CityState {
  final List<PlaceModel> places;

  const CitySuccess({required this.places});
}

final class CityActivitiesSuccess extends CityState {
  final List<PlaceModel> activities;

  const CityActivitiesSuccess({required this.activities});
}

final class CityFailure extends CityState {
  final String err;

  const CityFailure({required this.err});
}

final class CityRestaurantsSuccess extends CityState {
  final List<PlaceModel> restaurants;

  const CityRestaurantsSuccess({required this.restaurants});
}

final class CityHotelsSuccess extends CityState {
  final List<PlaceModel> hotels;

  const CityHotelsSuccess({required this.hotels});
}
