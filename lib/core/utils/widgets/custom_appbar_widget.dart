import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';

class CustomAppBarWidget extends StatelessWidget {
  final IconButton? leading;
  final String? title;
  final Color? color, titleColor, iconColor;
  final bool? icon;

  const CustomAppBarWidget({
    super.key,
    this.title,
    this.color,
    this.titleColor = kprimarycolor,
    this.iconColor,
    this.leading,
    this.icon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *
          0.1222.h, // fixed height like AppBar
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading ??
              Image.asset(
                "assets/images/logo.png",
                height: 35,
              ),
          Expanded(
            child: Center(
              child: Text(
                title ?? "Home",
                style: TextStyle(
                  fontSize: 40.sp,
                  color: titleColor,
                ),
              ),
            ),
          ),
          (icon ?? false)
              ? Icon(
                  Icons.notifications_on_outlined,
                  size: 35.h,
                  color: iconColor,
                )
              : const SizedBox(width: 35), // to preserve space
        ],
      ),
    );
  }
}
