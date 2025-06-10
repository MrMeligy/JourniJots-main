import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/funcs/doubles_rates.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/image_handler.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    super.key,
    required this.placeModel,
  });
  final PlaceModel placeModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 6,
            offset: Offset(15, 12), // Shadow position
          ),
        ],
        color: kbodycolor,
        border: Border.all(
          color: Colors.black54,
          width: 3,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            child: ImageHandler(
              imageUrl: placeModel.image,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              placeModel.name!,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_pin,
                  size: 26.w,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Flexible(
                  child: Text(
                    placeModel.address ?? placeModel.city!,
                    style: TextStyle(
                      fontSize: 19.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 26.w,
                    ),
                    Text(
                      truncateToFirstDecimal(placeModel.rating!).toString(),
                      style: TextStyle(
                        fontSize: 24.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 3.w,
                  children: [
                    Icon(
                      Icons.people,
                      size: 26.w,
                    ),
                    Text(
                      placeModel.ratingCount.toString(),
                      style: TextStyle(
                        fontSize: 24.sp,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
