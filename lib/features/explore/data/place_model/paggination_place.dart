import 'package:equatable/equatable.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';

class PagginationPlace extends Equatable {
  final int? pageNumber;
  final int? pageSize;
  final bool? hasNext;
  final List<PlaceModel>? places;

  const PagginationPlace({
    this.pageNumber,
    this.pageSize,
    this.hasNext,
    this.places,
  });

  factory PagginationPlace.fromJson(Map<String, dynamic> json) {
    return PagginationPlace(
      pageNumber: json['pageNumber'] as int?,
      pageSize: json['pageSize'] as int?,
      hasNext: json['hasNext'] as bool?,
      places: (json['data'] as List<dynamic>?)
          ?.map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'pageNumber': pageNumber,
        'pageSize': pageSize,
        'hasNext': hasNext,
        'places': places?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      pageNumber,
      pageSize,
      hasNext,
      places,
    ];
  }
}
