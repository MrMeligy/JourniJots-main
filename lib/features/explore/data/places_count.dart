import 'package:equatable/equatable.dart';

class PlacesCount extends Equatable {
  final int? activitiesCount;
  final int? restaurantsCount;
  final int? hotelsCount;

  const PlacesCount({
    this.activitiesCount,
    this.restaurantsCount,
    this.hotelsCount,
  });

  factory PlacesCount.fromJson(Map<String, dynamic> json) => PlacesCount(
        activitiesCount: json['activitiesCount'] as int?,
        restaurantsCount: json['restaurantsCount'] as int?,
        hotelsCount: json['hotelsCount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'activitiesCount': activitiesCount,
        'restaurantsCount': restaurantsCount,
        'hotelsCount': hotelsCount,
      };

  @override
  List<Object?> get props {
    return [
      activitiesCount,
      restaurantsCount,
      hotelsCount,
    ];
  }
}
