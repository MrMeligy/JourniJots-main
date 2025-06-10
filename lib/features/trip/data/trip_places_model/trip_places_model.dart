import 'package:equatable/equatable.dart';

import 'activity.dart';
import 'hotel.dart';
import 'restaurant.dart';

class TripPlacesModel extends Equatable {
  final int? tripId;
  final String? cityTrip;
  final String? startDate;
  final List<Activity>? activities;
  final List<Restaurant>? restaurants;
  final List<Hotel>? hotels;

  const TripPlacesModel({
    this.tripId,
    this.cityTrip,
    this.startDate,
    this.activities,
    this.restaurants,
    this.hotels,
  });

  factory TripPlacesModel.fromJson(Map<String, dynamic> json) {
    return TripPlacesModel(
      tripId: json['tripId'] as int?,
      cityTrip: json['cityTrip'] as String?,
      startDate: json['startDate'] as String?,
      activities: (json['activities'] as List<dynamic>?)
          ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList(),
      restaurants: (json['restaurants'] as List<dynamic>?)
          ?.map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
          .toList(),
      hotels: (json['hotels'] as List<dynamic>?)
          ?.map((e) => Hotel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'tripId': tripId,
        'cityTrip': cityTrip,
        'startDate': startDate,
        'activities': activities?.map((e) => e.toJson()).toList(),
        'restaurants': restaurants?.map((e) => e.toJson()).toList(),
        'hotels': hotels?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      tripId,
      cityTrip,
      startDate,
      activities,
      restaurants,
      hotels,
    ];
  }
}
