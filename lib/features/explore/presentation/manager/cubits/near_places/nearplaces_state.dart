part of 'nearplaces_cubit.dart';

sealed class NearplacesState extends Equatable {
  const NearplacesState();

  @override
  List<Object> get props => [];
}

final class NearplacesInitial extends NearplacesState {}

final class NearplacesLoading extends NearplacesState {}

final class NearplacesSuccess extends NearplacesState {
  final List<NearByPlaceModel> places;

  const NearplacesSuccess({required this.places});
}

final class NearplacesFailure extends NearplacesState {
  final String errMessage;

  const NearplacesFailure({required this.errMessage});
}
