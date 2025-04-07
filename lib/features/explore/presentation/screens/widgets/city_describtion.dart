import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';

class CityDiscribtion extends StatelessWidget {
  const CityDiscribtion({
    super.key,
    required this.city,
    required this.subtitle,
  });
  final String city;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          city,
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: kprimarycolor),
        ),
        SizedBox(height: 5.h),
        Text(
          subtitle,
          style: TextStyle(
            color: kprimarycolor,
            fontSize: 15.sp,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
