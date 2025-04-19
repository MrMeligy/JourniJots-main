import 'package:flutter/material.dart';
import 'package:journijots/features/explore/data/hotel_model/hotel_model.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/hotel_card.dart';

class CityHotels extends StatelessWidget {
  const CityHotels({
    super.key,
    required this.city,
    required this.desc,
    required this.hotels,
  });

  final String city;
  final String desc;
  final List<HotelModel> hotels;

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
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: HotelCard(hotelModel: hotels[index]),
            );
          },
        ),
      ],
    );
  }
}
