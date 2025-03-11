import 'package:flutter/material.dart';
import 'package:journijots/core/utils/constants.dart';

class InterestContainer extends StatelessWidget {
  const InterestContainer({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: kscaffoldcolor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: kbodycolor,
                  fontSize: 23,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
