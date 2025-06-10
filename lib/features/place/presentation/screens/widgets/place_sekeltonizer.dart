import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceSkeletonizer extends StatelessWidget {
  const PlaceSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16.h),
          Container(
            height: 30.h,
            width: 200.w,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16.h),
          Container(
            height: 24.h,
            width: 120.w,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16.h),
          Container(
            height: 24.h,
            width: 180.w,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
