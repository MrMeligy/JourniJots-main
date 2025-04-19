import 'package:flutter/material.dart';
import 'package:journijots/features/explore/data/restaurant_model/restaurant_model.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/restaurant_card.dart';

class CityRestaurants extends StatelessWidget {
  const CityRestaurants({
    super.key,
    required this.city,
    required this.desc,
    required this.restaurants,
  });

  final String city;
  final String desc;
  final List<RestaurantModel> restaurants;

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
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RestaurantCard(restaurantModel: restaurants[index]),
            );
          },
        ),
      ],
    );
  }
}
