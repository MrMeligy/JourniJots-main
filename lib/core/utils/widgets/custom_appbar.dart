import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.color,
    this.titleColor = kprimarycolor,
    this.iconColor,
    this.leading,
    this.icon = true,
  });
  final IconButton? leading;
  final String? title;
  final Color? color, titleColor, iconColor;
  final bool? icon;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      toolbarHeight: preferredSize.height,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
      title: Text(
        title ?? "Home",
        style: TextStyle(
          fontSize: 40.sp,
          color: titleColor,
        ),
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: leading ??
            Image.asset(
              "assets/images/logo.png",
            ),
      ),
      actions: [
        (icon ?? false)
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.notifications_on_outlined,
                  size: 35.h,
                  color: iconColor,
                ),
              )
            : const Padding(padding: EdgeInsets.only(right: 8))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
