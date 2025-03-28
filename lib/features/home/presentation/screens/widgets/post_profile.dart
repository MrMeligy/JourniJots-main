import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/funcs/date_time_func.dart';
import 'package:journijots/core/helper/extensions.dart';
import 'package:journijots/core/routes/routes.dart';
import 'package:journijots/core/utils/text_styles.dart';
import 'package:journijots/features/home/data/post_model/paginaton_post_model/post.dart';
// import 'package:journijots/features/home/data/post_model/post_model.dart';
import 'package:journijots/features/home/presentation/screens/widgets/profile_picture.dart';

class PostProfile extends StatelessWidget {
  const PostProfile({
    super.key,
    required this.postModel,
  });
  final Post postModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.profileScreen);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfilePicture(picture: postModel.profilePicture),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                postModel.userName,
                style: TextStyles.font22black,
              ),
              Text(
                formatTimeAgo(DateTime.parse(postModel.createdAt.toString())),
                style: TextStyles.font16grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
