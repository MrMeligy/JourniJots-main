import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/api/dio_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/funcs/doubles_rates.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';
import 'package:journijots/features/explore/presentation/screens/widgets/image_handler.dart';
import 'package:journijots/features/place/presentation/screens/widgets/place_info_elemnt.dart';

class PlaceInfo extends StatefulWidget {
  const PlaceInfo({
    super.key,
    required this.placeModel,
  });
  final PlaceModel placeModel;

  @override
  State<PlaceInfo> createState() => _PlaceInfoState();
}

class _PlaceInfoState extends State<PlaceInfo> {
  double rating = 0;
  int ratingCount = 0;
  bool isRated = false;

  @override
  void initState() {
    super.initState();
    ratingCount = widget.placeModel.ratingCount ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          child: ImageHandler(
            imageUrl: widget.placeModel.image,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.placeModel.name!,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PlaceInfoElement(
            text: widget.placeModel.city!,
            textSize: 24.sp,
            icon: Icons.location_city,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 70,
                child: PlaceInfoElement(
                  text: truncateToFirstDecimal(widget.placeModel.rating!)
                      .toString(),
                  textSize: 22.sp,
                  icon: Icons.star,
                ),
              ), // Space between rating and count
              SizedBox(
                width: 150,
                child: PlaceInfoElement(
                  text: (isRated)
                      ? (widget.placeModel.ratingCount!.toInt() + 1).toString()
                      : widget.placeModel.ratingCount.toString(),
                  textSize: 22.sp,
                  icon: Icons.people,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PlaceInfoElement(
            text: widget.placeModel.address ?? "Address not available",
            icon: Icons.location_pin,
          ),
        ),
        (isRated)
            ? Text(
                "Thanks for your rating",
                style: TextStyle(fontSize: 20.sp),
              )
            : Column(
                children: [
                  Text(
                    "Rate this place",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  StarRating(
                    rating: rating,
                    filledIcon: Icons.star,
                    halfFilledIcon: Icons.star_border,
                    emptyIcon: Icons.star_outline,
                    color:
                        kprimarycolor, // Color for filled and half-filled icons
                    borderColor: Colors.grey, // Color for empty icons
                    onRatingChanged: (rating) => setState(() {
                      this.rating = rating;
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      ratingCount += 1;
                      isRated = true;
                      setState(() {});
                      await getIt<DioConsumer>().post(
                        EndPoint.rate(),
                        data: {
                          "placeId": widget.placeModel.id,
                          "rate": rating.toInt(),
                          "type": widget.placeModel.type,
                        },
                      );
                    },
                    child: Container(
                      height: 50.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                        color: kprimarycolor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Rate",
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ],
    );
  }
}
