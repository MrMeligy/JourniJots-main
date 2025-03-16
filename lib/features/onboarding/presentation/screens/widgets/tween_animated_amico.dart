import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TweenAnimatedAmico extends StatelessWidget {
  const TweenAnimatedAmico({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1000),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Padding(
            padding: EdgeInsets.only(top: value * 20.h),
            child: child,
          ),
        );
      },
      child: Image.asset(
        imageUrl,
        width: double.infinity,
      ),
    );
  }
}
