import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';

class PostButton extends StatelessWidget {
  const PostButton({
    super.key,
    required this.text,
    this.color,
    required this.iconData,
    this.onTap,
  });
  final String text;
  final Color? color;
  final IconData iconData;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color ?? kprimarycolor,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Row(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: 20.w,
              color: kbodycolor,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
