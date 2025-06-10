part of 'place_cubit.dart';

sealed class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object> get props => [];
}

final class PlaceInitial extends PlaceState {}

final class PlaceLoading extends PlaceState {}

final class PlaceSuccess extends PlaceState {
  final PlaceModel place;
  const PlaceSuccess({required this.place});
}

final class PlaceFailure extends PlaceState {
  final String errorMessage;
  const PlaceFailure({required this.errorMessage});
}
