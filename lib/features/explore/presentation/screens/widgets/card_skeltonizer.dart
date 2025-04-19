import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/text_styles.dart';

class SkltPlaceCard extends StatelessWidget {
  const SkltPlaceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
            color: Colors.grey, // Placeholder color for skeleton
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff224A67),
                Color(0xff4493CD),
              ]),
              borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
            ),
            height: MediaQuery.of(context).size.height * 0.15,
            child: Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  // This is necessary to prevent overflow
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Activity Name", // Simplified placeholder text
                          style: TextStyles.font18White,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Colors.white,
                              size: 22.w,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                              // Added Expanded to prevent text overflow
                              child: Text(
                                "City Name", // Simplified placeholder text
                                style: TextStyles.font18White,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize:
                                  MainAxisSize.min, // Take only needed space
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 22.w,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "4.5", // Simplified placeholder text
                                  style: TextStyles.font18White,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize:
                                  MainAxisSize.min, // Take only needed space
                              children: [
                                Icon(
                                  Icons.people_alt,
                                  size: 22.h,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text(
                                  "1500",
                                  style: TextStyles.font18White,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
