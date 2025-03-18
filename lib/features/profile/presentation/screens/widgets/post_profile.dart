import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/text_styles.dart';

class PostProfile extends StatelessWidget {
  const PostProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 4,
            ),
            image: const DecorationImage(
              image: AssetImage('assets/images/Ellipse 7.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Karius',
                  style: TextStyles.font22black,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.verified,
                  size: 14,
                  color: Colors.blue[400],
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              "2h ago",
              style: TextStyles.font16grey,
            )
          ],
        )
      ],
    );
  }
}
