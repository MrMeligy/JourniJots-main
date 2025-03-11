import 'activity.dart';
import 'hotel.dart';
import 'restaurant.dart';

class TripModel {
  String? tripTitle;
  List<Activity>? activities;
  List<Restaurant>? restaurants;
  List<Hotel>? hotels;

  TripModel({
    this.tripTitle,
    this.activities,
    this.restaurants,
    this.hotels,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        tripTitle: json['tripTitle'] as String?,
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

  Map<String, dynamic> toJson() => {
        'tripTitle': tripTitle,
        'activities': activities?.map((e) => e.toJson()).toList(),
        'restaurants': restaurants?.map((e) => e.toJson()).toList(),
        'hotels': hotels?.map((e) => e.toJson()).toList(),
      };
}
