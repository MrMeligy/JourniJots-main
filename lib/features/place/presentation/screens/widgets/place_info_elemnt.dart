import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceInfoElement extends StatelessWidget {
  const PlaceInfoElement({
    super.key,
    required this.text,
    required this.icon,
    this.textSize,
  });
  final String text;
  final IconData icon;
  final double? textSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 30,
        ),
        SizedBox(
          width: 5.w,
        ),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
                fontSize: textSize ?? 18.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
