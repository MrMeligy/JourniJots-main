import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/funcs/date_time_func.dart';
import 'package:journijots/core/utils/text_styles.dart';
import 'package:journijots/features/home/presentation/screens/widgets/profile_picture.dart';
import 'package:journijots/features/profile/data/profile_model/post.dart';
import 'package:journijots/features/profile/data/profile_model/profile_model.dart';

class PostProfile extends StatelessWidget {
  const PostProfile({
    super.key,
    required this.profileModel,
    required this.post,
  });
  final ProfileModel profileModel;
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePicture(picture: profileModel.profilePicture),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profileModel.userName!,
              style: TextStyles.font22black,
            ),
            Text(
              formatTimeAgo(DateTime.parse(post.createdAt.toString())),
              style: TextStyles.font16grey,
            )
          ],
        )
      ],
    );
  }
}
