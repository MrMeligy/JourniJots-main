import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/helper/extensions.dart';
import 'package:journijots/core/routes/routes.dart';
import 'package:journijots/core/utils/text_styles.dart';

class PostProfile extends StatelessWidget {
  const PostProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.profileScreen);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              "assets/images/pp.jpg",
              fit: BoxFit.cover,
              width: 60.w,
              height: 60.h,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Karius",
                style: TextStyles.font22black,
              ),
              Text(
                "2h ago",
                style: TextStyles.font16grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
