import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/funcs/doubles_rates.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/image_handler.dart';

class PlaceCardTrip extends StatelessWidget {
  final String? image;
  final String name;
  final double rating;
  final String address;
  final String city;
  final int ratingCount;

  const PlaceCardTrip({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.address,
    required this.city,
    required this.ratingCount,
  });

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
              imageUrl: image,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
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
                    address.isNotEmpty ? address : city,
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
                      truncateToFirstDecimal(rating).toString(),
                      style: TextStyle(
                        fontSize: 24.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 26.w,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      ratingCount.toString(),
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
