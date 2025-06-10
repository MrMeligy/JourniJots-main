import 'package:equatable/equatable.dart';

import 'activity.dart';
import 'hotel.dart';
import 'restaurant.dart';

class Trip extends Equatable {
  final int? id;
  final String? city;
  final String? startDate;
  final List<Activity>? activities;
  final List<Restaurant>? restaurants;
  final List<Hotel>? hotels;

  const Trip({
    this.id,
    this.city,
    this.startDate,
    this.activities,
    this.restaurants,
    this.hotels,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json['id'] as int?,
        city: json['city'] as String?,
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'city': city,
        'startDate': startDate,
        'activities': activities?.map((e) => e.toJson()).toList(),
        'restaurants': restaurants?.map((e) => e.toJson()).toList(),
        'hotels': hotels?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      city,
      startDate,
      activities,
      restaurants,
      hotels,
    ];
  }
}
