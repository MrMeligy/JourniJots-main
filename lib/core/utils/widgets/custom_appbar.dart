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
      backgroundColor: color ?? const Color(0xFFFAFAFA),
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
        padding: const EdgeInsets.only(left: 5),
        child: leading ??
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
      ),
      actions: [
        (icon ?? false)
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              )
            : const Padding(padding: EdgeInsets.only(right: 8))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
