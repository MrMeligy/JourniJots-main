import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCount extends StatelessWidget {
  final String category, image;
  final int count;
  const CategoryCount({
    super.key,
    required this.category,
    required this.image,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: 130.w,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff149FEA),
            Color(0xff1D6EA9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: TextStyle(
                color: Colors.white,
                fontSize: 21.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              count.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 21.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(image),
            ),
          ],
        ),
      ),
    );
  }
}
