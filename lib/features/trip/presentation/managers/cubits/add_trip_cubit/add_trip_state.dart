part of 'add_trip_cubit.dart';

sealed class AddTripState extends Equatable {
  const AddTripState();

  @override
  List<Object> get props => [];
}

final class AddTripInitial extends AddTripState {}

final class AddTripLoading extends AddTripState {}

final class AddTripSuccess extends AddTripState {
  final TripModel tripModel;

  const AddTripSuccess({required this.tripModel});
}

final class AddTripFailure extends AddTripState {
  final String err;

  const AddTripFailure({required this.err});
}
