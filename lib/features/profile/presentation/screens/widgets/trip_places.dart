import 'package:flutter/material.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/place_card_trip.dart';
import 'package:journijots/features/trip/data/trip_places_model/activity.dart';
import 'package:journijots/features/trip/data/trip_places_model/hotel.dart';
import 'package:journijots/features/trip/data/trip_places_model/restaurant.dart';

class TripPlaces extends StatelessWidget {
  const TripPlaces({
    super.key,
    required this.city,
    required this.desc,
    this.activities,
    this.restaurants,
    this.hotels,
  });

  final String city;
  final String desc;
  final List<Activity>? activities;
  final List<Restaurant>? restaurants;
  final List<Hotel>? hotels;
  List<PlaceCardTrip> get places {
    List<PlaceCardTrip> placeCards = [];

    if (activities != null) {
      for (var activity in activities!) {
        placeCards.add(PlaceCardTrip(
          image: activity.image,
          name: activity.name!,
          rating: activity.rating!,
          address: activity.address!,
          city: city,
          ratingCount: activity.ratingCount!,
        ));
      }
    }

    if (restaurants != null) {
      for (var restaurant in restaurants!) {
        placeCards.add(PlaceCardTrip(
          image: restaurant.image,
          name: restaurant.name!,
          rating: restaurant.rating!,
          address: restaurant.address!,
          city: city,
          ratingCount: restaurant.ratingCount!,
        ));
      }
    }

    if (hotels != null) {
      for (var hotel in hotels!) {
        placeCards.add(PlaceCardTrip(
          image: hotel.image,
          name: hotel.name!,
          rating: hotel.rating!,
          address: hotel.address!,
          city: city,
          ratingCount: hotel.ratingCount!,
        ));
      }
    }

    return placeCards;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // List of places
        ListView.builder(
          shrinkWrap:
              true, // Allows the ListView to take only the space it needs
          physics:
              const NeverScrollableScrollPhysics(), // Disable internal scrolling of ListView
          itemCount: places.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlaceCardTrip(
                image: places[index].image,
                name: places[index].name,
                rating: places[index].rating,
                address: places[index].address,
                city: places[index].city,
                ratingCount: places[index].ratingCount,
              ),
            );
          },
        ),
      ],
    );
  }
}
