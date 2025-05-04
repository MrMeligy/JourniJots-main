part of 'places_count_cubit.dart';

sealed class PlacesCountState extends Equatable {
  const PlacesCountState();

  @override
  List<Object> get props => [];
}

final class PlacesCountInitial extends PlacesCountState {}

final class PlacesCountLoading extends PlacesCountState {}

final class PlacesCountSuccess extends PlacesCountState {
  final PlacesCount placesCount;

  const PlacesCountSuccess({required this.placesCount});
}

final class PlacesCountFailure extends PlacesCountState {
  final String err;

  const PlacesCountFailure({required this.err});
}
