import 'package:flutter/material.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/card_skeltonizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CitySkeltonizer extends StatelessWidget {
  const CitySkeltonizer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      ignoreContainers: true,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          SkltPlaceCard(),
          SkltPlaceCard(),
          SkltPlaceCard(),
          SkltPlaceCard(),
        ],
      ),
    );
  }
}
