part of 'trip_places_cubit.dart';

sealed class TripPlacesState extends Equatable {
  const TripPlacesState();

  @override
  List<Object> get props => [];
}

final class TripPlacesInitial extends TripPlacesState {}

final class TripPlacesLoading extends TripPlacesState {}

final class TripPlacesSuccess extends TripPlacesState {
  final TripPlacesModel tripPlaces;
  const TripPlacesSuccess({required this.tripPlaces});

  @override
  List<Object> get props => [tripPlaces];
}

final class TripPlacesFailure extends TripPlacesState {
  final String errorMessage;
  const TripPlacesFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
