import 'package:flutter/material.dart';
import 'package:journijots/core/utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
      title: const Text(
        "Home",
        style: TextStyle(
          fontSize: 40,
          color: kprimarycolor,
        ),
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Image.asset(
          "assets/images/logo.png",
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(
            Icons.notifications_on_outlined,
            size: 35,
            color: Color(0xff1C366E),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
