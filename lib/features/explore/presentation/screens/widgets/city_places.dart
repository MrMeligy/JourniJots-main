import 'package:flutter/material.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/place_card.dart';

class CityPlaces extends StatelessWidget {
  const CityPlaces({
    super.key,
    required this.city,
    required this.desc,
    required this.places,
  });

  final String city;
  final String desc;
  final List<PlaceModel> places;

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
              child: PlaceCard(placeModel: places[index]),
            );
          },
        ),
      ],
    );
  }
}
