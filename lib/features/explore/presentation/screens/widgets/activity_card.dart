// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:journijots/core/utils/text_styles.dart';
import 'package:journijots/features/explore/data/activities_model/activity_model.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    required this.activityModel,
  });
  final ActivityModel activityModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
          ),
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.15,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: activityModel.image!,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
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
                  // Added Expanded to prevent overflow
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activityModel.name!,
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
                                activityModel.city!,
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
                                  activityModel.rating.toString(),
                                  style: TextStyles.font18White,
                                ),
                              ],
                            ),
                            Row(
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
                                  "${activityModel.ratingCount}",
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
