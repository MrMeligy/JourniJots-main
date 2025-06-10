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
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Image with enhanced styling
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 91, 132, 175).withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: ImageHandler(
                imageUrl: widget.placeModel.image,
              ),
            ),
          ),

          // Place name with enhanced styling
          Container(
            margin: EdgeInsets.all(20.w),
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 91, 132, 175).withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              widget.placeModel.name!,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Info cards with enhanced design
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: const Color.fromARGB(255, 141, 187, 240)),
            ),
            child: Column(
              children: [
                // City info
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: PlaceInfoElement(
                    text: widget.placeModel.city!,
                    textSize: 18.sp,
                    icon: Icons.location_city,
                  ),
                ),

                SizedBox(height: 16.h),

                // Rating and count row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: PlaceInfoElement(
                          text:
                              truncateToFirstDecimal(widget.placeModel.rating!)
                                  .toString(),
                          textSize: 18.sp,
                          icon: Icons.star_rate_rounded,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: PlaceInfoElement(
                          text: (isRated)
                              ? (widget.placeModel.ratingCount!.toInt() + 1)
                                  .toString()
                              : widget.placeModel.ratingCount.toString(),
                          textSize: 18.sp,
                          icon: Icons.people,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Address info
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: PlaceInfoElement(
                    text: widget.placeModel.address ?? "Address not available",
                    icon: Icons.location_pin,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30.h),

          // Rating section with enhanced design
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kprimarycolor.withOpacity(0.05),
                  kprimarycolor.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: kprimarycolor.withOpacity(0.2)),
            ),
            child: (isRated)
                ? Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 40.sp,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        "Thanks for your rating!",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        "Rate this place",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: StarRating(
                          rating: rating,
                          filledIcon: Icons.star,
                          halfFilledIcon: Icons.star_border,
                          emptyIcon: Icons.star_outline,
                          color: kprimarycolor,
                          borderColor: Colors.grey,
                          onRatingChanged: (rating) => setState(() {
                            this.rating = rating;
                          }),
                        ),
                      ),
                      SizedBox(height: 20.h),
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
                          height: 55.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                kprimarycolor,
                                kprimarycolor.withOpacity(0.8)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: kprimarycolor.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Rate Now",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ),

          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
