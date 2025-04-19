import 'package:flutter/material.dart';
import 'package:journijots/features/explore/data/activities_model/activity_model.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/activity_card.dart';

class CityActivties extends StatelessWidget {
  const CityActivties({
    super.key,
    required this.city,
    required this.desc,
    required this.activities,
  });

  final String city;
  final String desc;
  final List<ActivityModel> activities;

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
          itemCount: activities.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ActivityCard(activityModel: activities[index]),
            );
          },
        ),
      ],
    );
  }
}
