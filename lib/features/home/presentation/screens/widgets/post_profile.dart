import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/helper/extensions.dart';
import 'package:journijots/core/routes/routes.dart';
import 'package:journijots/core/utils/text_styles.dart';
import 'package:journijots/core/utils/widgets/image_base.dart';
import 'package:journijots/features/home/data/post_model/post_model.dart';

class PostProfile extends StatelessWidget {
  const PostProfile({
    super.key,
    required this.postModel,
  });
  final PostModel postModel;
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
            child: Base64Image(
              base64String:
                  postModel.profilePicture, // Paste your full base64 string
              width: 60.w,
              height: 60.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                postModel.userName!,
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
